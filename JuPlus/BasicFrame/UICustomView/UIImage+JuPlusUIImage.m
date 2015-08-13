//
//  UIImage+FurnHUIImage.m
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UIImage+JuPlusUIImage.h"
#import <CoreText/CoreText.h>
@implementation UIImage (JuPlusUIImage)

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

CGFloat RadiansToDegrees(CGFloat radians)
{
    return radians * 180/M_PI;
}

+ (UIImage *)noCachegetImageFromBundle:(NSString *)imageName
{
    NSString *imageFile = [[NSString alloc] initWithFormat:@"%@/%@",
                           [[NSBundle mainBundle] resourcePath], imageName];
    return [[UIImage alloc] initWithContentsOfFile:imageFile];
}

+ (UIImage *)stregetImageFromBundle:(NSString *)imageName
{
    if (imageName == nil) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    return streImage;
}

+ (UIImage *)stregetImageFromBundle:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y
{
    if (imageName == nil) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *streImage = [image stretchableImageWithLeftCapWidth:x topCapHeight:y];
    return streImage;
}

- (UIImage *)stretched
{
    CGFloat leftCap = floorf(self.size.width / 2.0f);
    CGFloat topCap = floorf(self.size.height / 2.0f);
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

- (UIImage *)grayscale
{
    CGSize size = self.size;
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, size.width, size.height, 8, 0, colorSpace, kCGBitmapAlphaInfoMask);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, rect, [self CGImage]);
    CGImageRef grayscale = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage * image = [UIImage imageWithCGImage:grayscale];
    CFRelease(grayscale);
    
    return image;
}


- (UIColor *)patternColor
{
    return [UIColor colorWithPatternImage:self];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//得到高斯模糊的图片
+ (UIImage *)filterImage:(UIImage *)image
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}
//压缩图片，发送数据
-(NSString *)getImageString
{
    NSData* pictureData = UIImageJPEGRepresentation(self,0.1);//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);
    //NSLog(@"调用了image@String方法");
    //NSLog(@"%@这个值是什么实现的？",pictureData);
    NSString* pictureDataString = [pictureData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];//图片转码成为base64Encoding，
    //NSLog(@"%@++++是空值么？",pictureDataString);
    //NSLog(@"base64转码，的实验");
    return pictureDataString;
    
}

//绘制图像上的文字
-(UIImage *)addText:(NSString *)text
{
    
    //上下文的大小
    int w = self.size.width;
    int h = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 22 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h),self.CGImage);//将img绘至context上下文中
    //设置字体
    CTFontRef font = CTFontCreateWithName(CFSTR("ZHSRXT--GBK1-0"), 25, NULL);
    NSString *strNS = text;
    CFStringRef strRef = (__bridge CFStringRef)strNS;
    
    // Create an attributed string
    CFStringRef keys[] = { kCTFontAttributeName };
    CFTypeRef values[] = { font };
    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    CFAttributedStringRef attrString = CFAttributedStringCreate(NULL, strRef, attr);
    CFRelease(attr);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0); //白色
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);//设置字体绘制的颜色
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);//设置字体绘制方式
    // Draw the string
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);  //Use this one when using standard view coordinates
    CGContextSetTextPosition(context, (w - 22.0f*text.length)/2, 30.0f);
    CTLineDraw(line, context);
    
    // Clean up
    CFRelease(line);
    CFRelease(attrString);
    CFRelease(font);
    
    //    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    //    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);//将img绘至context上下文中
    //    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    //    char* text = (char *)[text1 cStringUsingEncoding:NSUTF8StringEncoding];
    //    // CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);//设置字体的大小
    //    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    //    CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
    //
    //    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));//设置字体绘制的位置
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
}

@end
