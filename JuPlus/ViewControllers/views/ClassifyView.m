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
#import "UIButton+WebCache.h"

@implementation ClassifyView
{
    UIView *superView;
    
    NSMutableArray *buttonArray;
    
    //当只有一个选项可选中时
    UIButton *selectedBtn;
}
-(id)initWithFrame:(CGRect)frame andView:(UIView *)superV
{
    superView = superV;
    self = [super initWithFrame:frame];
    if(self)
    {
        buttonArray = [[NSMutableArray alloc]init];
        [self uifig];
    }
    return self;
}
-(void)fileData
{
       CGFloat spaceX = 20.0f;
    CGFloat spaceY = 50.0f;
    CGFloat btnW = (self.width - spaceX*6)/3;
    CGFloat btnH = btnW;

    //for(int i=0;i<[self.dataArray count];i++)
    for(int i=0;i<9;i++)
    {
       // ClassifyTagsDTO *tagDTO = [self.dataArray objectAtIndex:i];
        HobbyItemBtn *btn = [[HobbyItemBtn alloc]initWithFrame:CGRectMake(spaceX*2+self.width*(i/9)+(spaceX+btnW)*(i%3),90.0f+spaceY+ (spaceY+btnH)*((i/3)%3), btnW, btnH)];
      //  [btn.iconBtn setTitle:tagDTO.name forState:UIControlStateNormal];
//        [btn.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,tagDTO.imgUrl]] forState:UIControlStateNormal];
//        [btn.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,tagDTO.selImgUrl]] forState:UIControlStateSelected];

      //  btn.iconBtn.tag = [tagDTO.regNo integerValue];
        btn.iconBtn.tag = i;
        [btn.iconBtn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn.iconBtn];
        [self.itemsScroll addSubview:btn];
    }
  //  self.itemsScroll.contentSize = CGSizeMake(SCREEN_WIDTH*(([self.dataArray count] -1)/9+1), self.itemsScroll.width);

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
////允许多重选择的点击以及加载事件
//-(void)btnClick:(UIButton *)sender
//{
//    if(!sender.selected)
//    {
//        sender.selected = YES;
//        UIView *sup =  sender.superview;
//        if([sup isKindOfClass:[HobbyItemBtn class]])
//        {
//            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark" ofType:@"gif"];
//          SCGIFImageView * selectedImage = [[SCGIFImageView alloc]initWithGIFFile:filePath withSeconds:0.5];
//            selectedImage.frame = CGRectMake(sup.width - 16.0f, (sup.height - 16.0f)/2, 16.0f, 16.0f);
//            [sup addSubview:selectedImage];
//        }
//        [self.selectArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
//    }
//    else
//    {
//        sender.selected =  NO;
//        UIView *sup =  sender.superview;
//        if([sup isKindOfClass:[HobbyItemBtn class]])
//        {
//            for(UIView *v in sup.subviews)
//            {
//                if([v isKindOfClass:[SCGIFImageView class]])
//                {
//                    [v removeFromSuperview];
//                }
//            }
//        }
//        [self.selectArr removeObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
//    }
//}
////确认按钮
//-(void)surePress:(UIButton *)sender
//{
//    NSLog(@"selArr = %@",self.selectArr);
//    [self setHidden:YES];
//    //[superView removeVisualEffect];
//}
//只可单选的点击事件以及提交按钮
-(void)btnClick1:(UIButton *)sender
{
    if(!sender.selected)
    {
        for (UIButton *btn in buttonArray) {
            if(btn.tag==sender.tag)
            {
                [btn setSelected:YES];
                selectedBtn = btn;
                UIView *sup =  sender.superview;
                if([sup isKindOfClass:[HobbyItemBtn class]])
                {
                    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"checkmark" ofType:@"gif"];
                    SCGIFImageView * selectedImage = [[SCGIFImageView alloc]initWithGIFFile:filePath withSeconds:0.5];
                    selectedImage.frame = CGRectMake(sup.width - 16.0f, (sup.height - 16.0f)/2, 16.0f, 16.0f);
                    [sup addSubview:selectedImage];
                }

            }
            else
            {
                UIView *sup =  btn.superview;
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

                [btn setSelected:NO];
            }
        }
    }
    else
    {
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
        sender.selected = NO;
        selectedBtn =  nil;
    }
}
//确认按钮
-(void)surePress1:(UIButton *)sender
{
    if(IsNilOrNull(selectedBtn))
    {
    
    }
    else
    {
    
    }
    [self setHidden:YES];
    //[superView removeVisualEffect];
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
        _sureBtn.frame=CGRectMake(0, self.height-64, SCREEN_WIDTH, 64);
//        _sureBtn.titleLabel.font=[UIFont fontWithName:FONTSTYLE size:20.0];
//        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//        [_sureBtn setBackgroundColor:Color_Basic];
//        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(surePress1:) forControlEvents:UIControlEventTouchUpInside];
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
    UIImageView *bc = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
    [bc setImage:[UIImage imageNamed:@"test1"]];
    [self addSubview:bc];
    [self addSubview:self.itemsScroll];
    [self addSubview:self.sureBtn];
  //  [self startRequest];
    [self fileData];
}

@end
