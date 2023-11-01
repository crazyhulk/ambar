//
//  ApiManager.h
//  AMBar
//
//  Created by xizi on 2023/11/1.
//

#import <Foundation/Foundation.h>
#import "Music.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApiManager : NSObject

- (void) next;
- (void) prev;
- (void) playpause;
- (NSString *) currentTrackName;
- (MusicTrack *) currentTrack;
@end

NS_ASSUME_NONNULL_END
