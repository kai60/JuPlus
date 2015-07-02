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
#import "LFCGzipUtillity.h"
#import "SecurityUtil.h"
#import "UnPackException.h"
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
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   NSMutableDictionary *errDic = [[NSMutableDictionary alloc]init];
                   [errDic setObject:[resalut objectForKey:@"resCode"] forKey:@"resCode"];
                   [errDic setObject:[resalut objectForKey:@"resMsg"] forKey:@"resMsg"];
                   [errDic setObject:[request getrequestMethodString] forKey:@"reqMethod"];
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });
                   
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }

        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
    }
    else if([[request getrequestMethodString] isEqualToString:@"POST"])
    {
        NSMutableDictionary *dic=[request getJsonDict];

       NSData *data = [LFCGzipUtillity gzipData:[self dictToJSONData:dic]];
       return  [[AFNetWorkClient sharedClient] POST:path parameters:data success:^(NSURLSessionDataTask * __unused task, id JSON) {
           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   NSMutableDictionary *errDic = [[NSMutableDictionary alloc]init];
                   [errDic setObject:[resalut objectForKey:@"resCode"] forKey:@"resCode"];
                   [errDic setObject:[[resalut objectForKey:@"resMsg"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"resMsg"];
                   [errDic setObject:[request getrequestMethodString] forKey:@"reqMethod"];
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });

                   
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
        
    }
    else if([[request getrequestMethodString] isEqualToString:@"DELETE"])
    {
       return  [[AFNetWorkClient sharedClient] DELETE:path parameters:request.validParams  success:^(NSURLSessionDataTask * __unused task, id JSON) {
            
           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               { NSMutableDictionary *errDic = [[NSMutableDictionary alloc]init];
                   [errDic setObject:[resalut objectForKey:@"resCode"] forKey:@"resCode"];
                   [errDic setObject:[resalut objectForKey:@"resMsg"] forKey:@"resMsg"];
                   [errDic setObject:[request getrequestMethodString] forKey:@"reqMethod"];
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });
                   
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }
           
        } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
            //反馈错误信息（网络连接失败等信息）
            [self errorExp:error];
        }];
        
    }
    else if([[request getrequestMethodString] isEqualToString:@"PUT"])
    {
       return  [[AFNetWorkClient sharedClient] PUT:path parameters:request.validParams success:^(NSURLSessionDataTask * __unused task, id JSON) {
           //解析response内容
           if([JSON isKindOfClass:[NSDictionary class]])
           {
               NSDictionary *resalut = (NSDictionary *)JSON;
               //返回数据正确 ，则解析到response
               if([[resalut objectForKey:RESPONSE_CODE] isEqualToString:RESPONSE_OK])
               {
                   [response parseResponse:resalut encryptionType:EncryptionType_NO signType:NO];
                   dispatch_async(dispatch_get_main_queue(), ^{
                       successBlock(response);
                   });
               }
               else
               {
                   NSMutableDictionary *errDic = [[NSMutableDictionary alloc]init];
                   [errDic setObject:[resalut objectForKey:@"resCode"] forKey:@"resCode"];
                   [errDic setObject:[resalut objectForKey:@"resMsg"] forKey:@"resMsg"];
                   [errDic setObject:[request getrequestMethodString] forKey:@"reqMethod"];
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       failedBlock(errDic);
                   });
               }
               
           }
           else
           {
               @throw [UnPackException exception:@"Json数据格式错误"];
           }
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
+ (NSData *)dictToJSONData:(NSDictionary *)dict{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+(void)errorExp:(NSError *)error
{
    NSLog(@"%@",error);
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
