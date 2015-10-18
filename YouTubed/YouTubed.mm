#line 1 "/Users/ilendemli/Desktop/YouTubed/YouTubed/YouTubed.xm"


























static UIScrollView *_tabTitlesView;

#include <logos/logos.h>
#include <substrate.h>
@class YTLocalPlaybackController; @class YTPageViewController; @class YTIPlayabilityStatus; @class YTTabTitlesView; 
static struct CGSize (*_logos_orig$_ungrouped$YTTabTitlesView$sizeThatFits$)(YTTabTitlesView*, SEL, struct CGSize); static struct CGSize _logos_method$_ungrouped$YTTabTitlesView$sizeThatFits$(YTTabTitlesView*, SEL, struct CGSize); static id (*_logos_orig$_ungrouped$YTTabTitlesView$initWithLocator$styleContext$)(YTTabTitlesView*, SEL, id, id); static id _logos_method$_ungrouped$YTTabTitlesView$initWithLocator$styleContext$(YTTabTitlesView*, SEL, id, id); static BOOL (*_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground)(YTIPlayabilityStatus*, SEL); static BOOL _logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground(YTIPlayabilityStatus*, SEL); static BOOL (*_logos_orig$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed)(YTLocalPlaybackController*, SEL); static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed(YTLocalPlaybackController*, SEL); static BOOL (*_logos_orig$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings)(YTLocalPlaybackController*, SEL); static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings(YTLocalPlaybackController*, SEL); static BOOL (*_logos_orig$_ungrouped$YTPageViewController$shouldLoadPageAtIndex$)(YTPageViewController*, SEL, long long); static BOOL _logos_method$_ungrouped$YTPageViewController$shouldLoadPageAtIndex$(YTPageViewController*, SEL, long long); 

#line 29 "/Users/ilendemli/Desktop/YouTubed/YouTubed/YouTubed.xm"

static struct CGSize _logos_method$_ungrouped$YTTabTitlesView$sizeThatFits$(YTTabTitlesView* self, SEL _cmd, struct CGSize arg1) {
    return CGSizeMake(arg1.width * 0.5, 0);
}

static id _logos_method$_ungrouped$YTTabTitlesView$initWithLocator$styleContext$(YTTabTitlesView* self, SEL _cmd, id arg1, id arg2) {
    return _tabTitlesView = _logos_orig$_ungrouped$YTTabTitlesView$initWithLocator$styleContext$(self, _cmd, arg1, arg2);
}



static BOOL _logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground(YTIPlayabilityStatus* self, SEL _cmd) {
    return TRUE;
}



static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed(YTLocalPlaybackController* self, SEL _cmd) {
    return TRUE;
}

static BOOL _logos_method$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings(YTLocalPlaybackController* self, SEL _cmd) {
    return TRUE;
}




static BOOL _logos_method$_ungrouped$YTPageViewController$shouldLoadPageAtIndex$(YTPageViewController* self, SEL _cmd, long long arg1) {
    if (arg1 == 0) return NO;
    
    return YES;
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$YTTabTitlesView = objc_getClass("YTTabTitlesView"); MSHookMessageEx(_logos_class$_ungrouped$YTTabTitlesView, @selector(sizeThatFits:), (IMP)&_logos_method$_ungrouped$YTTabTitlesView$sizeThatFits$, (IMP*)&_logos_orig$_ungrouped$YTTabTitlesView$sizeThatFits$);MSHookMessageEx(_logos_class$_ungrouped$YTTabTitlesView, @selector(initWithLocator:styleContext:), (IMP)&_logos_method$_ungrouped$YTTabTitlesView$initWithLocator$styleContext$, (IMP*)&_logos_orig$_ungrouped$YTTabTitlesView$initWithLocator$styleContext$);Class _logos_class$_ungrouped$YTIPlayabilityStatus = objc_getClass("YTIPlayabilityStatus"); MSHookMessageEx(_logos_class$_ungrouped$YTIPlayabilityStatus, @selector(isPlayableInBackground), (IMP)&_logos_method$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground, (IMP*)&_logos_orig$_ungrouped$YTIPlayabilityStatus$isPlayableInBackground);Class _logos_class$_ungrouped$YTLocalPlaybackController = objc_getClass("YTLocalPlaybackController"); MSHookMessageEx(_logos_class$_ungrouped$YTLocalPlaybackController, @selector(backgroundPlaybackAllowed), (IMP)&_logos_method$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed, (IMP*)&_logos_orig$_ungrouped$YTLocalPlaybackController$backgroundPlaybackAllowed);MSHookMessageEx(_logos_class$_ungrouped$YTLocalPlaybackController, @selector(isBackgroundPlaybackAllowedByUserSettings), (IMP)&_logos_method$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings, (IMP*)&_logos_orig$_ungrouped$YTLocalPlaybackController$isBackgroundPlaybackAllowedByUserSettings);Class _logos_class$_ungrouped$YTPageViewController = objc_getClass("YTPageViewController"); MSHookMessageEx(_logos_class$_ungrouped$YTPageViewController, @selector(shouldLoadPageAtIndex:), (IMP)&_logos_method$_ungrouped$YTPageViewController$shouldLoadPageAtIndex$, (IMP*)&_logos_orig$_ungrouped$YTPageViewController$shouldLoadPageAtIndex$);} }
#line 63 "/Users/ilendemli/Desktop/YouTubed/YouTubed/YouTubed.xm"
