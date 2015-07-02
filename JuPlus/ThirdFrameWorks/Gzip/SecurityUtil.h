//
//  SecurityUtil.h
//  Autoyol
//
//  Created by Ning Gang on 13-12-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject

//nsdata 2 hex string
+(NSString *)toHexString:(NSData *)data;

//hex string 2 nsdata
+(NSData *) hexStrToNSData:(NSString *)hexStr;

//MD5
+(NSData*)MD5:(NSData*)data;

//3Des加密
+(NSData *)TDES:(NSData*)PlaintextData withKey:(NSData *)key;

//3Des解密
+(NSData *)UTDES:(NSData *)CiphertextDeData withKey:(NSData *)key;
@end
