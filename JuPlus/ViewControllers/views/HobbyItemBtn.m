//
//  HobbyItemBtn.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HobbyItemBtn.h"

@implementation HobbyItemBtn
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        [self addSubview:self.iconBtn];
        [self addSubview:self.selectedImage];
    }
    return self;
}
-(UIButton *)iconBtn
{
    if(!_iconBtn)
    {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn.frame = CGRectMake(0.0f, 0.0f, self.width, self.height);
    }
    return _iconBtn;
}
-(UIImageView *)selectedImage
{
    if(!_selectedImage)
    {
        _selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(20.0f, 0.0f, self.width - 20.0f, self.height)];
        [_selectedImage setImage:[UIImage imageNamed:@"icons_2"]];
        [_selectedImage setHidden:YES];
    }
    return _selectedImage;
    
}

@end
