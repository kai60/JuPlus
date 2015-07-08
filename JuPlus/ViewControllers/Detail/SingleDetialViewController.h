//
//  SingleDetialViewController.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//单品详情界面

#import "BaseViewController.h"
#import "RTLabel.h"
#import "PriceView.h"
@interface SingleDetialViewController : BaseViewController<UIScrollViewDelegate>
//单品对应id值
@property (nonatomic,strong)NSString *singleId;

@property (nonatomic,strong)JuPlusUIView *topView;

@property (nonatomic,strong)UIButton *favBtn;
//单品图层展示
@property (nonatomic,strong)UIScrollView *imageScroll;
//
@property (nonatomic,strong)UIPageControl *pageControll;

@property (nonatomic,strong)PriceView *priceV;
//用于展示交互效果的下层图片
@property (nonatomic,strong)JuPlusUIView *bottomV;
//描述
@property (nonatomic,strong)RTLabel *descripLabel;
//主要成分
@property(nonatomic,strong)JuPlusUIView *basisView;
//主要成分数量
@property(nonatomic,strong)UILabel *basisLabel;
@property (nonatomic,strong)UIScrollView *basisScroll;
//购买单品
@property (nonatomic,strong)UIButton *placeOrderBtn;
@end
