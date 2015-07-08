//
//  productOrderDTO.m
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "productOrderDTO.h"

@implementation productOrderDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.imgUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"imgUrl"]];
    self.productName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productName"]];
    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    self.countNum = [NSString stringWithFormat:@"%@",[dict objectForKey:@"countNum"]];
}
@end
