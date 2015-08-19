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
    [self.contentView addSubview:self.messView];
    [self.messView addSubview:self.topV];
    [self.messView addSubview:self.timeLabel];
    [self.messView addSubview:self.descripL];
    [self.contentView addSubview:self.showImgV];
    [self.contentView addSubview:self.bottomView];
   // [self.showImgV addSubview:self.priceV];
}
-(JuPlusUIView *)messView
{
    if(!_messView)
    {
        _messView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.width, 90.0f)];
    }
    return _messView;
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
        _showImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, self.messView.bottom, self.contentView.width, PICTURE_HEIGHT)];
        [_showImgV setImage:[UIImage imageNamed:@"default_square"]];
        _showImgV.userInteractionEnabled = YES;
    }
    return _showImgV;
}
-(JuPlusUIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.showImgV.bottom, self.contentView.width, 2.0f)];
        _bottomView.backgroundColor = Color_Gray_lines;
        [_bottomView setHidden:YES];
    }
    return _bottomView;
}
//cell数据加载
-(void)loadCellInfo:(HomePageInfoDTO *)homepageDTO withShow:(BOOL)isShow
{
    if (isShow) {
        //隐藏信息栏
        [self.messView setHidden:YES];
        //隐藏标签
        for(UIView *sub in self.showImgV.subviews)
        {
            if ( [sub isKindOfClass:[LabelView class]]) {
                [sub setHidden:YES];
            }
        }
        [self.bottomView setHidden:NO];
        self.messView.frame = CGRectMake(0.0f, 0.0f, self.contentView.width, 0.0f);
        [self.showImgV setimageUrl:homepageDTO.sharePic  placeholderImage:nil];
        [UIView animateWithDuration:ANIMATION animations:^{
            self.showImgV.frame = CGRectMake(0.0f, 0.0f, self.contentView.width, PICTURE_HEIGHT);
            self.bottomView.frame = CGRectMake(0.0f, self.showImgV.bottom, self.bottomView.width, self.bottomView.height);
        }];
    }
    else
    {
        //显示信息栏
        [self.messView setHidden:NO];
        //显示标签
        for(UIView *sub in self.showImgV.subviews)
        {
            if ( [sub isKindOfClass:[LabelView class]]) {
                [sub setHidden:NO];
            }
        }
        [self.showImgV setimageUrl:homepageDTO.collectionPic  placeholderImage:nil];
        
        [UIView animateWithDuration:ANIMATION animations:^{
                self.messView.frame = CGRectMake(0.0f, 0.0f, self.contentView.width, 90.0f);
                self.showImgV.frame = CGRectMake(0.0f, self.messView.bottom, self.contentView.width, PICTURE_HEIGHT);
                self.bottomView.frame = CGRectMake(0.0f, self.showImgV.bottom, self.bottomView.width, self.bottomView.height);
            }];
        [self.topV.portraitImgV setimageUrl:homepageDTO.portrait  placeholderImage:nil];
        [self.topV.nikeNameL setText:homepageDTO.nikename];
        [self.timeLabel setText:homepageDTO.uploadTime];
        [self.descripL setText:homepageDTO.descripTxt];
        [self.showImgV setimageUrl:homepageDTO.collectionPic  placeholderImage:nil];
        if (self.bottomView.hidden) {
        self.showImgV.alpha = 0;
        [UIView animateWithDuration:1.0f animations:^{
            self.showImgV.alpha = 1.0f;
        }];
        }
        [self.bottomView setHidden:YES];
        self.showImgV.tag = [homepageDTO.regNo intValue];
        [self setTipsWithArray:homepageDTO.labelArray];
    }
   //    [self.topV.portraitImgV addTarget:self action:@selector(portraitImgVPress:) forControlEvents:UIControlEventTouchUpInside];
//    [self.priceV setPriceText:homepageDTO.price];
    
}
-(void)portraitImgVPress:(UIButton *)sender
{
//    DesignerDetailViewController *design = [[DesignerDetailViewController alloc]init];
//    UIViewController *vc = [self getSuperViewController];
//    [vc.navigationController.view.layer addAnimation:[self getPushTransition] forKey:nil];
//    [vc.navigationController pushViewController:design animated:NO];
    
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
        CGFloat orignY = (dto.locY/100)*self.showImgV.height - 50.0f;
        
        CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(12.0f)];
        LabelView *la;
        if ([dto.direction floatValue]==1) {
             la = [[LabelView alloc]initWithFrame:CGRectMake(orignX, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
        }
        else
        {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];

        }
       
        la.tag = [dto.productNo intValue];
        [la showText:dto.productName];
        [self.showImgV addSubview:la];
    }
}
@end
