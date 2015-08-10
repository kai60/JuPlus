//
//  JuPlusEnvironment.h
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//环境配置

#ifndef FurnHouse_JuPlusEnvironmentConfig_h
#define FurnHouse_JuPlusEnvironmentConfig_h

// 可读的版本号，类似1.0.0
#define VERSION_STRING @"1.0"
// 内部版本号，用于和后台匹配接口信息
#define VERSION_INT 1
//APP更新地址
#define APP_URL @""
#pragma globalConfig
#define nav_height 64.0f
#define view_height [UIScreen mainScreen].bounds.size.height - nav_height

//屏幕宽、高（用于适配不同机型）
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//系统版本
#define  VERSION [[UIDevice currentDevice].systemVersion doubleValue]
#define PICTURE_HEIGHT 320.0f
//用于下拉加载更多的每页数据数
#define PAGESIZE @"10"

#define ANIMATION 0.3

#define TABBAR_HEIGHT 44.0f
////字体样式
#define FONTSTYLE @"Heiti SC"
//方正幼线
//#define FONTSTYLE @"FZYouXian-Z09S"
//张海山1
//#define FONTSTYLE @"ZHSRXT--GBK1-0"
//张海山2
//#define FONTSTYLE @"ZHSRXT-GBK"



//基于给定字体样式的字体设置
#define FontType(_ref) [UIFont fontWithName:FONTSTYLE size:(_ref)]
//常用字体大小
#define FontSize 14.0f
#define FontMinSize 12.0f
#define FontMaxSize 16.0f
// 连接超时时间，秒
#define CONNECT_TIMEOUT 30
// 数据等待超时时间，秒
#define READ_TIMEOUT 10
#define Progress_tag 2014
//联系客服
#define HELPTELEPHONE @"021-61138651"

#pragma mark --社会化分享
#define UM_APPKey @"55c2fa1067e58e7c850016e6"
//新浪微博
#define SinaAppKey @"34489026"
#define SinaSecret @"efb2084c177517ea8fad51d9e3d7f47a"
//微信
#define WeiChatAppKey @""
//qq
//测试环境
#ifdef kDevTest
//网络请求IP地址
#define FRONT_SERVER_URL @"http://121.40.237.195:8859"
//#define FRONT_SERVER_URL @"http://192.168.0.112"

//H5界面前缀地址
#define FRONT_WEB_URL @""
//图片的前置地址
#define FRONT_PICTURE_URL @"http://jujia-images-test.oss-cn-hangzhou.aliyuncs.com/"
//准生产环境
#elif kUATTest
//网络请求IP地址
#define FRONT_SERVER_URL @""
//H5界面前缀地址
#define FRONT_WEB_URL @""
//图片的前置地址
#define FRONT_PICTURE_URL @""

//正式上线环境
#elif kReleaseH
//网络请求IP地址
#define FRONT_SERVER_URL @"http://121.40.228.199:8859/"
//H5界面前缀地址
#define FRONT_WEB_URL @""
//图片的前置地址
#define FRONT_PICTURE_URL @"http://jujia-images.oss-cn-hangzhou.aliyuncs.com/"

#else

#endif

#endif
