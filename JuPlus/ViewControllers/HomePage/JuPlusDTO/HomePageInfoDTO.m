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
    self.memNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"memberNo"]];
    self.uploadTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"uploadTime"]];
    self.portrait = [NSString stringWithFormat:@"%@",[dict objectForKey:@"portraitPath"]];
    self.nikename = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickname"]];
    self.descripTxt = [NSString stringWithFormat:@"%@",[dict objectForKey:@"explain"]];
    self.collectionPic = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];
    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalPrice"]];
    NSArray *arr = [dict objectForKey:@"productList"];
    self.labelArray = [[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++) {
        LabelDTO *dto = [[LabelDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.labelArray addObject:dto];
    }
}
@end
