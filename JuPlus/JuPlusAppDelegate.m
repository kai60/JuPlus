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
#import "HomeFurnishingViewController.h"
#import "BPush.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "MobClick.h"
#import <MAMapKit/MAMapKit.h>
/* */
@interface JuPlusAppDelegate ()
{
    UIImageView *bottom;
    UIImageView *left;
    UIImageView *right;
}
@property(nonatomic,strong)HomeFurnishingViewController *home;
@end

@implementation JuPlusAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   // sleep(1);//设置启动页面时间
#pragma mark --UM sign

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = Color_White;
    [self loadAnimationView];
    //注册地图
    [MAMapServices sharedServices].apiKey = AMap_Key;
    [self signUM];

//    NSMutableArray *fontNames = [[NSMutableArray alloc] init];
//    
//    NSArray *fontFamilyNames = [UIFont familyNames];
//    
//    for (NSString *familyName in fontFamilyNames) {
//        
//        //        NSLog(@"Font Family Name = %@", familyName);
//        
//        NSArray *names = [UIFont fontNamesForFamilyName:familyName];
//        
//        //        NSLog(@"Font Names = %@", fontNames);
//        
//        [fontNames addObjectsFromArray:names];
//        
//    }
//    
//    NSLog(@"fontNames==%@",fontNames);
    
//#pragma mark --insertPush百度推送
//    // iOS8 下需要使用新的 API
////    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
//        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//        
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
////    }else {
////        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
////        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
////    }
//    
//#warning 上线 AppStore 时需要修改 pushMode 需要修改 isDebug:是否是测试环境 Apikey为自己的Apikey
//  /*  aunchOptions：App 启动时系统提供的参数。
//    apiKey：通过apikey注册百度推送。
//    mode：当前推送的环境。
//    isdebug：是否是debug模式。
//    leftAction：快捷回复通知的第一个按钮名字
//    rightAction：第二个按钮名字
//    ategory 自定义参数 一组动作的唯一标示 需要与服务端ans的category匹配才能展现通知样式
//   */
//    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
//    [BPush registerChannel:launchOptions apiKey:@"lGOY7gUXuRwvK2D7ibNrf8dY" pushMode:BPushModeDevelopment withFirstAction:@"取消" withSecondAction:@"确认" withCategory:nil isDebug:YES];
//    // App 是用户点击推送消息启动
//    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (userInfo) {
//        NSLog(@"从消息启动:%@",userInfo);
//        [BPush handleNotification:userInfo];
//    }
//    
//    //角标清0
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    /*
     // 测试本地通知
     [self performSelector:@selector(testLocalNotifi) withObject:nil afterDelay:1.0];
     */

    
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(void)loadAnimationView
{
    bottom = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if (iphone5) {
        bottom.image = [UIImage imageNamed:@"Default-568h"];
    }else if(iphone6){
        bottom.image = [UIImage imageNamed:@"Default-667"];
    }else if(iphone6P){
        bottom.image = [UIImage imageNamed:@"Default-736"];
    }else{
        bottom.image = [UIImage imageNamed:@"Default"];
    }
    //添加到场景
    [self.window addSubview:bottom];
    //放到最顶层;
    [self.window bringSubviewToFront:left];    //设置一个图片;
    left = [[UIImageView alloc] initWithFrame:CGRectMake(60.0f,SCREEN_HEIGHT/2+55.0f, 25.0f, 55.0f)];
    left.image = [UIImage imageNamed:@"Default_left"];
    //添加到场景
    [self.window addSubview:left];
    //放到最顶层;
    [self.window bringSubviewToFront:left];
    
    right = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2, 25.0f, 55.0f)];
    right.image = [UIImage imageNamed:@"Default_right"];
    right.alpha = 0.0f;
    //添加到场景
    [self.window addSubview:right];
    //放到最顶层;
    [self.window bringSubviewToFront:right];
    
   [UIView animateWithDuration:1.5f animations:^{
       right.alpha = 1.0f;
       left.frame = CGRectMake(SCREEN_WIDTH/2 - 25.0f, left.top, left.width, left.height);
   } completion:^(BOOL finished) {
       
       [self performSelector:@selector(goNext) withObject:nil afterDelay:1.0];
       
   }];
}
-(void)goNext
{
    [UIView animateWithDuration:1.0f animations:^{
        left.alpha = 0.0f;
        right.alpha = 0.0f;
        bottom.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.window.backgroundColor = [UIColor clearColor];
        [left removeFromSuperview];
        [right removeFromSuperview];
        [bottom removeFromSuperview];
        //程序第一次启动
            if([CommonUtil getUserDefaultsValueWithKey:GetAppVerson]==nil||(![[CommonUtil getUserDefaultsValueWithKey:GetAppVerson] isEqualToString:VERSION_STRING]))
            {
                //版本更新或者第一次运行走引导页
                [self runGuideMethod];
                [CommonUtil setUserDefaultsValue:VERSION_STRING forKey:GetAppVerson];
            }
            else
            {
       // 正常流程
                [self runNormalMethod];
            }

    }];
    
}
-(void)startupAnimationDone
{
    [self.window removeAllSubviews];
}
-(void)signUM
{
    [UMSocialData setAppKey:UM_APPKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeiChatAppKey appSecret:WeiChatAppKey url:WeiChatShareUrl];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    // [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    // [UMSocialQQHandler setSupportWebView:YES];
        [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
        [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //[UMSocialData openLog:YES];
    //友盟统计添加
    //[MobClick startWithAppkey:UM_APPKey reportPolicy:BATCH channelId:@"web"];
    
   }
//引导页
-(void)runGuideMethod
{
    GuideViewController *guide=[[GuideViewController alloc]init];
    self.window.rootViewController = guide;
}
//正常打开首页
-(void)runNormalMethod
{
    self.home = [[HomeFurnishingViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.home];
    self.window.rootViewController = nav;
}

//#pragma mark --BPushDelegate
//- (void)testLocalNotifi
//{
//    NSLog(@"测试本地通知啦！！！");
//    NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:5];
//    [BPush localNotification:fireDate alertBody:@"这是本地通知" badge:3 withFirstAction:@"打开" withSecondAction:@"关闭" userInfo:nil soundName:nil region:nil regionTriggersOnce:YES category:nil];
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    // 打印到日志 textView 中
//    NSLog(@"%@",[NSString stringWithFormat:@"backgroud : %@",userInfo]);
//    
//    completionHandler(UIBackgroundFetchResultNewData);
//    
//}
//
//// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
//{
//    
//    [application registerForRemoteNotifications];
//    
//    
//}
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSLog(@"test:%@",deviceToken);
//    [BPush registerDeviceToken:deviceToken];
//    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
//         NSLog(@"%@",[NSString stringWithFormat:@"Method: %@\n%@",BPushRequestMethodBind,result]);
//    }];
//    
//    // 打印到日志 textView 中
//    NSLog(@"%@",[NSString stringWithFormat:@"Register use deviceToken : %@",deviceToken]);
//    
//    
//}
//
//// 当 DeviceToken 获取失败时，系统会回调此方法
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    NSLog(@"DeviceToken 获取失败，原因：%@",error);
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    // App 收到推送的通知
//    [BPush handleNotification:userInfo];
//    NSLog(@"%@",[NSString stringWithFormat:@"Received Remote Notification :\n%@",userInfo]);
//    
//    NSLog(@"%@",userInfo);
//}
//
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    NSLog(@"接收本地通知啦！！！");
//    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
//}
//
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
