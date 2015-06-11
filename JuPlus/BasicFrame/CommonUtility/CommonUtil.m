//
//  CommonUtil.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

+(id )getUserDefaultsValueWithKey:(NSString *) key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+(void)setUserDefaultsValue:(id ) value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}
+(void)removeUserDefaultsValue:(NSString *) key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
@end
