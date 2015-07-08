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
@property(nonatomic,strong)NSArray *productArr;
@property(nonatomic,strong)NSString *productNo;
//@property(nonatomic,strong)NSString *receiverName;

@end
