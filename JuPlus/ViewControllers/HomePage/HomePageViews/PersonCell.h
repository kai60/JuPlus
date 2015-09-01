//
//  PersonCell.h
//  JuPlus
//
//  Created by ios_admin on 15/8/31.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDTO.h"
@interface PersonCell : UITableViewCell

@property (nonatomic, strong)UIButton *designerBut;//预约设计师
@property (nonatomic, strong)UILabel *appointLabel;
@property (nonatomic, strong)UIImageView *appointImageUrl;
@property (nonatomic, strong) UIImageView *personHeadImage; // 用户头像
- (void)fileData:(PersonDTO *)dto;
@end
