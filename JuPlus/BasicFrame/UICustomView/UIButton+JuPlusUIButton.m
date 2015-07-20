//
//  UIButton+JuPlusUIButton.m
//  JuPlus
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UIButton+JuPlusUIButton.h"
#import "UIButton+WebCache.h"

@implementation UIButton (JuPlusUIButton)
//加载网络图片
-(void)setimageUrl:(NSString *)url placeholderImage:(NSString *)defalutImage
{
    if (defalutImage==nil) {
        defalutImage = @"null";
    }
  //  url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,url] ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:defalutImage]];
     [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,url]] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:defalutImage]];
}
-(void)startAnimation
{
    self.userInteractionEnabled = NO;
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //values中的每一个值对应放大从开始到结束动作的倍数，对应到keyTimes中的为没一段动画持续时间
    /*  const kCAAnimationLinear; 根据动画的总时长平均分配所有帧数的动画(推荐在平滑动态时候使用)
     NSString * const kCAAnimationDiscrete;   只展示关键帧的状态，没有中间过程，没有动画。
     NSString * const kCAAnimationPaced;根据给定的每一帧的时间决定每一段动画的快慢
     */
    k.values = @[@(1.0),@(0.75),@(1.25),@(1.0)];
    k.keyTimes = @[@(0.0),@(0.25),@(0.5),@(0.25)];
    k.calculationMode = kCAAnimationPaced;
    k.duration = 1.0;
    k.delegate = self;
    [self.layer addAnimation:k forKey:nil];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    self.selected = !self.selected;
}
@end
