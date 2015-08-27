//
//  AppointRespon.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "AppointRespon.h"
#import "AppointDTO.h"
@implementation AppointRespon

- (void)unPackJsonValue:(NSDictionary *)dict
{
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    self.appointArray = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for (int i = 0; i < [arr count]; i++) {
        AppointDTO *dto = [[AppointDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.appointArray addObject:dto];
    }
}

@end
