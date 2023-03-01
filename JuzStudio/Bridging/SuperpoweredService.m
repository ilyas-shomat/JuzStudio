//
//  JuzStudio-Bridging-Impl.m
//  JuzStudio
//
//  Created by Ilyas Shomat on 22.02.2023.
//
#import "SuperpoweredService.h"

#include "Superpowered.h"
#include "SuperpoweredAdvancedAudioPlayer.h"
#include "SuperpoweredIOSAudioIO.h"

@implementation SuperpoweredService {
    Superpowered::AdvancedAudioPlayer *mainPlayer;
    SuperpoweredIOSAudioIO *outputIO;
    float bands[128][8];
    unsigned int bandsWritePos, bandsReadPos, bandsPos, lastNumberOfFrames;
}

static bool audioProcessing(void *clientdata, float *input, float *output, unsigned int numberOfFrames, unsigned int samplerate, uint64_t hostTime) {
    __unsafe_unretained SuperpoweredService *self = (__bridge SuperpoweredService *)clientdata;
    return [self audioProcessing:output numFrames:numberOfFrames samplerate:samplerate];
}

- (instancetype)initWithKey:(NSString *)key {
    if (self = [super init]) {
        const char *keyChars = [key UTF8String];
        Superpowered::Initialize(keyChars);
    }
    return self;
}

- (void)setupMainPlayer {
    mainPlayer = new Superpowered::AdvancedAudioPlayer(44100, 0);
    mainPlayer -> open([[[NSBundle mainBundle] pathForResource:@"lycka" ofType:@"mp3"] fileSystemRepresentation]);
    
    
    outputIO = [[SuperpoweredIOSAudioIO alloc] initWithDelegate:(id<SuperpoweredIOSAudioIODelegate>)self preferredBufferSize:12
                                            preferredSamplerate:44100
                                           audioSessionCategory:AVAudioSessionCategoryPlayback
                                                       channels:2
                                        audioProcessingCallback:audioProcessing
                                                     clientdata:(__bridge void *)self];
    
    
    [outputIO start];
}

- (void)onPlayPause {
    mainPlayer -> togglePlayback();
}


- (bool)audioProcessing:(float *)output numFrames:(unsigned int)numberOfFrames samplerate:(unsigned int)samplerate {
    mainPlayer -> outputSamplerate = samplerate;
    
    if (mainPlayer -> getLatestEvent() == Superpowered::AdvancedAudioPlayer::PlayerEvent_Opened) {
        
    }
    
    bool silence = !mainPlayer -> processStereo(output, false, numberOfFrames);
    
    return !silence;
}

- (void)getFrequencies:(float *)frequencies {
    memset(frequencies, 0, 8 * sizeof(float));
    
    unsigned int currentPosition = __sync_fetch_and_add(&bandsPos, 0);
    if (currentPosition > bandsReadPos) {
        unsigned int positionsElapsed = currentPosition - bandsReadPos;
        float multiplier = 1.0f / float(positionsElapsed * lastNumberOfFrames);
        while (positionsElapsed--) {
            float *b = &bands[bandsReadPos++ & 127][0];
            for (int n = 0; n < 8; n++) frequencies[n] += b[n] * multiplier;
        }
    }
}

@end
