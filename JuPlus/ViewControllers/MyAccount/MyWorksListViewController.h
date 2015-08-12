//
//  MyWorksListViewController.h
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//我的作品列表

#import "BaseViewController.h"
#import "MyWorksDTO.h"
#import "MyWorksCell.h"
@interface MyWorksListViewController : BaseViewController

@property (nonatomic,strong)UITableView *listTab;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end
