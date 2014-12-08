
#import <GameFeatKit/GFPopupView.h>
#import <GameFeatKit/GFView.h>
#import <GameFeatKit/GFController.h>
#import <GameFeatKit/GFIconController.h>
#import <GameFeatKit/GFIconView.h>


@class RootViewController;

@interface AppController : NSObject <UIApplicationDelegate, GFPopupViewDelegate> {
    UIWindow *window;
}

@property(nonatomic, readonly) RootViewController* viewController;
@property (nonatomic, retain) GFPopupView *popupView;
@property (nonatomic, retain) GFIconController *gfIconController;
@property (nonatomic, retain) GFIconView *iconView;

//全画面型GameFeat
- (void)addGameFeat;
- (void)showGameFeat;
- (void)hideGameFeat;

//アイコン型GameFeat
- (void)addIconGameFeat;
- (void)showIconGameFeat;
- (void)hideIconGameFeat;


@end

