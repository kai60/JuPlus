//
//  CollectionView.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"

@interface CollectionView : JuPlusUIView<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate>
@property (nonatomic,strong)UITableView *listTab;

@end
