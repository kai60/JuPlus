//
//  CommonUtil.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

#pragma userDefalut相关
+(id )getUserDefaultsValueWithKey:(NSString *) key;

+(void)setUserDefaultsValue:(id) value forKey:(NSString *)key;

+(void)removeUserDefaultsValue:(NSString *) key;

@end
