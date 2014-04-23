#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MediaSetter.h"
#import "cutils.h"

//START BACKGROUNDING CODE

BOOL shouldPlay = FALSE;

%hook YTAppDelegate
-(BOOL)application:(id)app didFinishLaunchingWithOptions:(id)options {
    BOOL _orig = %orig(app, options);
    
    //set YouTube as first responder for the controls in multitasking, lockscreen and control center
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    return _orig;
}
%end

%hook MLPlayer
-(void)play {
    shouldPlay = TRUE; //set to TRUE (must be before %orig)
    %orig;
}

-(void)pause {
    shouldPlay = FALSE; //set to FALSE (must be before %orig)
    %orig;
}

-(void)setBackgroundPlaybackAllowed:(BOOL)allowed {
    %orig(TRUE);
}

/*
 * return TRUE so it actually plays in the background
 */
-(BOOL)backgroundPlaybackAllowed {
    return TRUE;
}
%end

%hook AVPlayer

/*
 * gets called when the app gets closed
 * if shouldPlay is FALSE it runs %orig, else nothing (fixes the delay)
 */
-(void)pause {
    if(shouldPlay) {
        
    } else {
        %orig;
    }
}
%end

%group YT25
%hook YTVideo
-(BOOL)isPlayableOnMDX {
    return TRUE;
}

-(BOOL)isPlayable {
    return TRUE;
}
%end

%hook YTPlayerViewController
-(BOOL)backgroundPlaybackAllowedForPlayerData:(id)data {
    %orig;
    
    return TRUE;
}

-(void)loadPlayerWithVideo:(id)video playerConfig:(id)config backgroundPlaybackAllowed:(BOOL)allowed {
    %orig(video, config, TRUE);
}
%end

%hook MLProxy
-(void)setBackgroundPlaybackAllowed:(BOOL)allowed {
    %orig(TRUE);
}

-(BOOL)isBackgroundPlaybackAllowed {
    return TRUE;
}
%end

%hook YTSettings
-(BOOL)isBackgroundPlaybackEnabled {
    return TRUE;
}

-(void)setBackgroundPlaybackEnabled:(BOOL)enabled {
    %orig(TRUE);
}
%end

//END BACKGROUNDING CODE

//START MEDIA INFORMATION CODE

%hook MLVideo
-(id)initWithID:(id)anId duration:(double)duration live:(BOOL)live liveDVREnabled:(BOOL)enabled streamManifest:(id)manifest {
    [MediaSetter getMediaForVideoID:anId];
    return %orig;
}
%end
%end

%group YT23
@interface YTVideo
@property(readonly, assign, nonatomic) NSDictionary* thumbnailURLs;
@property(readonly, assign, nonatomic) NSString* uploaderDisplayName;
@property(readonly, assign, nonatomic) NSString* title;
@property(readonly, assign, nonatomic) unsigned duration;
@end

%hook YTVideoDetailsActionsView
-(void)setVideo:(YTVideo *)video userLike:(BOOL)like userDislike:(BOOL)dislike {
    %orig;
    
    NSString *title = [video title];
    NSString *uploader = [video uploaderDisplayName];
    NSString *thumbnail = [[[[video thumbnailURLs] allValues] objectAtIndex:0] description];
    NSInteger duration = [video duration];
    
    [MediaSetter setMediaWithTitle:title uploader:uploader duration:duration thumbnail:thumbnail];
}
%end
%end

%group UNSUPPORTED
%hook YTAppDelegate
-(BOOL)application:(id)app didFinishLaunchingWithOptions:(id)options {
    BOOL _orig = %orig(app, options);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"This version of YouTube isn't supported by YouTubed!\nPlease update to a newer version!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    return _orig;
}
%end
%end

//END MEDIA INFORMATION CODE

%ctor {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    %init(_ungrouped);
    
    if([version compare:@"2.5" options:NSNumericSearch] != NSOrderedAscending) {
        %init(YT25);
        
    } else if([version compare:@"2.3" options:NSNumericSearch] != NSOrderedAscending) {
        %init(YT23);
        
    } else {
        %init(UNSUPPORTED);
    }
}