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
#import "MyFavourViewController.h"
#import "JuPlusUserInfoCenter.h"
#import "MyInfoViewController.h"
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
        [self.rightBtn setHidden:YES];
        [self uifig];
    }return self;
}
-(void)uifig
{
    [self addSubview:self.topView];
    [self.topView addSubview:self.portrait];
    [self.topView addSubview:self.nickLabel];
    [self addSubview:self.uploadBtn];
    CGFloat labelW = 40.0f;
    CGFloat space = 60.0f;
    CGFloat labelH = 30.0f;
    NSArray *array=[NSArray arrayWithObjects:@"作品",@"买入",@"收藏", nil];
    for (int i =0; i<3; i++) {
        JuPlusUILabel *label = [[JuPlusUILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - (labelW*3+space*2))/2+(space+labelW)*i, 120.0f, labelW, labelH)];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetNickname) name:ResetNickName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPortrait) name:ResetPortrait object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startHomePageRequest) name:ReloadPerson object:nil];

}
-(void)resetNickname
{
    [self.nickLabel setText:[JuPlusUserInfoCenter sharedInstance].userInfo.nickname];

}
-(void)resetPortrait
{
    [self.portrait setimageUrl:[JuPlusUserInfoCenter sharedInstance].userInfo.portraitUrl placeholderImage:nil];
}
-(void)startHomePageRequest
{
    centerReq = [[PersonCenterReq alloc]init];
    [centerReq setField:[CommonUtil getToken] forKey:TOKEN];
    centerRespon = [[PersonCenterRespon alloc]init];
    [HttpCommunication request:centerReq getResponse:centerRespon Success:^(JuPlusResponse *response) {
        [self configData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
}
-(void)configData
{
    [JuPlusUserInfoCenter sharedInstance].userInfo.nickname = centerRespon.nickname;
    [JuPlusUserInfoCenter sharedInstance].userInfo.portraitUrl = centerRespon.portrait;
    NSArray *arr = [NSArray arrayWithObjects:centerRespon.worksCount,centerRespon.payCount,centerRespon.favourCount, nil];
    [self.portrait setimageUrl:centerRespon.portrait placeholderImage:nil];
    [self.nickLabel setText:centerRespon.nickname];
    for (int i=0; i<[self.listArr count]; i++) {
        [((JuPlusUILabel *)[self.listArr objectAtIndex:i]) setText:[arr objectAtIndex:i]];
    }
}
-(void)goMyInfo
{
    MyInfoViewController *info = [[MyInfoViewController alloc]init];
    [[self getSuperViewController].navigationController pushViewController:info animated:YES];
}
#pragma mark --UIfig
-(JuPlusUIView *)topView
{
    if (!_topView) {
        _topView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, 200.0f)];
        _topView.backgroundColor = Color_White;
    }
    return _topView;
}
-(UIButton *)portrait
{
    if(!_portrait)
    {
        self.portrait = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.portrait.frame = CGRectMake((self.width - 60.0f)/2,10, 60, 60);
        self.portrait.layer.masksToBounds=YES;
        self.portrait.layer.cornerRadius=30;
        [self.portrait addTarget:self action:@selector(goMyInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portrait;
}
-(JuPlusUILabel *)nickLabel
{
    if(!_nickLabel)
    {
        _nickLabel =[[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, self.portrait.bottom+16, self.topView.width, 20)];
        _nickLabel.font=FontType(16.0f);
        _nickLabel.textColor=Color_Black;
        _nickLabel.textAlignment=NSTextAlignmentCenter;

    }
    return _nickLabel;
}
-(UIButton *)uploadBtn
{
    if(!_uploadBtn)
    {
        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _uploadBtn.frame = CGRectMake((SCREEN_WIDTH - 100.0f)/2, self.topView.bottom+50.0f, 100.0f, 100.0f) ;
        [_uploadBtn setBackgroundImage:[UIImage imageNamed:@"becomeDesigner"] forState:UIControlStateNormal];
        [_uploadBtn setBackgroundImage:[UIImage imageNamed:@"becomeDesigner"] forState:UIControlStateHighlighted];
        [_uploadBtn addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uploadBtn;
}
-(void)uploadClick
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"完成基础操作后成为居+搭配设计师" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alt.tag = 101;
    [alt show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //必须先走父类中的代理方法，以防止子类代理覆盖父类中的内容
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        if (buttonIndex==0) {
          
        }
        else
        {
            //联系客服
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",HELPTELEPHONE]];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            [self addSubview:callWebview];
        }
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
#pragma mark --btnClick
-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            [self uploadClick];
        }
            break;
        case 1:
        {
            //购买过的（订单列表）
            OrderListViewController *order = [[OrderListViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:order animated:YES];
        }
            break;
        case 2:
        {
            //我的收藏
            MyFavourViewController *fav = [[MyFavourViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:fav animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
@end
