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
#import "ImageScrollView.h"
@interface SingleDetialViewController : BaseViewController<UIScrollViewDelegate>
//单品对应id值
@property (nonatomic,strong)NSString *singleId;
//该单品对应的套餐(即从哪个套餐过来的)
@property (nonatomic,strong)NSString *regNo;
@property (nonatomic,strong)ImageScrollView *topView;

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
