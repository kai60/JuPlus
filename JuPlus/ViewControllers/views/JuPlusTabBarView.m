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
        normalW = 24.0f;
        selectedW = 24.0f;

      //  selectedW = 74.0f;
        buttonArr = [[NSMutableArray alloc]init];
        [self loadUI];
        //[self addSubview:self.personBtn];
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
      
    //NSArray *nameArr = [NSArray arrayWithObjects:@"    ", nil];
    NSArray *bgImageArr = [NSArray arrayWithObjects:@"bar_bg_left",@"bar_bg_right", nil];
    NSArray *imgArrNormal = [NSArray arrayWithObjects:@"icons_01_unsel",@"icons_02_unsel", nil];

    NSArray *imgArrSel = [NSArray arrayWithObjects:@"icons_01_sel",@"icons_02_sel", nil];
    for (int i=0; i<[imgArrNormal count]; i++) {
        
        UIImageView *bottom = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - 85.0f)*i, 0.0f, 85.0f, 49.0f)];
        bottom.userInteractionEnabled = YES;
        [bottom setImage:[UIImage imageNamed:[bgImageArr objectAtIndex:i]]];
        [self addSubview:bottom];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((bottom.width - normalW)/2 - 5.0f +10.0f*i, (bottom.height - normalW)/2+5.0f, normalW, normalW);
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        [btn setTitleColor:Color_Black forState:UIControlStateNormal];
//        [btn setTitleColor:Color_Basic forState:UIControlStateSelected];
//        [btn setTitle:@"" forState:UIControlStateNormal];
//        [btn.titleLabel setFont:FontType(14.0f)];
//          [btn setTitle:[nameArr objectAtIndex:i] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:[imgArrNormal objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[imgArrSel objectAtIndex:i]] forState:UIControlStateSelected];
        btn.tag = i;
        [buttonArr addObject:btn];
        [bottom addSubview:btn];
        if(i==1)
            self.personBtn = btn;
        else
            self.classifyBtn = btn;
        
    }
    
    self.logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoBtn.frame = CGRectMake((self.width - 36.0f)/2, (self.height - 36.0f)/2, 36.0f, 36.0f);
    [self.logoBtn setImage:[UIImage imageNamed:@"carma_shot"] forState:UIControlStateNormal];
   // [logoBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.logoBtn];
    [self setFirstRespon];
}
-(void)setFirstRespon
{
    UIButton *btn = ((UIButton *)[buttonArr firstObject]);
    [btn setSelected:YES];
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
//                [UIView animateWithDuration:1.0f animations:^{
//                    btn.frame = CGRectMake(sender.left, sender.top, selectedW, sender.height);
//                }];
            }
            else
            {
                btn.selected = NO;
//                if(i==0)
//                {
//                    btn.frame = CGRectMake(0.0f, 0.0f, normalW, normalW);
//                }
//                else
//                {
//                    CGFloat orignX = ((UIButton *)[buttonArr objectAtIndex:i-1]).right;
//                    btn.frame = CGRectMake(orignX, btn.top, normalW, normalW);
//                }
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
//        if(btn.tag==0)
//        {
//            btn.frame = CGRectMake(0.0f, 0.0f, normalW, normalW);
//        }
//        else
//        {
//            CGFloat orignX = ((UIButton *)[buttonArr objectAtIndex:btn.tag-1]).right;
//            btn.frame = CGRectMake(orignX, btn.top, normalW, normalW);
//        }

    }
}
@end
