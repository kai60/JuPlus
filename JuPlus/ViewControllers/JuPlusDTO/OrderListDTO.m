//
//  OrderListDTO.m
//  JuPlus
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListDTO.h"
#import "productOrderDTO.h"
@implementation OrderListDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.productArray = [[NSMutableArray alloc]init];
    self.orderNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
    self.orderTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"reqTime"]];
    self.totalPrice = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalAmt"]];
    NSArray *proList = [dict objectForKey:@"productList"];
    for(NSDictionary *pro in proList)
    {
        productOrderDTO *dto =  [[productOrderDTO alloc]init];
        [dto loadDTO:pro];
        [self.productArray addObject:dto];
    }
    self.totalCount = [self.productArray count];
    NSInteger type = [[NSString stringWithFormat:@"%@",[dict objectForKey:@"status"]] integerValue];
    if (type==10) {
        self.sendType = @"未发货";
    }
    else if(type==20)
    {
        self.sendType = @"已发货";
    }

}
@end
