//
//  SecurityUtil.m
//  Autoyol
//
//  Created by Ning Gang on 13-12-8.
//  Copyright (c) 2013年 Autoyol. All rights reserved.
//

#import "SecurityUtil.h"
#import "des.h"
#import "md5.h"

@implementation SecurityUtil

+(NSString *)toHexString:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

+(NSData *) hexStrToNSData:(NSString *)hexStr
{
    
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= hexStr.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* ch = [hexStr substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:ch];
        unsigned int intValue;
        
        [scanner scanHexInt:&intValue];
        
        [data appendBytes:&intValue length:1];
        
    }
    
    return data;
    
}

+(NSData*)MD5:(NSData*)data
{
    unsigned char outData[16] = {0};
    md5((unsigned char*)[data bytes], [data length], outData);
    return [NSData dataWithBytes:outData length:16];
}

//3Des加密
+(NSData *)TDES:(NSData*)PlaintextData withKey:(NSData *)key
{
    unsigned char *buf = malloc(([PlaintextData length]/8+1)*8);
    int len = TDES(buf,(unsigned char*)[PlaintextData bytes],[PlaintextData length],(unsigned char*)[key bytes]);
    NSData *DesData = [NSData dataWithBytes:buf length:len];
    return DesData;
}
//3Des解密
+(NSData *)UTDES:(NSData *)CiphertextDeData withKey:(NSData *)key
{
    unsigned char *buf = malloc(([CiphertextDeData length]/8+1)*8);
    UNTDES(buf, (unsigned char*)[CiphertextDeData bytes], [CiphertextDeData length], (unsigned char*)[key bytes]);
    NSData *DesData = [NSData dataWithBytes:buf length:[CiphertextDeData length]];
    return DesData;
}

//Des加密
+(NSData *)DES:(NSData *)PlaintextData withKey:(NSData *)key
{
    unsigned char *buf = malloc(([PlaintextData length]/8+1)*8);
    int len = DES(buf, (unsigned char *)[PlaintextData bytes], [PlaintextData length], (unsigned char*)[key bytes]);
    NSData *DesData = [NSData dataWithBytes:buf length:len];
    return DesData;
}
//Des解密
+(NSData *)UDES:(NSData *)CiphertextDeData withKey:(NSData *)key
{
    unsigned char *buf = malloc(([CiphertextDeData length]/8+1)*8);
    UNDES(buf, (unsigned char*)[CiphertextDeData bytes], [CiphertextDeData length], (unsigned char*)[key bytes]);
    NSData *DesData = [NSData dataWithBytes:buf length:[CiphertextDeData length]];
    return DesData;
}

@end
