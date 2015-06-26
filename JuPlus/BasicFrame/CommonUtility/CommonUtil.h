//
//  CommonUtil.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonUtil : NSObject

#pragma userDefalut相关
+(id )getUserDefaultsValueWithKey:(NSString *) key;

+(void)setUserDefaultsValue:(id) value forKey:(NSString *)key;

+(void)removeUserDefaultsValue:(NSString *) key;
//根据label宽度得到字符串占用高度
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelWidth:(CGFloat)width  andFont:(UIFont *)font;
//根据label高度得到字符串占用宽度
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelHeight:(CGFloat)height  andFont:(UIFont *)font;

@end
