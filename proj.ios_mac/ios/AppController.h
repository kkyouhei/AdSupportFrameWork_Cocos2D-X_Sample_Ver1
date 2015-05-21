#import <AdSupportFramework/AdView.h>
#import <AdSupportFramework/AdController.h>
#import <AdSupportFramework/AdIcController.h>
#import <AdSupportFramework/AdIcView.h>


@class RootViewController;

// AdSupportFrameWork MediaID
#define GF_SITE_ID @""
@interface AppController : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property(nonatomic, readonly) RootViewController* viewController;
@property (nonatomic, retain) AdIcController *gfIconController;
@property (nonatomic, retain) AdIcView *iconView;

//アイコン型
- (void)addIcon;
- (void)showIcon;
- (void)hideIcon;


@end

