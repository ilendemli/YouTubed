#line 1 "/Users/ils/Dropbox/Projects/YouTubed/YouTubed/YouTubed.xm"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <logos/logos.h>
#include <substrate.h>
@class YTAppDelegate; 
static BOOL (*_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$)(YTAppDelegate*, SEL, id, id); static BOOL _logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(YTAppDelegate*, SEL, id, id); 

#line 4 "/Users/ils/Dropbox/Projects/YouTubed/YouTubed/YouTubed.xm"

static BOOL _logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(YTAppDelegate* self, SEL _cmd, id app, id options) {
    BOOL _orig = _logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(self, _cmd, app, options);
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    return _orig;
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$YTAppDelegate = objc_getClass("YTAppDelegate"); MSHookMessageEx(_logos_class$_ungrouped$YTAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$, (IMP*)&_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$);} }
#line 14 "/Users/ils/Dropbox/Projects/YouTubed/YouTubed/YouTubed.xm"
