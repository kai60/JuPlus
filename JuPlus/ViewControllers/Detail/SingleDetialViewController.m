//
//  SingleDetialViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SingleDetialViewController.h"
#import "SingleDetailReq.h"
#import "SingleDetailRespon.h"
#import "SingleDetailDTO.h"
//#import "UIButton+WebCache.h"
#import "PlaceOrderViewController.h"
@implementation SingleDetialViewController
{
    SingleDetailReq *detailReq;
    SingleDetailRespon *detailRespon;
}
#define space 20.0f
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"单品详情";
    [self.leftBtn setHidden:NO];
}
-(void)loadBaseUI
{
    //滚动展示图层
    [self.view addSubview:self.imageScroll];
    [self.imageScroll addSubview:self.pageControll];
    //需要出层级显示效果的view
    [self.view addSubview:self.bottomV];
    [self.bottomV addSubview:self.descripLabel];

    //信息展示
    [self.bottomV addSubview:self.basisView];
    [self.basisView addSubview:self.basisLabel];
    [self.basisView addSubview:self.basisScroll];
    [self.view addSubview:self.placeOrderBtn];
    
}
#pragma mark --Reqeust
-(void)startRequest
{
    detailReq = [[SingleDetailReq alloc]init];
    [detailReq setField:self.singleId forKey:@"productNo"];
    detailRespon = [[SingleDetailRespon alloc]init];
    [HttpCommunication request:detailReq getResponse:detailRespon Success:^(JuPlusResponse *response) {
        //请求成功之后 处理
        //图片数据
        [self fileImageData];
        //加载描述
        [self fileExplainTxt];
        //加载主要成分
        [self fileBasisScroll];
        //重置布局
        [self layoutSubviews];

    } failed:^(NSDictionary *errorDTO) {
        
    } showProgressView:YES with:self.view];
    
}
-(void)fileImageData
{
    for(int i=0;i<[detailRespon.imageArray count];i++)
    {
        NSDictionary *dic = [detailRespon.imageArray objectAtIndex:i];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0.0f, self.imageScroll.width, self.imageScroll.height)];
        [img setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];
        [self.imageScroll addSubview:img];
    }
    self.imageScroll.contentSize = CGSizeMake(SCREEN_WIDTH*[detailRespon.imageArray count], self.imageScroll.height);
}
-(void)fileExplainTxt
{
    //描述文字
    [self.descripLabel setText:detailRespon.htmlString];
    CGSize optimumSize = [self.descripLabel optimumSize];
    CGRect frame = [self.descripLabel frame];
    frame.size.height = (int)optimumSize.height+5; // +5 to fix height issue, this should be automatically fixed in iOS5
    [self.descripLabel setFrame:frame];

}
-(void)fileBasisScroll
{
    for(int i=0;i<[detailRespon.basisArray count];i++)
    {
        NSDictionary *dic = [detailRespon.imageArray objectAtIndex:i];
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.frame = CGRectMake(i*(40.0f+space), space,40.0f, 40.0f);
        [imgBtn setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];
    }
    self.imageScroll.contentSize = CGSizeMake(SCREEN_WIDTH*[detailRespon.imageArray count], self.imageScroll.height);

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
        _imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, DETAIL_HEIGHT)];
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
        _descripLabel = [[RTLabel alloc]initWithFrame:CGRectMake(space,space, SCREEN_WIDTH - space*2, 100.0f)];
        
    }
    return _descripLabel;
}
-(JuPlusUIView *)basisView
{
    if(!_basisView)
    {
        _basisView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.descripLabel.bottom+space, SCREEN_WIDTH, 100.0f)];
    }
    return _basisView;
}
-(UILabel *)basisLabel
{
    if (!_basisLabel) {
        _basisLabel = [[UILabel alloc]initWithFrame:CGRectMake(space, space, 120.0f, 20.0f)];
        _basisLabel.textColor = [UIColor grayColor];
        [_basisLabel setFont:FontType(16.0f)];
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
        _placeOrderBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeOrderBtn setTitle:@"单品购买" forState:UIControlStateNormal];
        [_placeOrderBtn setBackgroundColor:Color_Basic];
        [_placeOrderBtn addTarget:self action:@selector(payPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}
#pragma mark --btnPress
//点击购买
-(void)payPress
{
    PlaceOrderViewController *order = [[PlaceOrderViewController alloc]init];
    order.regNo = self.singleId;
    [self.navigationController pushViewController:order animated:YES];
}
@end
