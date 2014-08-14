#line 1 "/Users/ilendemli/git/YouTubed/YouTubed/YouTubed.xm"























@interface SpringBoard
-(void)checkForYTApp;
@end

#include <logos/logos.h>
#include <substrate.h>
@class YTIPlayabilityStatus; @class MLPlayer; @class SpringBoard; 


#line 28 "/Users/ilendemli/git/YouTubed/YouTubed/YouTubed.xm"
static void (*_logos_orig$YT$MLPlayer$setBackgroundPlaybackAllowed$)(MLPlayer*, SEL, BOOL); static void _logos_method$YT$MLPlayer$setBackgroundPlaybackAllowed$(MLPlayer*, SEL, BOOL); static BOOL (*_logos_orig$YT$YTIPlayabilityStatus$isPlayableInBackground)(YTIPlayabilityStatus*, SEL); static BOOL _logos_method$YT$YTIPlayabilityStatus$isPlayableInBackground(YTIPlayabilityStatus*, SEL); 


static void _logos_method$YT$MLPlayer$setBackgroundPlaybackAllowed$(MLPlayer* self, SEL _cmd, BOOL allowed) { _logos_orig$YT$MLPlayer$setBackgroundPlaybackAllowed$(self, _cmd, TRUE); }



static BOOL _logos_method$YT$YTIPlayabilityStatus$isPlayableInBackground(YTIPlayabilityStatus* self, SEL _cmd) { return TRUE; }




static void (*_logos_orig$SB$SpringBoard$applicationDidFinishLaunching$)(SpringBoard*, SEL, id); static void _logos_method$SB$SpringBoard$applicationDidFinishLaunching$(SpringBoard*, SEL, id); static void _logos_method$SB$SpringBoard$checkForYTApp(SpringBoard*, SEL); 


static void _logos_method$SB$SpringBoard$applicationDidFinishLaunching$(SpringBoard* self, SEL _cmd, id application) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self checkForYTApp];
    });
    
    _logos_orig$SB$SpringBoard$applicationDidFinishLaunching$(self, _cmd, application);
}


static void _logos_method$SB$SpringBoard$checkForYTApp(SpringBoard* self, SEL _cmd) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager contentsOfDirectoryAtPath:@"/var/mobile/Applications/" error:nil];
    NSString *plistFilePath = nil;
    
    for (int count = 0; count < files.count; count++) {
        NSString *tempAppPath = [NSString stringWithFormat:@"/var/mobile/Applications/%@/YouTube.app/Info.plist", [files objectAtIndex:count]];
        
        if ([fileManager fileExistsAtPath:tempAppPath]) {
            plistFilePath = [NSString stringWithFormat:@"/var/mobile/Applications/%@/YouTube.app/Info.plist", [files objectAtIndex:count]];
        }
    }
    
    if (plistFilePath == nil) {
        [[[UIAlertView alloc] initWithTitle:@"YouTubed" message:@"You don't have YouTube installed, please install it from the AppStore and respring your device afterwards." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        
    } else {
        NSDictionary *infoDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFilePath];
        NSMutableArray *modes = [NSMutableArray new];
        
        for (NSString *mode in [infoDictionary objectForKey:@"UIBackgroundModes"]) {
            [modes addObject:mode];
        }
        
        if ([modes containsObject:@"audio"] == NO) {
            [modes addObject:@"audio"];
            
            NSMutableDictionary *newInfoDictionary = [NSMutableDictionary dictionaryWithDictionary:infoDictionary];
            [newInfoDictionary setObject:modes forKey:@"UIBackgroundModes"];
            
            [newInfoDictionary writeToFile:plistFilePath atomically:YES];
        }
    }
}




static __attribute__((constructor)) void _logosLocalCtor_a0d0ee7f() {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    
    if ([bundleID isEqualToString:@"com.apple.springboard"]) {
        {Class _logos_class$SB$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$SB$SpringBoard, @selector(applicationDidFinishLaunching:), (IMP)&_logos_method$SB$SpringBoard$applicationDidFinishLaunching$, (IMP*)&_logos_orig$SB$SpringBoard$applicationDidFinishLaunching$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$SB$SpringBoard, @selector(checkForYTApp), (IMP)&_logos_method$SB$SpringBoard$checkForYTApp, _typeEncoding); }}
        
    } else if ([bundleID isEqualToString:@"com.google.ios.youtube"]) {
        {Class _logos_class$YT$MLPlayer = objc_getClass("MLPlayer"); MSHookMessageEx(_logos_class$YT$MLPlayer, @selector(setBackgroundPlaybackAllowed:), (IMP)&_logos_method$YT$MLPlayer$setBackgroundPlaybackAllowed$, (IMP*)&_logos_orig$YT$MLPlayer$setBackgroundPlaybackAllowed$);Class _logos_class$YT$YTIPlayabilityStatus = objc_getClass("YTIPlayabilityStatus"); MSHookMessageEx(_logos_class$YT$YTIPlayabilityStatus, @selector(isPlayableInBackground), (IMP)&_logos_method$YT$YTIPlayabilityStatus$isPlayableInBackground, (IMP*)&_logos_orig$YT$YTIPlayabilityStatus$isPlayableInBackground);}
    }
}
