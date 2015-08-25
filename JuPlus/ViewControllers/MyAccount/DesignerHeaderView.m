//
//  DesignerHeaderView.m
//  JuPlus
//
//  Created by 高岐 on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerHeaderView.h"

@implementation DesignerHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化头像
        self.personHeadImageView = [[UIImageView alloc] init];
        self.personHeadImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - PICTURE_HEIGHT / 10, 18, PICTURE_HEIGHT / 5, PICTURE_HEIGHT / 5);
        self.personHeadImageView.backgroundColor = Color_Gray_lines;
        self.personHeadImageView.image = [UIImage imageNamed:@"touxiang"];
        // 设置圆角
        self.personHeadImageView.layer.masksToBounds = YES;
        self.personHeadImageView.layer.cornerRadius = PICTURE_HEIGHT / 10;
        [self addSubview:self.personHeadImageView];
        
//        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(0, 24 + PICTURE_HEIGHT / 4 + 30, SCREEN_WIDTH, 20)];
//        self.detail.text = @"啊!逗比~";
//        self.detail.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:self.detail];
        
    }
    return self;
}
@end
