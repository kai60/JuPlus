//
//  PlaceOrderViewController.h
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BaseViewController.h"
//下单界面
@interface PlaceOrderViewController : BaseViewController
//单品编号
@property(nonatomic,strong)NSString *regNo;

@property(nonatomic,strong)NSString *imgUrl;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *price;
//是单品还是套餐
@property(nonatomic,assign)BOOL isSingle;
@end
