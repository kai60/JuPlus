//
//  BasicUIViewController.h
//  JuPlus
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpCommunication.h"
#import "JuPlusUserInfoCenter.h"
#import "LoginViewController.h"
#import "JuPlusEnvironmentConfig.h"
#import "JuPlusCustomMethod.h"
#import "JuPlusUIView.h"
#import "ErrorInfoDto.h"

@interface BasicUIViewController : UIViewController
//导航栏
@property(nonatomic,strong)UIView *navView;
//标题栏
@property(nonatomic,strong)UILabel *titleLabel;
//@property(nonatomic,strong)UIView *viewBack;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
-(void)errorExp:(ErrorInfoDto *)exp;
//提示的错误消息
- (void)showAlertView:(NSString *)msg withTag:(int)tag;
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)loadBaseUI;
//数据加载
-(void)startRequest;

@end
