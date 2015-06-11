//
//  BaseViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+JuPlusUIView.h"
#import "UIColor+JuPlusColor.h"
#import "UIImage+JuPlusUIImage.h"
#import "NSString+JuPlusString.h"
#import "JuPlusEnvironmentConfig.h"
@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.navView addSubview: self.titleLabel];
    
    // Do any additional setup after loading the view.
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
@end
