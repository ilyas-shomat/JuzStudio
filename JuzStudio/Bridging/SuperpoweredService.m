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
#include "SuperpoweredAnalyzer.h"

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

- (void)setupMainPlayerWithPath:(NSString *)path {
    const char *pathInChar = [path UTF8String];

    mainPlayer = new Superpowered::AdvancedAudioPlayer(44100, 0);
    mainPlayer -> open(pathInChar);
        
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
    
    if (mainPlayer -> eofRecently()) {
        self -> _audioCompletion();
    }
    
    bool silence = !mainPlayer -> processStereo(output, false, numberOfFrames);
    
    return !silence;
}

//- (void)handleAudiosPlayingEnd {
//    __weak typeof(self) weakSelf = self;
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        __strong typeof(self) strongSelf = weakSelf;
//
//        if (strongSelf) {
//            while (!(strongSelf -> mainPlayer -> eofRecently())) {}
//            strongSelf -> _audioCompletion();
//        }
//    });
//}

@end
