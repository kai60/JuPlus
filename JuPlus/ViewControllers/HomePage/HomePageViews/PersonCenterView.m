//
//  PersonCenterView.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PersonCenterView.h"
#import "PersonCenterReq.h"
#import "PersonCenterRespon.h"
#import "OrderListViewController.h"
#import "DesignerDetailViewController.h"
@implementation PersonCenterView
{
    PersonCenterReq *centerReq;
    PersonCenterRespon *centerRespon;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = RGBCOLOR(239, 239, 239);
        [self.navView setHidden:NO];
        self.listArr = [[NSMutableArray alloc]init];
        self.titleLabel.text = @"我的主页";
       // [self.rightBtn setTitle:@"设置" forState:UIControlStateNormal];
        [self uifig];
    }return self;
}
-(void)uifig
{
    [self addSubview:self.topView];
    [self.topView addSubview:self.portrait];
    [self.topView addSubview:self.nickLabel];
    CGFloat labelW = 40.0f;
    CGFloat space = 60.0f;
    CGFloat labelH = 30.0f;
    NSArray *array=[NSArray arrayWithObjects:@"作品",@"买入",@"收藏", nil];
    for (int i =0; i<3; i++) {
        JuPlusUILabel *label = [[JuPlusUILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - (labelW*3+space*2))/2+(space+labelW)*i, 100.0f, labelW, labelH)];
        [label setFont:FontType(16.0f)];
        [label setTextColor:Color_Basic];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        [self.topView addSubview:label];
        [self.listArr addObject:label];
        
        JuPlusUILabel *label1 = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(label.left, label.top+labelH, labelW, labelH)];
        [label1 setFont:FontType(16.0f)];
        [label1 setTextColor:Color_Gray];
        label1.tag = i;
        label1.textAlignment = NSTextAlignmentCenter;
        [label1 setText:[array objectAtIndex:i]];
        [self.topView addSubview:label1];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(label.left, label.top, labelW, labelH*2);
        [self.topView addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
   // [self startRequest];

}
-(void)startHomePageRequest
{
    centerReq = [[PersonCenterReq alloc]init];
    [centerReq setField:[CommonUtil getToken] forKey:TOKEN];
    centerRespon = [[PersonCenterRespon alloc]init];
    [HttpCommunication request:centerReq getResponse:centerRespon Success:^(JuPlusResponse *response) {
        [self configData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
}
-(void)configData
{
    NSArray *arr = [NSArray arrayWithObjects:centerRespon.worksCount,centerRespon.payCount,centerRespon.favourCount, nil];
    [self.portrait setimageUrl:centerRespon.portrait placeholderImage:nil];
    [self.nickLabel setText:centerRespon.nickname];
    for (int i=0; i<[self.listArr count]; i++) {
        [((JuPlusUILabel *)[self.listArr objectAtIndex:i]) setText:[arr objectAtIndex:i]];
    }
}
-(void)goDesign
{
  
}
#pragma mark --UIfig
-(JuPlusUIView *)topView
{
    if (!_topView) {
        _topView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, 180.0f)];
        _topView.backgroundColor = Color_White;
    }
    return _topView;
}
-(UIButton *)portrait
{
    if(!_portrait)
    {
        self.portrait = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.portrait.frame = CGRectMake(130,10, 60, 60);
        self.portrait.layer.masksToBounds=YES;
        self.portrait.layer.cornerRadius=30;
        [self.portrait addTarget:self action:@selector(goDesign) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portrait;
}
-(JuPlusUILabel *)nickLabel
{
    if(!_nickLabel)
    {
        _nickLabel =[[JuPlusUILabel alloc]initWithFrame:CGRectMake(110, self.portrait.bottom+16, 100, 20)];
        _nickLabel.font=FontType(16.0f);
        _nickLabel.textColor=Color_Black;
        _nickLabel.textAlignment=NSTextAlignmentCenter;

    }
    return _nickLabel;
}
-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
            OrderListViewController *order = [[OrderListViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:order animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}
@end
