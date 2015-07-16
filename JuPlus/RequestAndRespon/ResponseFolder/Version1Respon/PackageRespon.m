//
//  PackageRespon.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageRespon.h"
#import "LabelDTO.h"
@implementation PackageRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.isFav = [NSString stringWithFormat:@"%@",[dict objectForKey:@"isPraise"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.memerNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"memerNo"]];

    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalPrice"]];
    self.imgUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];
    self.designer = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickname"]];
    self.portraitUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"portraitPath"]];
    self.address = [NSString stringWithFormat:@"%@",[dict objectForKey:@"visitAddress"]];
    self.content = [NSString stringWithFormat:@"%@",[dict objectForKey:@"explain"]];
    self.packageList = [NSArray arrayWithArray:[dict objectForKey:@"relatedCol"]];
    NSArray *arr = [dict objectForKey:@"productList"];
    self.labelArray = [[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++) {
        LabelDTO *dto = [[LabelDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.labelArray addObject:dto];
    }

    
}
@end
