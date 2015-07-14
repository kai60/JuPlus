//
//  AutoyolProgressView.m
//  progress
//
//  Created by 詹文豹 on 14-4-23.
//  Copyright (c) 2014年 詹文豹. All rights reserved.
//

#import "AutoyolProgressView.h"
#import "SCGIFImageView.h"
#import <QuartzCore/QuartzCore.h>
#define Progress_tag 2014
@implementation AutoyolProgressView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self uifig];
    }
    return self;
}

-(void)showActivityViewFrame:(CGRect)frame AndTag:(int)vieTag
{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:.0 blue:0 alpha:0.6]];
    UIView *view = [self viewWithTag:Progress_tag];
    CGFloat imageWidth = 82.0f;
        self.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
     if(frame.origin.y ==0)
    {
        view.frame = CGRectMake(frame.size.width/2-imageWidth/2, (frame.size.height-imageWidth)/2-64.0f, imageWidth, imageWidth);
    }
    else
    {
        view.frame = CGRectMake(frame.size.width/2-imageWidth/2, (frame.size.height-imageWidth)/2, imageWidth, imageWidth);
    }
    
}
-(void)uifig
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark.gif" ofType:nil];
    SCGIFImageView* gifImageView = [[SCGIFImageView alloc] initWithGIFFile:filePath withSeconds:2];
    CGFloat imgSize = 82.0f;
    gifImageView.frame = CGRectMake((self.frame.size.width-imgSize)/2, (self.frame.size.height-imgSize)/2,imgSize, imgSize);
    gifImageView.autoresizingMask = YES;
    gifImageView.tag = Progress_tag;
    [self addSubview:gifImageView];

}

-(void)hideActivityView
{
    
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
