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
#import <AFNetworking/AFNetworking.h>
#import "ClassifyLabelsRequest.h"
#import "ClassifyRespon.h"
#import "ClassifyTagsDTO.h"
#import "SCGIFImageView.h"
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
    CGFloat spaceY = 40.0f;
    CGFloat btnW = (self.width - spaceX *4)/3;
    CGFloat btnH = 30.0f;
    for(int i=0;i<[self.dataArray count];i++)
    {
        ClassifyTagsDTO *tagDTO = [self.dataArray objectAtIndex:i];
        HobbyItemBtn *btn = [[HobbyItemBtn alloc]initWithFrame:CGRectMake(spaceX+self.width*(i/9)+(spaceX+btnW)*(i%3),100.0f+spaceY+ (spaceY+btnH)*((i/3)%3), btnW, btnH)];
        [btn.iconBtn setTitle:tagDTO.name forState:UIControlStateNormal];
        btn.iconBtn.tag = [tagDTO.regNo integerValue];
        [btn.iconBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemsScroll addSubview:btn];
    }
    self.itemsScroll.contentSize = CGSizeMake(SCREEN_WIDTH*(([self.dataArray count] -1)/9+1), self.itemsScroll.width);

}
//后台下发标签列表，统计用户的兴趣内容
-(void)startRequest
{
    ClassifyLabelsRequest *req = [[ClassifyLabelsRequest alloc]init];
    ClassifyRespon *respon = [[ClassifyRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.dataArray addObjectsFromArray:respon.tagsArray];
        [self fileData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
}
//允许多重选择的点击以及加载事件
-(void)btnClick:(UIButton *)sender
{
    if(!sender.selected)
    {
        sender.selected = YES;
        UIView *sup =  sender.superview;
        if([sup isKindOfClass:[HobbyItemBtn class]])
        {
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark" ofType:@"gif"];
          SCGIFImageView * selectedImage = [[SCGIFImageView alloc]initWithGIFFile:filePath withSeconds:0.5];
            selectedImage.frame = CGRectMake(sup.width - 16.0f, (sup.height - 16.0f)/2, 16.0f, 16.0f);
            [sup addSubview:selectedImage];
        }
        [self.selectArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
    else
    {
        sender.selected =  NO;
        UIView *sup =  sender.superview;
        if([sup isKindOfClass:[HobbyItemBtn class]])
        {
            for(UIView *v in sup.subviews)
            {
                if([v isKindOfClass:[SCGIFImageView class]])
                {
                    [v removeFromSuperview];
                }
            }
        }
        [self.selectArr removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
}
//确认按钮
-(void)surePress:(UIButton *)sender
{
    NSLog(@"selArr = %@",self.selectArr);
    [self removeFromSuperview];
    [superView removeVisualEffect];
}
//只可单选的点击事件以及提交按钮
-(void)btnClick1:(UIButton *)sender
{
    if(!sender.selected)
    {
        sender.selected = YES;
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
        [_sureBtn setBackgroundColor:Color_Basic];
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

@end
