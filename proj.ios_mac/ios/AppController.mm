/****************************************************************************
 Copyright (c) 2010 cocos2d-x.org

 http://www.cocos2d-x.org

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#import "AppController.h"
#import "CCEAGLView.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppController

// GAMEFEAT MediaID
#define GF_SITE_ID @"1580"

#pragma mark -
#pragma mark Application lifecycle

// cocos2d application instance
static AppDelegate s_sharedApplication;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];

    // Init the CCEAGLView
    CCEAGLView *eaglView = [CCEAGLView viewWithFrame: [window bounds]
                                     pixelFormat: kEAGLColorFormatRGBA8
                                     depthFormat: GL_DEPTH24_STENCIL8_OES
                              preserveBackbuffer: NO
                                      sharegroup: nil
                                   multiSampling: NO
                                 numberOfSamples: 0];

    // Use RootViewController manage CCEAGLView 
    _viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    _viewController.wantsFullScreenLayout = YES;
    _viewController.view = eaglView;

    // Set RootViewController to window
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0)
    {
        // warning: addSubView doesn't work on iOS6
        [window addSubview: _viewController.view];
    }
    else
    {
        // use this method on ios6
        [window setRootViewController:_viewController];
    }

    [window makeKeyAndVisible];

    [[UIApplication sharedApplication] setStatusBarHidden:true];

    // IMPORTANT: Setting the GLView should be done after creating the RootViewController
    cocos2d::GLView *glview = cocos2d::GLView::createWithEAGLView(eaglView);
    cocos2d::Director::getInstance()->setOpenGLView(glview);

    cocos2d::Application::getInstance()->run();

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
     //We don't need to call this method any more. It will interupt user defined game pause&resume logic
    /* cocos2d::Director::getInstance()->pause(); */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
     //We don't need to call this method any more. It will interupt user defined game pause&resume logic
    /* cocos2d::Director::getInstance()->resume(); */
    
    // GF Activate
    [GFController activateGF:GF_SITE_ID useCustom:YES useIcon:YES usePopup:YES];

    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    
    UIDevice *device = [UIDevice currentDevice];
    BOOL backgroundSupported = NO;
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        backgroundSupported = device.multitaskingSupported;
    }
    if (backgroundSupported) {
        [GFController backgroundTask];
    }
    
    cocos2d::Application::getInstance()->applicationDidEnterBackground();
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    
    [GFController conversionCheckStop];

    cocos2d::Application::getInstance()->applicationWillEnterForeground();
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated
{
    // アイコン広告の表示
    [self.gfIconController loadAd:GF_SITE_ID];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // アイコン広告の自動更新を停止
    [self.gfIconController stopAd];
}


/**
 * 全画面GameFeat追加
 */
- (void)addGameFeat {
    
    // 全画面広告を初期化（デリゲート版）
    self.popupView = [[GFPopupView alloc] init:self];
    
    // 毎回表示
    [self.popupView setSchedule:1];
    
    // 全画面広告の表示
    if ([self.popupView loadAd:GF_SITE_ID]) {
        [_viewController.view addSubview:self.popupView];
    }
    
}

/**
 * アイコン型GameFeat追加
 */
- (void)addIconGameFeat {
    
    // GFIconControllerの初期化
    self.gfIconController = [[GFIconController alloc] init];
    
    // アイコンの自動更新間隔を指定
    [self.gfIconController setRefreshTiming:10];
    
    // アイコンの配置位置を設定
    {
        GFIconView *iconView = [[[GFIconView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)] autorelease];
        [self.gfIconController addIconView:iconView];
        [_viewController.view addSubview:iconView];
    }
    {
        GFIconView *iconView = [[[GFIconView alloc] initWithFrame:CGRectMake(80, 10, 60, 60)] autorelease];
        [self.gfIconController addIconView:iconView];
        [_viewController.view addSubview:iconView];
    }
    
    [self.gfIconController loadAd:GF_SITE_ID];
}

/**
 * 全画面型GameFeat表示
 */
- (void)showGameFeat {
    if (self.popupView) {
        [self hideGameFeat];
    }
    [self addGameFeat];
}

/**
 * 全画面型GameFeat削除
 */
- (void)hideGameFeat {
    if (self.popupView) {
        [self.popupView removeFromSuperview];
    }
}

/**
 * アイコン型GameFeat表示
 */
- (void)showIconGameFeat {
    if ([self.gfIconController.arrIconView count] == 0) {
        [self addIconGameFeat];
    } else if (self.gfIconController.isTimerActive == NO) {
        [self.gfIconController loadAd:GF_SITE_ID];
    }
    [self.gfIconController visibleIconAd];
}

/**
 * アイコン型GameFeat非表示
 */
- (void)hideIconGameFeat {
    [self.gfIconController stopAd];
    [self.gfIconController invisibleIconAd];
}

// 全画面広告が表示された際に実行される
- (void)didShowGameFeatPopup{
    NSLog(@"didShowGameFeatPopup");
}

// 全画面広告が閉じられた際に実行される
- (void)didCloseGameFeatPopup{
    NSLog(@"didCloseGameFeatPopup");
}

// 全画面広告が表示できなかった際に実行される
- (void)failGameFeatPopupData{
    NSLog(@"failGameFeatPopupData");
}



@end
