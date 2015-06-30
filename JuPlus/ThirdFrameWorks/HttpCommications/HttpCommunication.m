//
//  HttpCommunication.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HttpCommunication.h"
#import "NetException.h"
#import "TimeoutException.h"
#import "CommonUtil.h"
#import "AutoyolProgressView.h"


@implementation HttpCommunication
//数据处理
+(NSURLSessionDataTask *)request:(JuPlusRequest *)request getResponse:(JuPlusResponse *)response
           Success:(JuPlusCallBackSuccess)successBlock
            failed:(JuPlusCallBackFailed)failedBlock
  showProgressView:(BOOL)showProgressBar
              with:(UIView *)view
{
    if(showProgressBar)
    {
        
    }
    //组包验证信息
    [request validatePackValue:[request getJsonDict] ParamsArray:[request getValidArray] Optional:NO];
    NSString *path = [request getUrlString:[request getUrlArray]];
    if([[request getrequestMethodString] isEqualToString:@"GET"])
    {
       return [[AFNetWorkClient sharedClient] GET:path  parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
            //如果返回状态码为200，则为成功，可以解析data数据
            //解析response内容
            [response parseResponse:JSON encryptionType:EncryptionType_NO signType:NO];
            
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
    }
    else if([[request getrequestMethodString] isEqualToString:@"POST"])
    {
       return  [[AFNetWorkClient sharedClient] POST:path parameters:request.validParams success:^(NSURLSessionDataTask * __unused task, id JSON) {
            //如果返回状态码为200，则为成功，可以解析data数据
            //解析response内容
            [response parseResponse:JSON encryptionType:EncryptionType_NO signType:NO];
            
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
        
    }
    else if([[request getrequestMethodString] isEqualToString:@"DELETE"])
    {
       return  [[AFNetWorkClient sharedClient] DELETE:path parameters:request.validParams  success:^(NSURLSessionDataTask * __unused task, id JSON) {
            
            //如果返回状态码为200，则为成功，可以解析data数据
            //解析response内容
            [response parseResponse:JSON encryptionType:EncryptionType_NO signType:NO];
            
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
        
    }
    else if([[request getrequestMethodString] isEqualToString:@"PUT"])
    {
       return  [[AFNetWorkClient sharedClient] PUT:path parameters:request.validParams success:^(NSURLSessionDataTask * __unused task, id JSON) {
            //如果返回状态码为200，则为成功，可以解析data数据
            //解析response内容
            [response parseResponse:JSON encryptionType:EncryptionType_NO signType:NO];
            
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            
            [self errorExp:error];
        }];
        
    }
    else
    {
        return nil;
    }
    
}
+(void)errorExp:(NSError *)error
{
    
}
+ (UIView *)showWaitingView:(UIView *)view withTitle:(NSString *)string
{
    if(view == nil)
    {
        return nil;
    }
    AutoyolProgressView *autoyol=[[AutoyolProgressView alloc]init];
    [autoyol showActivityViewFrame:view.frame AndTag:view.tag];
    [view addSubview:autoyol];
    if (view.tag==222) {
        view.userInteractionEnabled=NO;
    }
    else
    {
        view.userInteractionEnabled = NO;
    }
    return view;
}

+ (void)dismissWaitingView:(UIView *)aView
{
    if(aView == nil)
    {
        return;
    }
    aView.userInteractionEnabled=YES;
    Class autoClass = [AutoyolProgressView class];
    for(UIView *view in aView.subviews)
    {
        if ([view isKindOfClass:autoClass])
        {
            [(AutoyolProgressView *)view hideActivityView];
            [view removeFromSuperview];
        }
    }
}

@end
