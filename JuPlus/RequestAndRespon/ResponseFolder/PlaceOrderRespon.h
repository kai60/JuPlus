//
//  PlaceOrderRespon.h
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface PlaceOrderRespon : JuPlusResponse
//所购买的单品数组
@property(nonatomic,strong)NSMutableArray *productArr;

@property(nonatomic,strong)NSString *orderNo;
//收货人
@property(nonatomic,strong)NSString *receictName;
//联系方式
@property(nonatomic,strong)NSString *receictMobile;
//地址
@property(nonatomic,strong)NSString *receictAddress;
//总价
@property (nonatomic,strong)NSString *totalAmt;

@property (nonatomic,strong)NSString *reqTime;

@end
