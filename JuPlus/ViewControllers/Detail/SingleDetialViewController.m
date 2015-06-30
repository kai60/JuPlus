//
//  SingleDetialViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SingleDetialViewController.h"
CGFloat space = 20.0f;
@implementation SingleDetialViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"单品详情";
    [self.leftBtn setHidden:NO];
}
-(void)loadBaseUI
{
    //滚动展示图层
    [self.viewBack addSubview:self.imageScroll];
    [self.imageScroll addSubview:self.pageControll];
    [self.viewBack addSubview:self.bottomV];
    [self.bottomV addSubview:self.descripLabel];

    //信息展示
    [self.bottomV addSubview:self.basisView];
    [self.basisView addSubview:self.basisLabel];
    [self.basisView addSubview:self.basisScroll];
    
}
-(void)startRequest
{
    CGSize optimumSize = [self.descripLabel optimumSize];
    CGRect frame = [self.descripLabel frame];
    frame.size.height = (int)optimumSize.height+5; // +5 to fix height issue, this should be automatically fixed in iOS5
    [self.descripLabel setFrame:frame];
    [self layoutSubviews];

}
-(void)layoutSubviews
{
    self.basisView.frame = CGRectMake(0.0f, self.descripLabel.bottom, SCREEN_WIDTH,100.0f);
    
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
-(JuPlusUIView *)bottomV
{
    if(!_bottomV)
    {
        _bottomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.imageScroll.bottom, SCREEN_WIDTH, view_height - self.imageScroll.top)];
    }
    return _bottomV;
}
-(RTLabel *)descripLabel
{
    if(!_descripLabel)
    {
        _descripLabel = [[RTLabel alloc]initWithFrame:CGRectMake(0.0f,0.0f, SCREEN_WIDTH, 100.0f)];
        
    }
    return _descripLabel;
}
-(JuPlusUIView *)basisView
{
    if(!_basisView)
    {
        _basisView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.imageScroll.bottom, SCREEN_WIDTH, 100.0f)];
    }
    return _basisView;
}
-(UILabel *)basisLabel
{
    if (!_basisLabel) {
        _basisLabel = [[UILabel alloc]initWithFrame:CGRectMake(space, space, 120.0f, 20.0f)];
    }
    return _basisLabel;
}
-(UIScrollView *)basisScroll
{
    if(!_basisScroll)
    {
        _basisScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(space, self.basisLabel.bottom + space, self.basisView.width, 60.0f)];
    }
    return _basisScroll;
}
-(UIButton *)placeOrderBtn
{
    if(!_placeOrderBtn)
    {
        _placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeOrderBtn.frame = CGRectMake(0.0f, view_height - 44.0f, SCREEN_WIDTH, 44.0f);
        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeOrderBtn addTarget:self action:@selector(payPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}
#pragma mark --btnPress
//点击购买
-(void)payPress
{
    
}
@end
