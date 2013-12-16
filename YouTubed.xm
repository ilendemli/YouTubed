#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook YTAppDelegate
-(BOOL) application:(id)app didFinishLaunchingWithOptions:(id)options {
    BOOL _orig = %orig(app, options);
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    return _orig;
}
%end