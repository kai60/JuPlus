//
//  SingleDetailRespon.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SingleDetailRespon.h"

@implementation SingleDetailRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.imageArray = [NSArray arrayWithArray:[dict objectForKey:@"imgList"]];
    self.htmlString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"explain"]];
    self.basisArray = [NSArray arrayWithArray:[dict objectForKey:@"componentList"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.proName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];

}
@end
