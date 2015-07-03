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
    
    [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,url]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:defalutImage]];
}

@end
