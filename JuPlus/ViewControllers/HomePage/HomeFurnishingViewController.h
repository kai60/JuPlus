//
//  HomeFurnishingViewController.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//选择完标签之后跳转到筛选首页

#import "BaseViewController.h"
#import "PackageCell.h"
#import "ClassifyView.h"
@interface HomeFurnishingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *listTab;
@property (nonatomic,strong)ClassifyView *classifyV;

@end
