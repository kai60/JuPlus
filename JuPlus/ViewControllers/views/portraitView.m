//
//  portraitView.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//附带头像以及昵称

#import "PortraitView.h"
#import "UIImageView+WebCache.h"
#import "JuPlusEnvironmentConfig.h"
@implementation PortraitView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.portraitImgV];
        [self addSubview:self.nikeNameL];
    }
    return self;
}
//icon
-(UIImageView *)portraitImgV
{
    if(!_portraitImgV)
    {
        CGFloat imageW = self.height;
        _portraitImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, imageW, imageW)];
        _portraitImgV.layer.cornerRadius = imageW/2;
        _portraitImgV.layer.masksToBounds = YES;
        [_portraitImgV sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/b3fb43166d224f4a6ffeae120bf790529822d148.jpg"] placeholderImage:[UIImage imageNamed:@"icons_2.png"]];
    }
    return _portraitImgV;
}
//nikeName
-(UILabel *)nikeNameL
{
    if(!_nikeNameL)
    {
        _nikeNameL = [[UILabel alloc]initWithFrame:CGRectMake(self.portraitImgV.right+10.0f, self.height/4, self.width - self.portraitImgV.width - 20.0f, self.height/2)];
        [_nikeNameL setFont:FontType(14.0f)];
    }
    return _nikeNameL;
}
@end
