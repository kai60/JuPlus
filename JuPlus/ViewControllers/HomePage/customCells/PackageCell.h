//
//  PackageCell.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PortraitView.h"
@interface PackageCell : UITableViewCell
//头像信息
@property(nonatomic,strong)PortraitView *topV;
//描述
@property(nonatomic,strong)UILabel *descripL;
//套餐图层
@property(nonatomic,strong)UIImageView *showImgV;
@property(nonatomic,strong)UIView *priceV;
-(void)setTipsWithArray:(NSArray *)tipsArray;
@end
