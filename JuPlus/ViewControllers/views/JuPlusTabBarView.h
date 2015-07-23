//
//  JuPlusTabBarView.h
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//自定义tabBar，实现不同界面之间切换效果

#import "JuPlusUIView.h"

@protocol TabBarViewDelegate <NSObject>

-(void)changeTo:(NSInteger)tag;

@end

@interface JuPlusTabBarView : JuPlusUIView
@property(nonatomic,assign)id<TabBarViewDelegate>delegate;

@property(nonatomic,strong)UIButton *selectedBtn;
//个人
@property(nonatomic,strong)UIButton *personBtn;

@property(nonatomic,strong)NSMutableArray *buttonArr;

-(void)resetButtonArray;
@end
