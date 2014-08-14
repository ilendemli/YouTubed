/*
 COPYRIGHT 2014 Muhammet Ilendemli
 Sunday 01:15 GMT +1 Vienna, Austria
 */

@interface SpringBoard
-(void)checkForYTApp;
@end

%group YT

%hook MLPlayer
-(void)setBackgroundPlaybackAllowed:(BOOL)allowed { %orig(TRUE); }
%end

%hook YTIPlayabilityStatus
-(BOOL)isPlayableInBackground { return TRUE; }
%end

%end

%group SB

%hook SpringBoard
-(void)applicationDidFinishLaunching:(id)application {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self checkForYTApp];
    });
    
    %orig;
}

%new
-(void)checkForYTApp {
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
%end

%end

%ctor {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    
    if ([bundleID isEqualToString:@"com.apple.springboard"]) {
        %init(SB);
        
    } else if ([bundleID isEqualToString:@"com.google.ios.youtube"]) {
        %init(YT);
    }
}