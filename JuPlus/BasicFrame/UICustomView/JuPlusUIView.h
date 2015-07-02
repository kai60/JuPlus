//
//  JuPlusUIView.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuPlusCustomMethod.h"
#import "JuPlusEnvironmentConfig.h"
#import "CommonUtil.h"
#import "HttpCommunication.h"
@interface JuPlusUIView : UIView
-(void)errorExp:(NSDictionary *)exp;
//提示的错误消息
- (void)showAlertView:(NSString *)msg withTag:(int)tag;
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
