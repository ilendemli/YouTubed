/*
 YouTubed
 MediaSetter.m
 
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

#import "MediaSetter.h"

@implementation MediaSetter
+(void)setMediaWithTitle:(NSString *)title uploader:(NSString *)uploader duration:(NSInteger)duration thumbnail:(NSString *)url {
    if(NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageWithData:imageData]];
        [imageData release];
        
        [songInfo setObject:title forKey:MPMediaItemPropertyTitle];
        [songInfo setObject:uploader forKey:MPMediaItemPropertyArtist];
        [songInfo setObject:[NSNumber numberWithInteger:duration] forKey:MPMediaItemPropertyPlaybackDuration];
        [songInfo setObject:[NSNumber numberWithInt:1] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        [albumArt release];
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        [songInfo release];
    }
}

+(void)getMediaForVideoID:(NSString *)videoID {
    NSString *xmlURLasString = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@", videoID];
    NSURL *xmlURL = [NSURL URLWithString:xmlURLasString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:xmlURL];
    [request setHTTPMethod:@"GET"];
	[request setTimeoutInterval:15];
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *metaError = nil;
                               NSDictionary *meta = [XMLReader dictionaryForXMLData:data error:&metaError];
                               
                               if (!metaError) {
                                   NSDictionary *entry = [meta valueForKey:@"entry"];
                                   NSDictionary *media_group = [entry valueForKey:@"media:group"];
                                   
                                   NSString *title = [[entry valueForKey:@"title"] valueForKey:@"text"];
                                   NSString *uploader = [[[entry valueForKey:@"author"] valueForKey:@"name"] valueForKey:@"text"];
                                   NSString *thumbnail = [[[media_group valueForKey:@"media:thumbnail"] objectAtIndex:0] valueForKey:@"url"];
                                   NSInteger duration = [[[media_group valueForKey:@"yt:duration"] valueForKey:@"seconds"] intValue];
                                   
                                   [MediaSetter setMediaWithTitle:title uploader:uploader duration:duration thumbnail:thumbnail];
                               }
                           }];
    
}
@end