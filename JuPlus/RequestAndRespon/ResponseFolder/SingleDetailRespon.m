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
    self.imageArray = [NSArray arrayWithArray:[dict objectForKey:@""]];
    self.htmlString = [NSString stringWithFormat:@"%@",[dict objectForKey:@""]];
    self.basisArray = [NSArray arrayWithArray:[dict objectForKey:@""]];
    self.singleNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@""]];
}
@end
