//
//  UIColor+FurnHColor.h
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef  RGBCOLOR
//不带透明度的rgb值
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor colorWithRGBHex:V]

#define Color_Basic RGBCOLOR(172, 120, 39)
#define Color_Gray_lines RGBACOLOR(111,111,111,0.3)
@interface UIColor (JuPlusColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithCssName:(NSString *)cssColorName;

+ (UIColor *)bgColor_nav;
+ (UIColor *)bgColor_view;
+ (UIColor *)bgColor_cell;

+ (UIColor *)textColor_dark;
+ (UIColor *)textColor_light;

@end
