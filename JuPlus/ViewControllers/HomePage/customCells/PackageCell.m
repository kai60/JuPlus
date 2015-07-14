//
//  PackageCell.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageCell.h"
#import "LabelView.h"
#import "LabelDTO.h"
#import "DesignerDetailViewController.h"
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
   // [self.showImgV addSubview:self.priceV];
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
        [_timeLabel setTextAlignment:NSTextAlignmentRight];
        [_timeLabel setFont:FontType(12.0f)];
        [_timeLabel setTextColor:Color_Gray];
    }
    return _timeLabel;
}
-(UILabel *)descripL
{
    if(!_descripL)
    {
        _descripL = [[UILabel alloc]initWithFrame:CGRectMake(space, self.topV.bottom+space, self.topV.width, 20.0f)];
        _descripL.textColor = [UIColor grayColor];
        [_descripL setFont:FontType(12.0f)];
    }
    return _descripL;
}
-(UIImageView *)showImgV
{
    if(!_showImgV)
    {
        _showImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, self.descripL.bottom+space, self.contentView.width, PICTURE_HEIGHT)];
        _showImgV.userInteractionEnabled = YES;
    }
    return _showImgV;
}
//cell数据加载
-(void)loadCellInfo:(HomePageInfoDTO *)homepageDTO
{
    [self.topV.portraitImgV setimageUrl:homepageDTO.portrait  placeholderImage:@"2.jpg"];
    [self.topV.nikeNameL setText:homepageDTO.nikename];
//    [self.timeLabel setText:homepageDTO.uploadTime];
    [self.timeLabel setText:@"1小时前"];
    [self.descripL setText:homepageDTO.descripTxt];
    [self.showImgV setimageUrl:homepageDTO.collectionPic  placeholderImage:@""];
    self.showImgV.tag = [homepageDTO.regNo intValue];
    [self.topV.portraitImgV addTarget:self action:@selector(portraitImgVPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.priceV setPriceText:homepageDTO.price];
    [self setTipsWithArray:homepageDTO.labelArray];
    
}
-(void)portraitImgVPress:(UIButton *)sender
{
    DesignerDetailViewController *design = [[DesignerDetailViewController alloc]init];
    UIViewController *vc = [self getSuperViewController];
    [vc.navigationController.view.layer addAnimation:[self getPushTransition] forKey:nil];
    [vc.navigationController pushViewController:design animated:NO];
    
}
-(void)setTipsWithArray:(NSArray *)tipsArray
{
    for(UIView *vi in [self.showImgV subviews])
    {
        if([vi isKindOfClass:[LabelView class]])
        {
            [((LabelView *)vi).timer invalidate];
            [vi removeFromSuperview];
        }
    }
       for(int i=0;i<[tipsArray count];i++)
    {
        LabelDTO *dto = [tipsArray objectAtIndex:i];
        CGFloat orignX = (dto.locX/100)*self.showImgV.width;
        CGFloat orignY = (dto.locY/100)*self.showImgV.height;
        
        CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(12.0f)];
        LabelView *la;
        if ([dto.direction floatValue]==1) {
             la = [[LabelView alloc]initWithFrame:CGRectMake(orignX, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
        }
        else
        {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];

        }
       
        la.touchBtn.tag = [dto.productNo intValue];
        [la showText:dto.productName];
        [self.showImgV addSubview:la];
    }
}
@end
