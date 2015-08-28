//
//  JuPlusGetLocation.h
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JuPlusGetLocation : NSObject
AS_SINGLETON(JuPlusGetLocation);
//经纬度
@property(nonatomic,assign)CGFloat locLong;
@property(nonatomic,assign)CGFloat locLat;

-(void)getLocation;
@end
