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
                               NSString *humanReadableData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               NSDictionary *dics = [[NSDictionary alloc]initWithDictionary:[XMLReader dictionaryForXMLString:humanReadableData error:nil]];
                               
                               NSString *title = [[[dics valueForKey:@"entry"] valueForKey:@"title"] valueForKey:@"text"];
                               NSString *uploader = [[[[dics valueForKey:@"entry"] valueForKey:@"author"] valueForKey:@"name"] valueForKey:@"text"];
                               NSString *durationString = [[[[dics valueForKey:@"entry"] valueForKey:@"media:group"] valueForKey:@"yt:duration"] valueForKey:@"seconds"];
                               NSString *thumbnail = [[[[[dics valueForKey:@"entry"] valueForKey:@"media:group"] valueForKey:@"media:thumbnail"] objectAtIndex:0] valueForKey:@"url"];
                               NSInteger duration = [durationString intValue];
                               
                               [MediaSetter setMediaWithTitle:title uploader:uploader duration:duration thumbnail:thumbnail];
                           }];

}
@end