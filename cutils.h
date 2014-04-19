#define LOGPATH @"/var/tmp/tweak.log"

#define log(o) logToFile([o description]);

bool logToFile(NSString *s);

bool logToFile(NSString *s) {
    @autoreleasepool {
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSFileHandle* fh = [NSFileHandle fileHandleForWritingAtPath:LOGPATH];
        
        /*
        if (!fh) {
            [[NSFileManager defaultManager] createFileAtPath:LOGPATH contents:nil attributes:nil];
            fh = [NSFileHandle fileHandleForWritingAtPath:LOGPATH];
        }
         */
        
        if (fh) {
            if (![s hasSuffix: @"\n"]) {
                s = [s stringByAppendingString: @"\n"];
            }
            
            @try {
                [fh seekToEndOfFile];
                [fh writeData:[s dataUsingEncoding:enc]];
            }
            @catch (NSException *e) {
                NSLog(@"Failed to log to file: %@", LOGPATH);
                return NO;
            }
            
            [fh closeFile];
            return YES;
            
        } else {
            return NO;
        }
    }
}