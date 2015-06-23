//
//  PackageCell.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageCell.h"
#import "MarkedLabelView.h"
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
-(UILabel *)descripL
{
    if(!_descripL)
    {
        _descripL = [[UILabel alloc]initWithFrame:CGRectMake(space, self.topV.bottom, self.topV.width, 20.0f)];
        _descripL.text = @"测试描述";
        [_descripL setFont:FontType(16.0f)];
    }
    return _descripL;
}
-(UIImageView *)showImgV
{
    if(!_showImgV)
    {
        _showImgV = [[UIImageView alloc]initWithFrame:CGRectMake(space, self.descripL.bottom, self.topV.width, 200.0f)];
        [_showImgV sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/b3fb43166d224f4a6ffeae120bf790529822d148.jpg"] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    }
    return _showImgV;
}
-(void)setTipsWithArray:(NSArray *)tipsArray
{
    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"125",@"orignX",@"110",@"orignY", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"320",@"orignX",@"20",@"orignY", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"25",@"orignX",@"310",@"orignY", nil];
    //CGFloat Percentage = self.bomImage.image.size.width/320.0f;
    CGFloat Percentage = 1;
    
    NSArray *dataArr = [NSArray arrayWithObjects:dict1,dict2,dict3, nil];
    for(int i=0;i<[dataArr count];i++)
    {
        NSDictionary *dic  = [dataArr objectAtIndex:i];
        CGFloat orignX = [[dic objectForKey:@"orignX"] floatValue]/Percentage;
        CGFloat orignY = [[dic objectForKey:@"orignY"] floatValue]/Percentage;
        
        MarkedLabelView *btn = [[MarkedLabelView alloc]initWithFrame:CGRectMake(orignX, orignY, 80, 30)];
        btn.labelText.text = [NSString stringWithFormat:@"标签%d",i];
        btn.tag = i;
        [btn.touchBtn addTarget:self action:@selector(senderPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.showImgV addSubview:btn];
    }

}
-(void)senderPress:(UIButton *)sender
{
    
}
@end
