#line 1 "/Users/ils/Dropbox/Projects/YouTubed/YouTubed/YouTubed.xm"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



BOOL shouldPlay = FALSE;

#include <logos/logos.h>
#include <substrate.h>
@class YTAppDelegate; @class MLPlayer; @class YTVideo; @class AVPlayer; 
static BOOL (*_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$)(YTAppDelegate*, SEL, id, id); static BOOL _logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(YTAppDelegate*, SEL, id, id); static void (*_logos_orig$_ungrouped$MLPlayer$play)(MLPlayer*, SEL); static void _logos_method$_ungrouped$MLPlayer$play(MLPlayer*, SEL); static void (*_logos_orig$_ungrouped$MLPlayer$pause)(MLPlayer*, SEL); static void _logos_method$_ungrouped$MLPlayer$pause(MLPlayer*, SEL); static BOOL (*_logos_orig$_ungrouped$MLPlayer$backgroundPlaybackAllowed)(MLPlayer*, SEL); static BOOL _logos_method$_ungrouped$MLPlayer$backgroundPlaybackAllowed(MLPlayer*, SEL); static void (*_logos_orig$_ungrouped$AVPlayer$pause)(AVPlayer*, SEL); static void _logos_method$_ungrouped$AVPlayer$pause(AVPlayer*, SEL); static BOOL (*_logos_orig$_ungrouped$YTVideo$isMonetizedWithCountryCode$)(YTVideo*, SEL, id); static BOOL _logos_method$_ungrouped$YTVideo$isMonetizedWithCountryCode$(YTVideo*, SEL, id); 

#line 9 "/Users/ils/Dropbox/Projects/YouTubed/YouTubed/YouTubed.xm"

static BOOL _logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(YTAppDelegate* self, SEL _cmd, id app, id options) {
    BOOL _orig = _logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(self, _cmd, app, options);
    
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    return _orig;
}



static void _logos_method$_ungrouped$MLPlayer$play(MLPlayer* self, SEL _cmd) {
    shouldPlay = TRUE; 
    _logos_orig$_ungrouped$MLPlayer$play(self, _cmd);
}

static void _logos_method$_ungrouped$MLPlayer$pause(MLPlayer* self, SEL _cmd) {
    shouldPlay = FALSE; 
    _logos_orig$_ungrouped$MLPlayer$pause(self, _cmd);
}




static BOOL _logos_method$_ungrouped$MLPlayer$backgroundPlaybackAllowed(MLPlayer* self, SEL _cmd) {
    return TRUE;
}








static void _logos_method$_ungrouped$AVPlayer$pause(AVPlayer* self, SEL _cmd) {
    if(!shouldPlay) { _logos_orig$_ungrouped$AVPlayer$pause(self, _cmd); }
}







static BOOL _logos_method$_ungrouped$YTVideo$isMonetizedWithCountryCode$(YTVideo* self, SEL _cmd, id country) {
    return FALSE; 
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$YTAppDelegate = objc_getClass("YTAppDelegate"); MSHookMessageEx(_logos_class$_ungrouped$YTAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$);Class _logos_class$_ungrouped$MLPlayer = objc_getClass("MLPlayer"); MSHookMessageEx(_logos_class$_ungrouped$MLPlayer, @selector(play), (IMP)&_logos_method$_ungrouped$MLPlayer$play, (IMP*)&_logos_orig$_ungrouped$MLPlayer$play);MSHookMessageEx(_logos_class$_ungrouped$MLPlayer, @selector(pause), (IMP)&_logos_method$_ungrouped$MLPlayer$pause, (IMP*)&_logos_orig$_ungrouped$MLPlayer$pause);MSHookMessageEx(_logos_class$_ungrouped$MLPlayer, @selector(backgroundPlaybackAllowed), (IMP)&_logos_method$_ungrouped$MLPlayer$backgroundPlaybackAllowed, (IMP*)&_logos_orig$_ungrouped$MLPlayer$backgroundPlaybackAllowed);Class _logos_class$_ungrouped$AVPlayer = objc_getClass("AVPlayer"); MSHookMessageEx(_logos_class$_ungrouped$AVPlayer, @selector(pause), (IMP)&_logos_method$_ungrouped$AVPlayer$pause, (IMP*)&_logos_orig$_ungrouped$AVPlayer$pause);Class _logos_class$_ungrouped$YTVideo = objc_getClass("YTVideo"); MSHookMessageEx(_logos_class$_ungrouped$YTVideo, @selector(isMonetizedWithCountryCode:), (IMP)&_logos_method$_ungrouped$YTVideo$isMonetizedWithCountryCode$, (IMP*)&_logos_orig$_ungrouped$YTVideo$isMonetizedWithCountryCode$);} }
#line 62 "/Users/ils/Dropbox/Projects/YouTubed/YouTubed/YouTubed.xm"
