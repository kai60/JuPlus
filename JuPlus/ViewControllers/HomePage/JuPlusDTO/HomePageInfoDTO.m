//
//  HomePageInfoDTO.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomePageInfoDTO.h"

@implementation HomePageInfoDTO

-(void)loadDTO:(NSDictionary *)dict
{
    NSMutableArray *mutab = [[NSMutableArray alloc]initWithCapacity:0];
   for(NSDictionary *tip in [dict objectForKey:@"tipsArray"])
   {
       LabelDTO *dto = [[LabelDTO alloc]init];
       [dto loadDTO:tip];
       [mutab addObject:dto];
   }
    self.tipsArray = mutab;
}
@end
