//
//  SingleDetialViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SingleDetialViewController.h"

@implementation SingleDetialViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"单品详情";
    [self.leftBtn setHidden:NO];
}
-(void)loadBaseUI
{
    [self.viewBack addSubview:self.imageScroll];
    [self.imageScroll addSubview:self.pageControll];
}
#pragma mark --loadUI
-(UIScrollView *)imageScroll
{
    if(!_imageScroll)
    {
        _imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT)];
        _imageScroll.pagingEnabled = YES;
        _imageScroll.delegate = self;
    }
    return _imageScroll;

}
-(UIPageControl *)pageControll
{
    if(!_pageControll)
    {
        _pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0f)/2, PICTURE_HEIGHT - 60.0f, 200.0f, 30.0f)];
    }
    return _pageControll;
}
@end
