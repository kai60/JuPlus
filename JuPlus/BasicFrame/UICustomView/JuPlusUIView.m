//
//  JuPlusUIView.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#define statusY 20.0f
@implementation JuPlusUIView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.navView];
        [self.navView addSubview: self.titleLabel];
        [self.navView addSubview:self.leftBtn];
        [self.navView addSubview:self.rightBtn];
    }
    return self;
}
-(UIView *)navView
{
    if(!_navView)
    {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,20.0f - statusY, SCREEN_WIDTH, 44.0f+statusY)];
        [_navView setBackgroundColor:RGBCOLOR(239, 239, 239)];
        [_navView setHidden:YES];
    }
    return _navView;
}
//标题
-(UILabel *)titleLabel
{
    CGFloat titleWidth = 120.0f;
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width - titleWidth)/2, 20.0f, titleWidth, 44.0f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
    
}
-(UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0.0f, statusY, 44.0f, 44.0f);
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
    }
    return _rightBtn;
}

//提示信息显示
- (void)showAlertView:(NSString *)msg withTag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag=tag;
    [alert show];
}
//返回数据后台提示的错误信息处理
-(void)errorExp:(NSDictionary *)exp
{
    NSLog(@"%@",exp);
}
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
@end
