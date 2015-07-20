//
//  MyInfoViewController.m
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
// 个人信息修改

#import "MyInfoViewController.h"
#import "JuPlusUserInfoCenter.h"
#import "ResetPwdViewController.h"
#import "HomeFurnishingViewController.h"
#import "ChangeNicknameReq.h"
@interface InfoChangeV : JuPlusUIView

@property (nonatomic,strong)UILabel *titleL;

@property (nonatomic,strong)UILabel *textL;

@property (nonatomic,strong)UIImageView *rightArrow;

@property (nonatomic,strong)UIButton *clickBtn;

@property (nonatomic,strong)JuPlusUIView *botomV;
@end

@implementation InfoChangeV

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 120.0f, self.height)];
    [_titleL setFont:FontType(16.0f)];
    [self addSubview:_titleL];
    
    _textL = [[UILabel alloc]initWithFrame:CGRectMake(150.0f, 0.0f, 140.0f, self.height)];
    [_textL setFont:FontType(16.0f)];
    [_textL setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_textL];

    _rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 30.0f, (self.height - 20.0f)/2, 20.0f, 20.0f)];
    [_rightArrow setImage: [UIImage imageNamed:@"arrow_right"]];
    [self addSubview:_rightArrow];
    
    _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBtn.frame = CGRectMake(0.0f, 0.0f, self.width , self.height);
    [self addSubview:_clickBtn];
    
    _botomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(_titleL.left, self.height - 1.0f, self.width - 10.0f, 1.0f)];
    [_botomV setBackgroundColor:Color_Gray_lines];
    [self addSubview:self.botomV];

}
@end
@interface MyInfoViewController ()
@property (nonatomic,strong)UIScrollView *backScroll;
//头像
@property (nonatomic,strong)UIButton *iconImage;

@property (nonatomic,strong)NSMutableArray *labelArray;
//退出
@property (nonatomic,strong)UIButton *logoutBtn;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

-(void)loadBaseUI
{
    [self.titleLabel setText:@"个人信息"];
    [self.view addSubview:self.backScroll];
    [self.backScroll addSubview:self.iconImage];
    NSArray *arr = [NSArray arrayWithObjects:@"我的头像",@"昵称修改",@"密码修改", nil];
    CGFloat labelH = 50.0f;
    for (int i=0; i<3; i++) {
        InfoChangeV *info = [[InfoChangeV alloc]initWithFrame:CGRectMake(0.0f, i*labelH, self.backScroll.width, labelH)];
        [info.titleL setText:[arr objectAtIndex:i]];
        info.tag = i;
        if(i==1)
           [info.textL setText:[JuPlusUserInfoCenter sharedInstance].userInfo.nickname];
        [info.clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.labelArray addObject:info];
        [self.backScroll addSubview:info];
    }
    
    CGFloat contentH = view_height;
    if(view_height<labelH*([arr count]+4))
    contentH = labelH*([arr count]+4);
    self.backScroll.contentSize = CGSizeMake(SCREEN_WIDTH, contentH);
    [self.backScroll addSubview:self.logoutBtn];
}

-(void)btnClick:(UIButton *)sender
{
    switch (sender.superview.tag) {
        case 0:
        {
            //修改头像
        }
            break;
        case 1:
        {
            //修改昵称
        }
            break;
        case 2:
        {
            //修改密码
            ResetPwdViewController *reset =[[ResetPwdViewController alloc]init];
            [self.navigationController pushViewController:reset animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)changeNickname
{
    ChangeNicknameReq *req = [[ChangeNicknameReq alloc]init];
 }
-(void)logoutBtnClick:(UIButton *)sender
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"确认要退出么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alt.tag = 102;
    [alt show];
}
-(UIScrollView *)backScroll
{
    if(!_backScroll)
    {
        _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        _backScroll.showsVerticalScrollIndicator = NO;
    }
    return _backScroll;
}
-(UIButton *)iconImage
{
    if(!_iconImage)
    {
    _iconImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _iconImage.frame = CGRectMake(250.0f, 5.0f, 40.0f, 40.0f);
    _iconImage.layer.cornerRadius = _iconImage.width/2;
    _iconImage.layer.masksToBounds = YES;
    [_iconImage setimageUrl:[JuPlusUserInfoCenter sharedInstance].userInfo.portraitUrl placeholderImage:nil];
    }
    return _iconImage;
}
-(UIButton *)logoutBtn
{
    if(!_logoutBtn)
    {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.frame = CGRectMake(30.0f, self.backScroll.contentSize.height - 100.0f, SCREEN_WIDTH - 60.0f, 40.0f);
        [_logoutBtn setBackgroundColor:Color_Red];
        [_logoutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        [_logoutBtn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}
#pragma mark --alertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==102)
    {
        if(buttonIndex==0)
        {
            
        }
        else
        {
            [[JuPlusUserInfoCenter sharedInstance] resetUserInfo];
            NSArray *vcArr = [self.navigationController viewControllers];
            for (UIViewController *vc in vcArr) {
                if([vc isKindOfClass:[HomeFurnishingViewController class]])
                {
                    [self.navigationController popToViewController:vc animated:YES];
                    return;
                }
            }    


        }
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
