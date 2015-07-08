//
//  AppDelegate.m
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusAppDelegate.h"
#import "CommonUtil.h"
#import "GuideViewController.h"
#import "JuPlusTabBarController.h"
#import "DiscoveryViewController.h"
#import "CollocationViewController.h"
#import "ClassificationViewController.h"
#import "JuPlusNavigationController.h"
#import "HomeFurnishingViewController.h"
@interface JuPlusAppDelegate ()

@end

@implementation JuPlusAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //程序第一次启动
//    if([CommonUtil getUserDefaultsValueWithKey:GetAppVerson]==nil||(![[CommonUtil getUserDefaultsValueWithKey:GetAppVerson] isEqualToString:VERSION_STRING]))
//    {
//        //版本更新或者第一次运行走引导页
//        [self runGuideMethod];
//    }
//    else
//    {
        //正常流程
        [self runNormalMethod];
//    }
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)runGuideMethod
{
    GuideViewController *guide=[[GuideViewController alloc]init];
    self.window.rootViewController = guide;
}
-(void)runNormalMethod
{
//    JuPlusTabBarController *tab = [[JuPlusTabBarController alloc]init];
////    
//    DiscoveryViewController *dis = [[DiscoveryViewController alloc]init];
//    CollocationViewController *collocation = [[CollocationViewController alloc]init];
//    ClassificationViewController *class = [[ClassificationViewController alloc]init];
//    MyAccountViewController *myacc = [[MyAccountViewController alloc]init];
//    NSArray *viewCtrls = @[dis,collocation,class,myacc];
//    NSMutableArray *navCtrls = [[NSMutableArray alloc] init];
//    
//    for(int i=0; i<4 ; i++) {
//        //取得视图控制器
//        BaseViewController *viewCtrl = viewCtrls[i];
//        //创建导航控制器
//        JuPlusNavigationController *navCtrl = [[JuPlusNavigationController alloc] initWithRootViewController:viewCtrl];
//        [navCtrls addObject:navCtrl];
//    }
//    tab.viewControllers = viewCtrls;
    HomeFurnishingViewController *home = [[HomeFurnishingViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
    self.window.rootViewController = nav;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
