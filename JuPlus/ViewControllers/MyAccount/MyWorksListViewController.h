//
//  MyWorksListViewController.h
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//我的作品列表

#import "JuPlusUIViewController.h"
#import "MyWorksDTO.h"
#import "MyWorksCell.h"
@interface MyWorksListViewController : JuPlusUIViewController

@property (nonatomic,strong)UITableView *listTab;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, strong)MyWorksDTO *dto;

@property (nonatomic, strong)NSIndexPath *indexPath;
@property (nonatomic, strong) NSIndexPath *index;
@property (nonatomic, strong) NSMutableDictionary *dic;

@end
