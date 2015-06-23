//
//  ClassifyView.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ClassifyView.h"
#import "JuPlusEnvironmentConfig.h"
#import "HobbyItemBtn.h"
@implementation ClassifyView
{
    UIView *superView;
}
-(id)initWithFrame:(CGRect)frame andView:(UIView *)superV
{
    superView = superV;
    self = [super initWithFrame:frame];
    if(self)
    {
        [self uifig];
    }
    return self;
}
-(void)fileData
{
    CGFloat spaceX = 10.0f;
    CGFloat spaceY = 20.0f;
    CGFloat btnW = (self.width - spaceX *4)/3;
    CGFloat btnH = 30.0f;
    for(int i=0;i<10;i++)
    {
        HobbyItemBtn *btn = [[HobbyItemBtn alloc]initWithFrame:CGRectMake(spaceX+self.width*(i/9)+(spaceX+btnW)*(i%3),spaceY+ (spaceY+btnH)*((i/3)%3), btnW, btnH)];
        [btn.iconBtn setTitle:[NSString stringWithFormat:@"标签%d",i] forState:UIControlStateNormal];
        btn.iconBtn.tag = i;
        [btn.iconBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemsScroll addSubview:btn];
    }
    self.itemsScroll.contentSize = CGSizeMake(SCREEN_WIDTH*(9/9+1), self.itemsScroll.width);

}
//后台下发标签列表，统计用户的兴趣内容
-(void)startRequest
{
    [self fileData];
}
-(void)btnClick:(UIButton *)sender
{
    if(!sender.selected)
    {
        sender.selected = YES;
        UIView *sup =  sender.superview;
        if([sup isKindOfClass:[HobbyItemBtn class]])
        {
            [((HobbyItemBtn *)sup).selectedImage setHidden:NO];
        }
        [self.selectArr addObject:[NSString stringWithFormat:@"%d",sender.tag]];
    }
    else
    {
        sender.selected =  NO;
        UIView *sup =  sender.superview;
        if([sup isKindOfClass:[HobbyItemBtn class]])
        {
            [((HobbyItemBtn *)sup).selectedImage setHidden:YES];
        }
        [self.selectArr removeObject:[NSString stringWithFormat:@"%d",sender.tag]];
    }
}
#pragma uifig
-(UIScrollView *)itemsScroll
{
    if(!_itemsScroll)
    {
        _itemsScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        _itemsScroll.pagingEnabled = YES;
    }
    return _itemsScroll;
}
-(UIButton *)sureBtn
{
    if(!_sureBtn)
    {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, self.height-44, SCREEN_WIDTH, 44);
        _sureBtn.titleLabel.font=[UIFont fontWithName:FONTSTYLE size:20.0];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
-(NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}
-(NSMutableArray *)selectArr
{
    if(!_selectArr)
    {
        _selectArr = [[NSMutableArray alloc]init];
    }
    return _selectArr;
}
-(void)uifig
{
    [self addSubview:self.itemsScroll];
    [self addSubview:self.sureBtn];
    [self startRequest];
}
-(void)surePress:(UIButton *)sender
{
    NSLog(@"selArr = %@",self.selectArr);
    [UIView animateWithDuration:0.3 animations:^{
        [superView removeVisualEffect];
    } completion:^(BOOL finished) {
    [self removeFromSuperview];
    }];
}
@end
