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
#import "PostFaverReq.h"
#import "DeleteFavReq.h"
//#import "UIButton+WebCache.h"
#import "PlaceOrderViewController.h"
#import "LoginViewController.h"
#import "productOrderDTO.h"
#import "UINavigationController+RadialTransaction.h"
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
    [self.view addSubview:self.backScroll];
    [self.backScroll addSubview:self.topView];
        //需要出层级显示效果的view
    [self.backScroll addSubview:self.bottomV];
    [self.bottomV addSubview:self.descripLabel];
    [self.leftBtn setHidden:YES];
   
      UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
    //信息展示
    [self.bottomV addSubview:self.basisView];
    [self.basisView addSubview:self.basisLabel];
    [self.basisView addSubview:self.basisScroll];
    [self.view addSubview:self.placeOrderBtn];
    
}
-(void)backPress:(UIButton *)button
{
    if(self.isfromPackage)
    {
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
        backV.alpha = 0.99;
        backV.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
        [self.view addSubview:backV];
        [UIView animateWithDuration:1.0f animations:^{
            backV.alpha = 1;
        } completion:^(BOOL finished) {
            [backV removeFromSuperview];
        }];

    [self.navigationController radialPopViewControllerWithDuration:0.8 withStartFrame:CGRectMake(self.point.x, self.point.y, 50.0f, 50.0f) comlititionBlock:^{
    }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}
#pragma mark --Reqeust
-(void)startRequest
{
    detailReq = [[SingleDetailReq alloc]init];
    [detailReq setField:self.singleId forKey:@"productNo"];
    [detailReq setField:[CommonUtil getToken] forKey:TOKEN];
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
    [self.topView.favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    if ([detailRespon.isFav intValue]==1) {
        [self.topView.favBtn setSelected:YES];
    }
    for(int i=0;i<[detailRespon.imageArray count];i++)
    {
        NSDictionary *dic = [detailRespon.imageArray objectAtIndex:i];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0.0f, self.topView.imageScroll.width, self.topView.imageScroll.height)];
        [img setImage:[UIImage imageNamed:@"default_square"]];
        [img setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];
        [self.topView.imageScroll addSubview:img];
    }
    self.topView.imageScroll.contentSize = CGSizeMake(SCREEN_WIDTH*[detailRespon.imageArray count], self.topView.imageScroll.height);
    
    [self.topView.priceLabel setPriceTxt:detailRespon.price];
    
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
    self.basisScroll.contentSize = CGSizeMake(60*[detailRespon.basisArray count], self.basisScroll.height);
}
-(void)layoutSubviews
{
    self.basisView.frame = CGRectMake(0.0f, self.descripLabel.bottom +space, SCREEN_WIDTH,130.0f);
    self.bottomV.frame = CGRectMake(0.0f, self.bottomV.top, SCREEN_WIDTH,self.basisView.bottom);

    self.backScroll.contentSize = CGSizeMake(SCREEN_WIDTH, self.bottomV.bottom+20.0f);
    
}
#pragma mark --loadUI
-(ImageScrollView *)topView
{
    if(!_topView)
    {
        _topView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT)];
    }
    return _topView;
}
-(UIScrollView *)backScroll
{
    if(!_backScroll)
    {
        _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f , nav_height - 20.0f, SCREEN_WIDTH, view_height - TABBAR_HEIGHT + 20.0f)];
    }
    return _backScroll;
}
-(JuPlusUIView *)bottomV
{
    if(!_bottomV)
    {
        _bottomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.topView.bottom, SCREEN_WIDTH, view_height - self.topView.top)];
    }
    return _bottomV;
}
-(RTLabel *)descripLabel
{
    if(!_descripLabel)
    {
        UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, space, self.bottomV.width, 20.0f)];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.textColor = Color_Basic;
        titleL.text = @"单品详情";
        [titleL setFont:FontType(16.0f)];
        [self.bottomV addSubview:titleL];
        _descripLabel = [[RTLabel alloc]initWithFrame:CGRectMake(space,titleL.bottom+space, SCREEN_WIDTH - space*2, 100.0f)];
        
    }
    return _descripLabel;
}
-(JuPlusUIView *)basisView
{
    if(!_basisView)
    {
        _basisView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.descripLabel.bottom+space, SCREEN_WIDTH, 120.0f)];
    }
    return _basisView;
}
-(UILabel *)basisLabel
{
    if (!_basisLabel) {
        
        _basisLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, space, self.basisView.width, 20.0f)];
        _basisLabel.textAlignment = NSTextAlignmentCenter;
        _basisLabel.textColor = Color_Basic;
        self.basisLabel.text = @"主要成分";

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
        _placeOrderBtn.alpha = ALPHLA_BUTTON;
        [_placeOrderBtn addTarget:self action:@selector(payPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}
#pragma mark --btnPress
//收藏、取消收藏
-(void)favBtnClick:(UIButton *)sender
{
    if([CommonUtil isLogin])
    {
        if(sender.selected==YES)
        {
            [self cancelFav];
        }
        else
        {
            [self postFav];
        }
    }
    else
    {
        [self login];
    }
}
//取消收藏
-(void)cancelFav
{
    DeleteFavReq *req = [[DeleteFavReq alloc]init];
    JuPlusResponse *respon =[[JuPlusResponse alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.singleId forKey:@"objNo"];
    [req setField:@"1" forKey:@"objType"];

    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.topView.favBtn startAnimation];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];

}
//添加收藏
-(void)postFav
{
    PostFaverReq *req = [[PostFaverReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.singleId forKey:@"objNo"];
    [req setField:@"1" forKey:@"objType"];

    JuPlusResponse *respon =[[JuPlusResponse alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.topView.favBtn startAnimation];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
//点击购买
-(void)payPress
{
    if([CommonUtil isLogin])
    {
    PlaceOrderViewController *order = [[PlaceOrderViewController alloc]init];
        productOrderDTO *singleDTO = [[productOrderDTO alloc]init];
        singleDTO.productNo = self.singleId;
        singleDTO.regNo = self.regNo;
        singleDTO.imgUrl = [[detailRespon.imageArray firstObject] objectForKey:@"imgUrl"];
        singleDTO.price = detailRespon.price;
        singleDTO.productName = detailRespon.proName;
        singleDTO.countNum = @"1";
        order.regArray = [NSArray arrayWithObjects:singleDTO, nil];
      [self.navigationController pushViewController:order animated:YES];
    }
    else
    {
        [self login];
    }
}
-(void)login
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
@end
