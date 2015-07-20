//
//  AutoyolProgressView.m
//  progress
//
//  Created by 詹文豹 on 14-4-23.
//  Copyright (c) 2014年 詹文豹. All rights reserved.
//

#import "JuPlusLoadingView.h"
#import <QuartzCore/QuartzCore.h>
#import "SCGIFImageView.h"
#import "UIImage+GIF.h"
@implementation JuPlusLoadingView
{
    CGFloat viewHeight;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self uifig];
        viewHeight = 40.0f;
        
    }
    return self;
}

-(void)showActivityViewFrame:(CGRect)frame AndTag:(int)vieTag
{
    //[self setBackgroundColor:[UIColor colorWithRed:0 green:.0 blue:0 alpha:0.6]];
    [self.indicatorView startAnimating];

    UIView *view = self.middleView;
    CGFloat imageWidth = 150.0f;
    CGFloat imageH = viewHeight;
        self.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
     if(frame.origin.y ==0)
    {
        view.frame = CGRectMake(frame.size.width/2-imageWidth/2, (frame.size.height-imageH)/2-nav_height, imageWidth, imageH);
    }
    else
    {
        view.frame = CGRectMake(frame.size.width/2-imageWidth/2, (frame.size.height-imageH)/2, imageWidth, imageH);
    }

    
}
-(void)uifig
{
    

    if (self.indicatorView == nil) {
        
        CGFloat viewW = 150.0f;
        self.middleView = [[UIView alloc]initWithFrame:CGRectMake((self.width -viewW)/2, (view_height - viewHeight)/2, viewW, viewHeight)];
        self.middleView.backgroundColor = Color_Basic;
        
        //设置背景为圆角矩形
        self.middleView.layer.cornerRadius = 10.0f;
        self.middleView.layer.masksToBounds = YES;
        [self addSubview:self.middleView];

        
        //初始化:
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 10.0f, 20.0f, 20.0f)];
        
        self.indicatorView.tag = Progress_tag;
        //设置显示样式,见UIActivityIndicatorViewStyle的定义
        self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        //设置显示位置
       // [indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
        
        [self.middleView addSubview:self.indicatorView];

        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.indicatorView.right +10.0f, 10.0f/2, 90.0f, 30.0f)];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:FontType(14.0f)];
        [label setText:@"网络请求中···"];
        [self.middleView addSubview:label];
        //开始显示Loading动画
       // [indicator startAnimating];
        
        
    }
    
    //开始显示Loading动画
//   // NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark.gif" ofType:nil];
//    UIImageView *gifImageView = [[UIImageView alloc]init];
//    [gifImageView setImage:[UIImage sd_animatedGIFNamed:@"1.gif"]];
////    SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath withSeconds:2];
//    CGFloat imgSize = 40.0f;
//    gifImageView.frame = CGRectMake((self.frame.size.width-imgSize)/2, (self.frame.size.height-imgSize)/2,imgSize, imgSize);
//    gifImageView.autoresizingMask = YES;
//    gifImageView.tag = Progress_tag;
//    [self addSubview:gifImageView];

}

-(void)hideActivityView
{
    [self.indicatorView endEditing:YES];
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
