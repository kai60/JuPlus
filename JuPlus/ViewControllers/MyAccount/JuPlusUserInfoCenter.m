//
//  JuPlusUserInfoCenter.m
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUserInfoCenter.h"

@implementation JuPlusUserInfoCenter

DEF_SINGLETON( JuPlusUserInfoCenter );


- (id)init {
    
    self = [super init];
    
    if (self) {
        _userInfo.token = [CommonUtil getUserDefaultsValueWithKey:TOKEN];
        _userInfo.nickname = [CommonUtil getUserDefaultsValueWithKey:@"nickname"];
        _userInfo.portraitUrl = [CommonUtil getUserDefaultsValueWithKey:@"portraitUrl"];
        _userInfo.mobile = [CommonUtil getUserDefaultsValueWithKey:@"mobile"];

    }
    return self;
}

- (void)resetUserInfo
{
    [self logout];
    self.userInfo = nil;
}

-(UserInfoDTO *)userInfo
{
    if (!_userInfo) {
        _userInfo = [[UserInfoDTO alloc] init];
    }
    return _userInfo;
}
-(void)logout
{
    [CommonUtil removeUserDefaultsValue:TOKEN];
    [CommonUtil removeUserDefaultsValue:@"nickname"];
    [CommonUtil removeUserDefaultsValue:@"portraitUrl"];
    [CommonUtil removeUserDefaultsValue:@"mobile"];
}
@end
