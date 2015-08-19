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
//记录  如果是从套餐列表中的套餐跳转到详情，则回来不需要reload以下collectionView
@property (nonatomic,assign)BOOL isPackage;
//是否为显示分享列表
@property (nonatomic,assign)BOOL isShared;

@end
