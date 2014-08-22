//
//  MediaSetter.h
//  YouTubed
//
//  Created by ilendemli on 21.08.14.
//
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"

@interface MediaSetter : NSObject
+(void)getMediaForVideoID:(NSString *)videoID;
@end