//
//  LoginRespon.m
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "LoginRespon.h"

@implementation LoginRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.token = [NSString stringWithFormat:@"%@",[dict objectForKey:@"token"]];
}
@end
