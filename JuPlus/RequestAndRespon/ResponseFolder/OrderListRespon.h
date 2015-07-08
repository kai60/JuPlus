//
//  OrderListRespon.h
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "productOrderDTO.h"
@interface OrderListRespon : JuPlusResponse
@property(nonatomic,strong)NSString *orderNo;

@property(nonatomic,strong)NSString *orderTime;

@property(nonatomic,assign)int totalCount;

@property(nonatomic,strong)NSString *totalPrice;

@property(nonatomic,strong)NSMutableArray *productArray;
@end
