//
//  LabelDTO.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//标签详情

#import "BaseDTO.h"
@interface LabelDTO : BaseDTO
//单品类型
@property (nonatomic,strong)NSString *labelTxt;
//单品对应id
@property (nonatomic,strong)NSString *singleId;
//距离左边距距离
@property (nonatomic,assign)float locX;
//距离上边距距离
@property (nonatomic,assign)float locY;

@end