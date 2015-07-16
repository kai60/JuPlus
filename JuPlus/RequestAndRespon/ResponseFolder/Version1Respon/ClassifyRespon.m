//
//  ClassifyRespon.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ClassifyRespon.h"
#import "ClassifyTagsDTO.h"
@implementation ClassifyRespon

-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.tagsArray = [[NSMutableArray alloc]init];
    NSArray *arr = [dict objectForKey:@"data"];
    for(int i=0;i<[arr count];i++)
  {
      ClassifyTagsDTO *dto = [[ClassifyTagsDTO alloc]init];
      [dto loadDTO:[arr objectAtIndex:i]];
      [self.tagsArray addObject:dto];
  }
}
@end
