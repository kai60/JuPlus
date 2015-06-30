//
//  BaseViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseViewController.h"
#import "HttpCommunication.h"
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.navView addSubview: self.titleLabel];
    [self.navView addSubview:self.leftBtn];
    [self.leftBtn setHidden:YES];
    [self.view addSubview:self.viewBack];
    [self loadBaseUI];
    [self startRequest];
    // Do any additional setup after loading the view.
}
//需要重写的init方法
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
        _leftBtn.frame = CGRectMake(10.0f, 16.0f, 30.0f, 30.0f);
        [_leftBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(void)backPress
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)navView
{
    if(!_navView)
    {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 64.0f)];
        [_navView setBackgroundColor:RGBCOLOR(248, 134, 9)];
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
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
    
}
-(UIView *)viewBack
{
    if(!_viewBack)
    {
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height)];
        _viewBack.backgroundColor = RGBCOLOR(111, 111, 111);
    }
    return _viewBack;
}
//提示信息显示
- (void)showAlertView:(NSString *)msg withTag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag=tag;
    [alert show];
}
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
@end
