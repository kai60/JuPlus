//
//  productOrderDTO.h
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseDTO.h"

@interface productOrderDTO : BaseDTO
//单品图像
@property(nonatomic,strong)NSString * imgUrl;
//单品名称
@property(nonatomic,strong)NSString *productName;
//价格
@property(nonatomic,strong)NSString *price;
//单品数量
@property(nonatomic,strong)NSString *countNum;
@end