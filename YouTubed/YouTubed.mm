#line 1 "/Users/ilendemli/YouTubed/YouTubed/YouTubed.xm"




























#include <logos/logos.h>
#include <substrate.h>
@class YTLocalPlaybackController; @class YTIPlayabilityStatus; @class YTTabTitlesView; 
static BOOL (*_logos_orig$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed)(YTLocalPlaybackController*, SEL); static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed(YTLocalPlaybackController*, SEL); static BOOL (*_logos_orig$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings)(YTLocalPlaybackController*, SEL); static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings(YTLocalPlaybackController*, SEL); static BOOL (*_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground)(YTIPlayabilityStatus*, SEL); static BOOL _logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground(YTIPlayabilityStatus*, SEL); 

#line 29 "/Users/ilendemli/YouTubed/YouTubed/YouTubed.xm"
static struct CGSize (*_logos_orig$GROUP_HIDE_TITLES$YTTabTitlesView$sizeThatFits$)(YTTabTitlesView*, SEL, struct CGSize); static struct CGSize _logos_method$GROUP_HIDE_TITLES$YTTabTitlesView$sizeThatFits$(YTTabTitlesView*, SEL, struct CGSize); 

static struct CGSize _logos_method$GROUP_HIDE_TITLES$YTTabTitlesView$sizeThatFits$(YTTabTitlesView* self, SEL _cmd, struct CGSize arg1) {
    return CGSizeMake(arg1.width * 0.5, 0);
}




static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed(YTLocalPlaybackController* self, SEL _cmd) {
    return TRUE;
}

static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings(YTLocalPlaybackController* self, SEL _cmd) {
    return TRUE;
}




static BOOL _logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground(YTIPlayabilityStatus* self, SEL _cmd) {
    return TRUE;
}


static __attribute__((constructor)) void _logosLocalCtor_0ee48178() {
    {Class _logos_class$_ungrouped$YTLocalPlaybackController = objc_getClass("YTLocalPlaybackController"); MSHookMessageEx(_logos_class$_ungrouped$YTLocalPlaybackController, @selector(backgroundPlaybackAllowed), (IMP)&_logos_method$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed, (IMP*)&_logos_orig$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed);MSHookMessageEx(_logos_class$_ungrouped$YTLocalPlaybackController, @selector(isBackgroundPlaybackAllowedByUserSettings), (IMP)&_logos_method$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings, (IMP*)&_logos_orig$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings);Class _logos_class$_ungrouped$YTIPlayabilityStatus = objc_getClass("YTIPlayabilityStatus"); MSHookMessageEx(_logos_class$_ungrouped$YTIPlayabilityStatus, @selector(isPlayableInBackground), (IMP)&_logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground, (IMP*)&_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground);}
    
    NSString *path = @"/var/mobile/Library/Preferences/info.ilendemli.youtubed.plist";
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    BOOL hideTitleView = [dict objectForKey:@"hideTitleView"] ? [[dict objectForKey:@"hideTitleView"] boolValue] : FALSE;
    
    if (hideTitleView == TRUE) {
        {Class _logos_class$GROUP_HIDE_TITLES$YTTabTitlesView = objc_getClass("YTTabTitlesView"); MSHookMessageEx(_logos_class$GROUP_HIDE_TITLES$YTTabTitlesView, @selector(sizeThatFits:), (IMP)&_logos_method$GROUP_HIDE_TITLES$YTTabTitlesView$sizeThatFits$, (IMP*)&_logos_orig$GROUP_HIDE_TITLES$YTTabTitlesView$sizeThatFits$);}
    }
}
