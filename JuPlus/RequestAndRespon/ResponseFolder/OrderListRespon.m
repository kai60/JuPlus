//
//  OrderListRespon.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListRespon.h"

@implementation OrderListRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.productArray = [[NSMutableArray alloc]init];
    self.orderNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
    self.orderTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderTime"]];
    self.totalPrice = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
    NSArray *proList = [dict objectForKey:@"productList"];
    for(NSDictionary *pro in proList)
    {
        productOrderDTO *dto =  [[productOrderDTO alloc]init];
        [dto loadDTO:pro];
        [self.productArray addObject:dto];
    }
    self.totalCount = [self.productArray count];

}
@end
