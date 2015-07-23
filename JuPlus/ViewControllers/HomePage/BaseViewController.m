//
//  BaseViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpCommunication.h"
#import "JuPlusUserInfoCenter.h"
#import "LoginViewController.h"
@implementation BaseViewController
{
    CGFloat statusY;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    statusY = 20.0f;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.navView addSubview: self.titleLabel];
    [self.navView addSubview:self.leftBtn];
    [self.navView addSubview:self.rightBtn];
    //[self.view addSubview:self.viewBack];
    [self loadBaseUI];
    [self startRequest];
    [self.view bringSubviewToFront:self.navView];
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}
//需要重写的init方法(自动调用，只要重写就行)
-(void)loadBaseUI
{
    
}
//网络请求
-(void)startRequest
{
    
}
-(UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0.0f, statusY, 44.0f, 44.0f);
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn
{
    if(!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.navView.width - 54.0f, statusY, 44.0f, 44.0f);
        [_rightBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:14.0]];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIView *black = [[UIView alloc]initWithFrame:CGRectMake((_rightBtn.width - 15.0f)/2, 42.0f, 15.0f, 2.0f)];
        [black setBackgroundColor:[UIColor blackColor]];
        [_rightBtn addSubview:black];
        [_rightBtn setHidden:YES];
    }
    return _rightBtn;
}
-(void)backPress
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)navView
{
    if(!_navView)
    {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,20.0f - statusY, SCREEN_WIDTH, 44.0f+statusY)];
        [_navView setBackgroundColor:RGBCOLOR(239, 239, 239)];
    }
    return _navView;
}
//标题
-(UILabel *)titleLabel
{
    CGFloat titleWidth = 120.0f;
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.width - titleWidth)/2, 20.0f, titleWidth, 44.0f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:FontType(18.0f)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
    
}
//提示信息显示
- (void)showAlertView:(NSString *)msg withTag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    alert.tag=tag;
    [alert show];
}
-(void)errorExp:(NSDictionary *)exp
{
    NSString *resCode = [exp objectForKey:@"resCode"];
    NSString *resMsg = [exp objectForKey:@"resMsg"];
    NSLog(@"reason = %@",resMsg);
    [self showAlertView:resMsg withTag:[resCode integerValue]];
}
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //token失效处理
    if (alertView.tag==ERROR_TOKEN_INVALID) {
        [[JuPlusUserInfoCenter sharedInstance] resetUserInfo];
        LoginViewController *log = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
@end
