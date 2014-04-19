#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "XMLReader.h"

@interface MediaSetter : NSObject
+(void)setMediaWithTitle:(NSString *)title uploader:(NSString *)uploader duration:(NSInteger)duration thumbnail:(NSString *)url;
+(void)getMediaForVideoID:(NSString *)videoID;
@end