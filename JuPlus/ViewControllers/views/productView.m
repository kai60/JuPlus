//
//  productView.m
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "productView.h"
#define space 20.0f
@implementation productView
-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.iconImgV];
        [self addSubview:self.titleL];
        [self addSubview:self.priceL];
        [self addSubview:self.countV];
    }
    return self;
}
#pragma mark --UI
-(UIImageView *)iconImgV
{
    if(!_iconImgV)
    {
        CGFloat multiple = SCREEN_WIDTH/DETAIL_HEIGHT;
        CGFloat imgW = 80.0f;
        CGFloat imgH = imgW/multiple;
        _iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, (self.height - imgH)/2 , imgW, imgH)];
        
        
    }
    return _iconImgV;
}
-(JuPlusUILabel *)titleL
{
    if(!_titleL)
    {
        _titleL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.iconImgV.right +space/2, space, 100.0f, 30.0f)];
        [_titleL setFont:FontType(14.0f)];
        _titleL.textColor = Color_Gray;
    }
    return _titleL;
}
-(JuPlusUILabel *)priceL
{
    if(!_priceL)
    {
        _priceL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.titleL.left, self.titleL.bottom, 100.0f, 30.0f)];
        [_priceL setFont:FontType(14.0f)];
        _priceL.textColor = Color_Gray;
    }
    return _priceL;
}

-(CountView *)countV
{
    if(!_countV)
    {
        _countV = [[CountView alloc]initWithFrame:CGRectMake(self.width - 80.0f, (self.height - 18.0f)/2, 80.0f, 22.0f)];
    }
    return _countV;
}
-(void)loadData:(NSDictionary *)dict
{
    [self.countV setCountNum:1];
    [self.iconImgV setimageUrl:[dict objectForKey:@"imgUrl"] placeholderImage:nil];
    [self.titleL setText:[dict objectForKey:@"productName"]];
    [self.priceL setText:[NSString stringWithFormat:@"¥%@",[dict objectForKey:@"productName"]]];

}
@end