//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//


#import <Foundation/Foundation.h>

@interface SuperpoweredService: NSObject

@property (nonatomic, copy) void (^audioCompletion)(void);

- (instancetype)initWithKey:(NSString *)key;
- (void)setupMainPlayerWithPath:(NSString *)path;
- (void)onPlayPause;

@end
