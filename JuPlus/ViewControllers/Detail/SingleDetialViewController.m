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
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.imageScroll];
    [self.topView addSubview:self.favBtn];
    [self.topView addSubview:self.priceV];
    [self.topView addSubview:self.pageControll];
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
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
}
#pragma mark --fileData
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
    
    [self.priceV setPriceText:detailRespon.price];
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
//主要成分内容
-(void)fileBasisScroll
{
    for(int i=0;i<[detailRespon.basisArray count];i++)
    {
        CGFloat imgW = 50.0f;
        NSDictionary *dic = [detailRespon.basisArray objectAtIndex:i];
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.frame = CGRectMake(i*(50.0f+space/2), 0.0f,imgW, imgW);
        imgBtn.layer.masksToBounds = YES;
        imgBtn.layer.cornerRadius = imgW/2;
        [imgBtn setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];
        [self.basisScroll addSubview:imgBtn];
    }
    self.basisLabel.text = [NSString stringWithFormat:@"主要成分(%lu)",(unsigned long)[detailRespon.basisArray count]];
    self.basisScroll.contentSize = CGSizeMake(60*[detailRespon.basisArray count], self.basisScroll.height);

}
-(void)layoutSubviews
{
    self.basisView.frame = CGRectMake(0.0f, self.descripLabel.bottom +space, SCREEN_WIDTH,130.0f);
    
}
#pragma mark --loadUI
-(JuPlusUIView *)topView
{
    if(!_topView)
    {
        _topView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, DETAIL_HEIGHT)];
    }
    return _topView;
}
-(UIScrollView *)imageScroll
{
    if(!_imageScroll)
    {
        _imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, DETAIL_HEIGHT)];
        _imageScroll.pagingEnabled = YES;
        _imageScroll.delegate = self;
    }
    return _imageScroll;

}
-(UIButton *)favBtn
{
    if(!_favBtn)
    {
        CGFloat btnR = 25.0f;
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favBtn setImage:[UIImage imageNamed:@"fav_unsel"] forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"fav_sel"] forState:UIControlStateSelected];
        _favBtn.frame = CGRectMake(self.topView.width - btnR - space/2, space, btnR, btnR);
        [_favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _favBtn;
}
-(PriceView *)priceV
{
    if(!_priceV)
    {
        _priceV = [[PriceView alloc]initWithFrame:CGRectMake(100.0f, DETAIL_HEIGHT - 30.0f, 220.0f, 30.0f)];
    }
    return _priceV;
}
//页码控制器
-(UIPageControl *)pageControll
{
    if(!_pageControll)
    {
        _pageControll = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0f)/2, DETAIL_HEIGHT - 60.0f, 200.0f, 30.0f)];
    }
    return _pageControll;
}
-(JuPlusUIView *)bottomV
{
    if(!_bottomV)
    {
        _bottomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.topView.bottom, SCREEN_WIDTH, view_height - self.imageScroll.top)];
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
        _basisView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.descripLabel.bottom+space, SCREEN_WIDTH, 130.0f)];
        UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH  , 2.0f)];
        [top setBackgroundColor:Color_Gray];
        [_basisView addSubview:top];

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
//收藏、取消收藏
-(void)favBtnClick:(UIButton *)sender
{
    
}
//点击购买
-(void)payPress
{
    PlaceOrderViewController *order = [[PlaceOrderViewController alloc]init];
    order.regNo = self.singleId;
    order.imgUrl = [[detailRespon.imageArray firstObject] objectForKey:@"imgUrl"];
    order.name = detailRespon.proName;
    order.price = detailRespon.price;
    [self.navigationController pushViewController:order animated:YES];
}
@end
