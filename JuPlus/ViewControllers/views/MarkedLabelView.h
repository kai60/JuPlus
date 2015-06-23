//
//  FurnHLabelBtn.h
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 凹凸租车. All rights reserved.
//自定义标签显示

#import <UIKit/UIKit.h>
#import "JuPlusUIView.h"
@interface MarkedLabelView :JuPlusUIView

-(id)initWithFrame:(CGRect)frame;
//定点image
@property(nonatomic,strong)UIImageView *tipsImage;
//渐隐图层
@property(nonatomic,strong)UIImageView *alphaImage;
//标签背景图
@property(nonatomic,strong)UIImageView *labelRight;
//标签内容
@property(nonatomic,strong)UILabel *labelText;
//点击事件
@property(nonatomic,strong)UIButton *touchBtn;
@end
