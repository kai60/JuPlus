//
//  BaseViewController.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//所有视图控制器的基类

#import <UIKit/UIKit.h>
#import "JuPlusEnvironmentConfig.h"
#import "JuPlusCustomMethod.h"
#import "JuPlusUIView.h"
#import "ErrorInfoDto.h"
@interface BaseViewController : UIViewController
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
