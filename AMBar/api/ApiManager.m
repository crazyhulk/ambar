//
//  ApiManager.m
//  AMBar
//
//  Created by xizi on 2023/11/1.
//

#import "ApiManager.h"
#import "Music.h"

@interface ApiManager ()

@end


@implementation ApiManager

- (MusicApplication *) getAppClient {
    SBApplication *a = [[SBApplication alloc] initWithBundleIdentifier:@"com.apple.Music"];
    return (MusicApplication *)a;
}

- (void) prev {
    [[self getAppClient] previousTrack];
}

- (void) next {
    [[self getAppClient] nextTrack];
}

- (void) playpause {
    [[self getAppClient] playpause];
}

- (nonnull NSString *)currentTrackName {
    return [[[self getAppClient] currentTrack] name];
}

- (nonnull MusicTrack *)currentTrack {
    return [[self getAppClient] currentTrack];
}

@end
