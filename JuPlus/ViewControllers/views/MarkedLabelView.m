//
//  FurnHLabelBtn.m
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 凹凸租车. All rights reserved.
//

#import "MarkedLabelView.h"
#import <QuartzCore/QuartzCore.h>
#import "SingleDetialViewController.h"
#define space 5.0f
@implementation MarkedLabelView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self addSubview:self.alphaImage];
    [self addSubview:self.tipsImage];
    [self addSubview:self.labelRight];
    [self.labelRight addSubview:self.labelText];
    [self addSubview:self.touchBtn];
    
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(setAnimation) userInfo:nil repeats:YES];    //使用timer定时，每4秒触发一次，然后就是写selector了。
    
    [self setAnimation];
    
}
-(void)setAnimation
{
    CGFloat tipsW = self.tipsImage.width;
    //背景view的转变
    CGFloat scale = 3.5f;
    CGFloat changeSpace = tipsW*(scale - 1);

    CGFloat scale1 = 0.8f;
    CGFloat scale2 = 1.2f;
    CGFloat changeSpace1 = tipsW*(1.0f - scale1);
    CGFloat changeSpace2 = tipsW*(scale2 - 1.0f);

    CGPoint tipsCenter = self.tipsImage.center;
    CGPoint alphaCenter = self.alphaImage.center;
    //先缩小后放大
    CGRect nextFrame1 = CGRectMake(self.tipsImage.left + changeSpace1, self.tipsImage.top + changeSpace1, tipsW*scale1, tipsW*scale1);
    CGRect nextFrame2 = CGRectMake(self.tipsImage.left - changeSpace2, self.tipsImage.top - changeSpace2, tipsW*scale2, tipsW*scale2);
    CGRect orignFrame = self.tipsImage.frame;

    CGRect alpha1 = CGRectMake(self.alphaImage.left - changeSpace, self.alphaImage.top-changeSpace, tipsW*scale, tipsW*scale);
    CGRect orignAlpha = self.alphaImage.frame;

    
    [UIView animateKeyframesWithDuration:0.3f delay:0 options:0 animations:^{
        self.tipsImage.frame = nextFrame1;
        self.tipsImage.center = tipsCenter;
    } completion:^(BOOL finished) {
        NSLog(@"1");
    }];
    [UIView animateKeyframesWithDuration:0.3f delay:0.3 options:0 animations:^{
        self.tipsImage.frame = nextFrame2;
        self.tipsImage.center = tipsCenter;
    } completion:^(BOOL finished) {
        NSLog(@"2");
    }];
    [UIView animateKeyframesWithDuration:0.3f delay:0.6 options:0 animations:^{
        self.tipsImage.frame = orignFrame;
        self.tipsImage.center = tipsCenter;
    } completion:^(BOOL finished) {
        NSLog(@"3");

    }];
    [UIView animateKeyframesWithDuration:0.5f delay:1.0f options:0 animations:^{
        self.alphaImage.frame = alpha1;
        self.alphaImage.alpha = 0;
        self.alphaImage.center = alphaCenter;
    } completion:^(BOOL finished) {
        self.alphaImage.frame = orignAlpha;
        self.alphaImage.alpha = 1;
        self.alphaImage.center = alphaCenter;
        NSLog(@"4");
        [UIView animateKeyframesWithDuration:0.5f delay:0 options:0 animations:^{
            self.alphaImage.frame = alpha1;
            self.alphaImage.alpha = 0;
            self.alphaImage.center = alphaCenter;
        } completion:^(BOOL finished) {
            self.alphaImage.frame = orignAlpha;
            self.alphaImage.alpha = 1;
            self.alphaImage.center = alphaCenter;
            
            NSLog(@"5");
            
        }];
    }];
}
#pragma mark --uifig
-(UIImageView *)tipsImage
{
    if(!_tipsImage)
    {
        CGFloat tipRact = 10.0f;
        _tipsImage = [[UIImageView alloc]initWithFrame:CGRectMake(space, (self.height - tipRact)/2, tipRact, tipRact)];
        _tipsImage.layer.cornerRadius = tipRact/2;
        _tipsImage.layer.masksToBounds = YES;
        [_tipsImage setImage:[UIImage imageNamed:@"icons_2"]];
    }
    return _tipsImage;
}
-(UIImageView *)alphaImage
{
    if(!_alphaImage)
    {
        CGFloat tipRact = 10.0f;
        _alphaImage = [[UIImageView alloc]initWithFrame:CGRectMake(space, (self.height - tipRact)/2, tipRact, tipRact)];
        _alphaImage.layer.cornerRadius = tipRact/2;
        _alphaImage.layer.masksToBounds = YES;
        _alphaImage.alpha = 1;
        [_alphaImage setImage:[UIImage imageWithColor:[UIColor blackColor]]];
    }
    return _alphaImage;
}
-(void)layoutSubviews
{
    self.tipsImage.layer.masksToBounds = YES;
    self.tipsImage.layer.cornerRadius = self.tipsImage.width/2;
    self.alphaImage.layer.masksToBounds = YES;
    self.alphaImage.layer.cornerRadius = self.alphaImage.width/2;

}
-(UIImageView *)labelRight
{
    if(!_labelRight)
    {
        _labelRight = [[UIImageView alloc]initWithFrame:CGRectMake(self.tipsImage.right+space*2, 0, self.width - self.tipsImage.width+space, self.height)];
        [_labelRight setImage:[UIImage imageNamed:@"3"]];
    }
    return _labelRight;
}
-(UILabel *)labelText
{
    if(!_labelText)
    {
        _labelText = [[UILabel alloc]initWithFrame:CGRectMake(space, 0, self.labelRight.width - space*2, self.labelRight.height)];
        _labelText.text = @"测试";
    }
    return _labelText;
}
-(UIButton *)touchBtn
{
    if(!_touchBtn)
    {
        _touchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _touchBtn.backgroundColor = [UIColor clearColor];
        _touchBtn.frame = CGRectMake(self.labelRight.left, 0.0f, self.labelRight.width, self.labelRight.height);
        [_touchBtn addTarget:self action:@selector(senderPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touchBtn;
}
-(void)senderPress:(UIButton *)sender
{
    SingleDetialViewController *sing = [[SingleDetialViewController alloc]init];
    sing.singleId = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [[self getSuperViewController].navigationController pushViewController:sing animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
