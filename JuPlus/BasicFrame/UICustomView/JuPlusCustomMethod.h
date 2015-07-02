//
//  JuPlusCustomMethod.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#ifndef JuPlus_JuPlusCustomMethod_h
#define JuPlus_JuPlusCustomMethod_h
#import "UIView+JuPlusUIView.h"
#import "UIColor+JuPlusColor.h"
#import "UIImage+JuPlusUIImage.h"
#import "NSString+JuPlusString.h"

#pragma mark - Nil or NULL 为空判断
//是否为空或是[NSNull null]

#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""])||([(_ref)isEqualToString:@"<null>"])||([(_ref)isEqualToString:@"(null)"]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

//----------------------------------------------------------------------------------------------

#endif
