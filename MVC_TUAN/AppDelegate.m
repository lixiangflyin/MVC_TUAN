//
//  AppDelegate.m
//  MVC_TUAN
//
//  Created by apple on 14-7-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "LHTabBarController.h"
#import "ProduceViewController.h"
#import "BusinessViewController.h"
#import "WodeViewController.h"
#import "MoreViewController.h"

//#import "BMKMapManager.h"

@interface AppDelegate(){
    
    //BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //百度地图设置
//    _mapManager = [[BMKMapManager alloc]init];
//    BOOL ret = [_mapManager start:@"X41fy5o28E8SlxVp85BBDx0X"  generalDelegate:self];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    
    ProduceViewController *vc1 = [[ProduceViewController alloc] init];
    BusinessViewController *vc2 = [[BusinessViewController alloc] init];
    WodeViewController *vc3 = [[WodeViewController alloc] initWithNibName:@"WodeViewController" bundle:nil];
    MoreViewController *vc4 = [[MoreViewController alloc] init];
    
    UINavigationController *nav1, *nav2, *nav3, *nav4;
    nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    NSArray *normalIcons =
    @[@"tab_bar_tuan_gou_normal",@"tab_bar_zhou_bian_normal",@"tab_bar_wo_de_normal",@"tab_bar_geng_duo_normal"];
    NSArray *highlightIcons =
    @[@"tab_bar_tuan_gou_highlight",@"tab_bar_zhou_bian_highlight",@"tab_bar_wo_de_highlight",@"tab_bar_geng_duo_highlight"];
    LHTabBarController *tabBarController = [[LHTabBarController alloc] initWithViewControllers:@[nav1, nav2,nav3, nav4]
                                                                         tabBarNormalItemIcons:normalIcons
                                                                      tabBarHighlightItemIcons:highlightIcons
                                                               selectedItemBackgroundImageName:@"tab_bar_selected_item_background"
                                                                     tabBarBackgroundImageName:@"tab_bar_background"];
    self.window.rootViewController = tabBarController;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//百度地图回调
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
@end
