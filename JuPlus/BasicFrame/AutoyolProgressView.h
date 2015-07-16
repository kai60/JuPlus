//
//  AutoyolProgressView.h
//  progress
//
//  Created by 詹文豹 on 14-4-23.
//  Copyright (c) 2014年 詹文豹. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AutoyolProgressView : UIImageView
@property (nonatomic,strong)UIView * middleView;

@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;
//@property(nonatomic,assign)NSInteger tag;
-(void)showActivityViewFrame:(CGRect)frame AndTag:(int)vieTag;
-(void)hideActivityView;
@end
