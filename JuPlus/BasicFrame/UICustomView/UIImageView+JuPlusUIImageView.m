//
//  UIImageView+JuPlusUIImageView.m
//  JuPlus
//
//  Created by admin on 15/7/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UIImageView+JuPlusUIImageView.h"
#import "UIView+JuPlusUIView.h"
@implementation UIImageView (JuPlusUIImageView)
//加载网络图片
-(void)setimageUrl:(NSString *)url placeholderImage:(NSString *)defalutImage
{
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,url]] placeholderImage:[UIImage imageNamed:defalutImage]];
}
//设置圆形图片
-(void)setLayerImage
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width/2;
}
@end
