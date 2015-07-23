//
//  JuPlusTabBarView.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusTabBarView.h"

@implementation JuPlusTabBarView
{
    CGFloat normalW;
    CGFloat selectedW;
}
@synthesize buttonArr;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        normalW = 44.0f;
        selectedW = 74.0f;
        buttonArr = [[NSMutableArray alloc]init];
        [self loadUI];
        [self addSubview:self.personBtn];
    }
    return self;
}
-(UIButton *)personBtn
{
    if(!_personBtn)
    {
        _personBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _personBtn.frame = CGRectMake(self.width - 50.0f, 0.0f, 44.0f, 44.0f);
        [_personBtn setImage:[UIImage imageNamed:@"personCenter_unsel"] forState:UIControlStateNormal];
        [_personBtn setImage:[UIImage imageNamed:@"personCenter"] forState:UIControlStateSelected];

    }
    return _personBtn;
}
-(void)loadUI
{
    NSArray *nameArr = [NSArray arrayWithObjects:@"    ", nil];
    NSArray *imgArrNormal = [NSArray arrayWithObjects:@"collect_unsel", nil];
    NSArray *imgArrSel = [NSArray arrayWithObjects:@"collect_sel", nil];
    for (int i=0; i<[nameArr count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50*i, 0.0f, normalW, normalW);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:Color_Black forState:UIControlStateNormal];
        [btn setTitleColor:Color_Basic forState:UIControlStateSelected];
        [btn setTitle:@"" forState:UIControlStateNormal];
        [btn.titleLabel setFont:FontType(14.0f)];
        [btn setTitle:[nameArr objectAtIndex:i] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:[imgArrNormal objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i]] forState:UIControlStateSelected];
        btn.tag = i;
        [buttonArr addObject:btn];
        [self addSubview:btn];
        
    }
    [self setFirstRespon];
}
-(void)setFirstRespon
{
    UIButton *btn = ((UIButton *)[buttonArr firstObject]);
    [btn setSelected:YES];
     btn.frame = CGRectMake(btn.left, btn.top, selectedW, btn.height);
}
-(void)buttonPressed:(UIButton *)sender
{
    if(!sender.selected)
    {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        [self.personBtn setSelected:NO];
        for(int i=0;i<[buttonArr count];i++)
        {
            UIButton *btn = [buttonArr objectAtIndex:i];
            if(sender.tag==btn.tag)
            {
                if(self.delegate&&[self.delegate respondsToSelector:@selector(changeTo:)])
                {
                    [self.delegate changeTo:sender.tag];
                }
                [UIView animateWithDuration:1.0f animations:^{
                    btn.frame = CGRectMake(sender.left, sender.top, selectedW, sender.height);
                }];
            }
            else
            {
                btn.selected = NO;
                if(i==0)
                {
                    btn.frame = CGRectMake(0.0f, 0.0f, normalW, normalW);
                }
                else
                {
                    CGFloat orignX = ((UIButton *)[buttonArr objectAtIndex:i-1]).right;
                    btn.frame = CGRectMake(orignX, btn.top, normalW, normalW);
                }
            }
        }
    }
    else
    {
        
    }
}
-(void)resetButtonArray
{
    for (UIButton *btn  in buttonArr) {
        btn.selected = NO;
        if(btn.tag==0)
        {
            btn.frame = CGRectMake(0.0f, 0.0f, normalW, normalW);
        }
        else
        {
            CGFloat orignX = ((UIButton *)[buttonArr objectAtIndex:btn.tag-1]).right;
            btn.frame = CGRectMake(orignX, btn.top, normalW, normalW);
        }

    }
}
@end
