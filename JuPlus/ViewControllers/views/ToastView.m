//
//  ToastView.m
//  JuPlus
//
//  Created by admin on 15/8/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ToastView.h"
@implementation ToastView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.buttonArr = [[NSMutableArray alloc]init];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        [self addSubview:self.backImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textLabel];
        NSArray *nameArr = [NSArray arrayWithObjects:@"weichat_TimeLine",@"weichat_session", nil];
        CGFloat orignY = self.textLabel.bottom+20.0f;
        CGFloat space = (self.width - 48.0f*2)/3;
        for (int i =0; i<2; i++) {
          UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(space+i*(space + 48.0f), orignY, 48.0f, 65.0f);
            [btn setImage:[UIImage imageNamed:[nameArr objectAtIndex:i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[nameArr objectAtIndex:i]] forState:UIControlStateHighlighted];

            btn.tag = i+1;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArr addObject:btn];
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.height - 40.0f, self.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [self addSubview:line];
        [self addSubview:self.sureBtn];
    }
    return self;
}
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(2.0f, 2.0f, self.width - 4.0f, 85.0f)];
        [_backImage setImage:[UIImage imageNamed:@"share_bg"]];
    }
    return _backImage;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.backImage.bottom+10.0f, self.width, 30.0f)];
        [_titleLabel setFont:FontType(20.0f)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setTextColor:Color_Basic];
        [_titleLabel setText:@"发布成功"];
    }
    return _titleLabel;
}

-(UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.titleLabel.bottom, self.width, 25.0f)];
        [_textLabel setFont:FontType(FontMaxSize)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [_textLabel setTextColor:Color_Gray];
        [_textLabel setText:@"你可以分享内容给你的朋友"];
    }
    return _textLabel;
}
-(UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(0.0f, self.height - 40.0f, self.width, 40.0f);
        [_sureBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:FontMaxSize]];
        [_sureBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
-(void)btnPress:(UIButton *)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(Method:)]) {
        [self.delegate Method:sender.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
