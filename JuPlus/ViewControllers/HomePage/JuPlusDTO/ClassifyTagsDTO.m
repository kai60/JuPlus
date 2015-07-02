//
//  ClassifyTagsDTO.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ClassifyTagsDTO.h"

@implementation ClassifyTagsDTO

-(void)loadDTO:(NSDictionary *)dict
{
    self.name = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"name"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"regNo"]];
    
}
@end
