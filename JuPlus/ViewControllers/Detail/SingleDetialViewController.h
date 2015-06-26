//
//  SingleDetialViewController.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//单品详情界面

#import "BaseViewController.h"

@interface SingleDetialViewController : BaseViewController<UIScrollViewDelegate>
//单品对应id值
@property (nonatomic,strong)NSString *singleId;
//单品图层展示
@property (nonatomic,strong)UIScrollView *imageScroll;

@property (nonatomic,strong)UIPageControl *pageControll;
@end
