//
//  HomePageInfoDTO.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//首页数据层

#import "BaseDTO.h"
#import "LabelDTO.h"
@interface HomePageInfoDTO : BaseDTO
//标签数组
@property(nonatomic,strong)NSArray *tipsArray;
//图像
@property(nonatomic,strong)NSString *imageUrl;
//价格
@property(nonatomic,strong)NSString *price;
//作者昵称
@property(nonatomic,strong)NSString *nikeName;
//头像
@property(nonatomic,strong)NSString *portraitUrl;
//上传时间
@property(nonatomic,strong)NSString *uploadTime;


@end
