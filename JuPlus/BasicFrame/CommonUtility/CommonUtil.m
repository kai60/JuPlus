//
//  CommonUtil.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

//================================================================================================

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
//----------------------------------------------------------------------------------------------
#pragma sizeFont
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelWidth:(CGFloat)width  andFont:(UIFont *)font
{
    NSDictionary *attribute = @{ NSFontAttributeName: font};
    //NSStringDrawingUsesLineFragmentOrigin获得label的长度和宽度
    CGSize size = [Str boundingRectWithSize:CGSizeMake(width, 999.0f) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size;
    
}
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelHeight:(CGFloat)height  andFont:(UIFont *)font
{
        NSDictionary *attribute = @{ NSFontAttributeName: font};
        //NSStringDrawingUsesLineFragmentOrigin获得label的长度和宽度
        CGSize size = [Str boundingRectWithSize:CGSizeMake(640.0f, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        //  NSLog(@"size.width:%f",size.width);
        return size;
}
//----------------------------------------------------------------------------------------------
#pragma mark --token
//判断是否登录成功
+(BOOL)isLogin
{
    return !IsStrEmpty([self getUserDefaultsValueWithKey:@"token"]);
}
//得到token值
+(NSString *)getToken
{
    return [self getUserDefaultsValueWithKey:@"token"];
}
@end
