//
//  LoginViewController.h
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//登陆界面

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface LoginViewController :BaseViewController
//登陆
@property (nonatomic,strong)UIButton *loginBtn;
//快速注册
@property (nonatomic,strong)UIButton *registerBtn;
//忘记密码
@property (nonatomic,strong)UIButton *forgetBtn;
@property (nonatomic,strong)NSMutableArray *fieldArray;
@end
