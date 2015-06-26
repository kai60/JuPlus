//
//  LabelDTO.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//标签详情

#import "LabelDTO.h"

@implementation LabelDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.labelTxt = [NSString stringWithFormat:@"%@",[dict objectForKey:@""]];
    self.singleId = [NSString stringWithFormat:@"%@",[dict objectForKey:@""]];
    self.locX = [[NSString stringWithFormat:@"%@",[dict objectForKey:@""]] floatValue];
    self.locY = [[NSString stringWithFormat:@"%@",[dict objectForKey:@""]] floatValue];
}
@end
