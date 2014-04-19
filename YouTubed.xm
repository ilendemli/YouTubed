#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MediaSetter.h"
#import "cutils.h"

@interface YTVideo
@property(readonly, assign, nonatomic) NSDictionary* thumbnailURLs;
@property(readonly, assign, nonatomic) NSString* uploaderDisplayName;
@property(readonly, assign, nonatomic) NSString* title;
@property(readonly, assign, nonatomic) unsigned duration;
@end

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

//END BACKGROUNDING CODE

//START MEDIA INFORMATION CODE

%hook MLVideo
-(id)initWithID:(id)anId duration:(double)duration live:(BOOL)live liveDVREnabled:(BOOL)enabled streamManifest:(id)manifest {
    [MediaSetter getMediaForVideoID:anId];
    return %orig;
}
%end

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

//END MEDIA INFORMATION CODE