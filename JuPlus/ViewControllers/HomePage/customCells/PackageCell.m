//
//  PackageCell.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageCell.h"
#import "MarkedLabelView.h"
#import "LabelDTO.h"
CGFloat space = 10.0f;
@implementation PackageCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self.contentView addSubview:self.topV];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.descripL];
    [self.contentView addSubview:self.showImgV];
    [self.showImgV addSubview:self.priceV];
}
-(PortraitView *)topV
{
    if(!_topV)
    {
        _topV = [[PortraitView alloc]initWithFrame:CGRectMake(space, space, self.contentView.width - space*2, 40.0f)];        
    }
    return _topV;
}
-(JuPlusUILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.contentView.width - 80.0f, space*2, 60.0f, 20.0f)];
        [_timeLabel setFont:FontType(12.0f)];
        [_timeLabel setTextColor:Color_Gray_lines];
    }
    return _timeLabel;
}
-(UILabel *)descripL
{
    if(!_descripL)
    {
        _descripL = [[UILabel alloc]initWithFrame:CGRectMake(space, self.topV.bottom+space, self.topV.width, 20.0f)];
        _descripL.text = @"测试描述";
        _descripL.textColor = [UIColor grayColor];
        [_descripL setFont:FontType(12.0f)];
    }
    return _descripL;
}
-(PriceView *)priceV
{
    if(!_priceV)
    {
        _priceV = [[PriceView alloc]initWithFrame:CGRectMake(100.0f, PICTURE_HEIGHT - 30.0f, 200.0f, 30.0f)];
    }
    return _priceV;
}
-(UIImageView *)showImgV
{
    if(!_showImgV)
    {
        _showImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, self.descripL.bottom+space, self.contentView.width, PICTURE_HEIGHT)];
        _showImgV.userInteractionEnabled = YES;
        [_showImgV sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/b3fb43166d224f4a6ffeae120bf790529822d148.jpg"] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    }
    return _showImgV;
}
//cell数据加载
-(void)loadCellInfo:(HomePageInfoDTO *)homepageDTO
{
    [self.topV.portraitImgV setimageUrl:homepageDTO.portrait placeholderImage:@"2.jpg"];
    [self.topV.nikeNameL setText:homepageDTO.nikename];
    [self.timeLabel setText:homepageDTO.uploadTime];
    [self.descripL setText:homepageDTO.descripTxt];
    [self.showImgV setimageUrl:homepageDTO.collectionPic placeholderImage:@""];
    [self.priceV setPriceText:homepageDTO.price];
    [self setTipsWithArray:homepageDTO.labelArray];
    
}
-(void)setTipsWithArray:(NSArray *)tipsArray
{

       for(int i=0;i<[tipsArray count];i++)
    {
        LabelDTO *dto = [tipsArray objectAtIndex:i];
        CGFloat orignX = (dto.locX/100)*self.showImgV.width;
        CGFloat orignY = (dto.locY/100)*self.showImgV.height;
        
        MarkedLabelView *btn = [[MarkedLabelView alloc]initWithFrame:CGRectMake(orignX, orignY, 55, 25)];
        btn.labelText.text = dto.productName;
        btn.touchBtn.tag = [dto.productNo intValue];
        
        [self.showImgV addSubview:btn];
    }
}
@end
