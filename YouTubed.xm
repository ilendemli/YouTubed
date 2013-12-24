#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
    if(!shouldPlay) { %orig; }
}
%end

//END BACKGROUNDING CODE

//START REMOVING ADS CODE

%hook YTVideo
-(BOOL)isMonetizedWithCountryCode:(id)country {
    return FALSE; //muhahahah
}
%end

//END REMOVING ADS CODE