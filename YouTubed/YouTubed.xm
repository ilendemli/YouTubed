/*
 The MIT License (MIT)

 Copyright (c) 2014 Muhammet Ilendemli
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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