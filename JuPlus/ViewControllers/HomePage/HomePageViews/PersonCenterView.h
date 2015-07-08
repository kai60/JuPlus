//
//  PersonCenterView.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"

@interface PersonCenterView : JuPlusUIView
//个人信息展示
@property(nonatomic,strong)JuPlusUIView *topView;

@property(nonatomic,strong)UIImageView *portrait;

@property(nonatomic,strong)JuPlusUILabel *nickLabel;
//存储作品数/买入/收藏
@property(nonatomic,strong)NSMutableArray *listArr;
@end
