//
//  HomeFurnishingViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomeFurnishingViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"
#import "UMSocialScreenShoter.h"
#import "BasicUIViewController.h"
#import "CameraViewController.h"
#import <CoreText/CoreText.h>
#import "DesignerMapView.h"
@interface HomeFurnishingViewController()<UMSocialUIDelegate>
{
    DesignerMapView *design;
    
    BOOL isShowMap;
}
@end

@implementation HomeFurnishingViewController
{
    JuPlusUIView *backV;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
   
    self.viewArray = [[NSMutableArray alloc]init];
    [self UIConfig];
}
-(void)rightPress
{

}
-(void)UIConfig
{
    [self.navView setHidden:YES];
    //如果此处直接用self.view则上层的标签选择页面也会随之变化，因此在self.view上加层透明view放置原来置于self.view层的内容，以方便处理高斯模糊效果
    backV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f,0.0f, SCREEN_WIDTH, self.view.height)];
    [self.view addSubview:backV];
    
    [backV addSubview:self.personCenterV];
    
    [backV addSubview:self.collectionV];

    
    [self.viewArray addObject:self.collectionV];
    [self.viewArray addObject:self.personCenterV];

    [backV addSubview:self.tabBarV];
    
    //原定标签选择按钮
    [self.collectionV.rightBtn addTarget:self action:@selector(classifyBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    //个人中心
    [self.view addSubview:self.classifyV];
    [self.classifyV setHidden:YES];
    
     if (IsStrEmpty([CommonUtil getUserDefaultsValueWithKey:isShowClassify])) {
         [backV addSubview:self.remindView];
     }
}
-(void)hiddenRemind
{
    [self.remindView removeFromSuperview];
}
-(UIImageView *)remindView
{
    if (!_remindView) {
        _remindView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _remindView.backgroundColor = RGBACOLOR(0, 0, 0, 0.6);
        [_remindView setImage:[UIImage imageNamed:@"remind_collocation"]];
        _remindView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenRemind)];
        [_remindView addGestureRecognizer:tap];
        [CommonUtil setUserDefaultsValue:@"1" forKey:isShowClassify];
    }
    return _remindView;
}

//九宫格相关
-(void)show
{
   [self.classifyV showClassify];
}

//标签选择界面
-(ClassifyView *)classifyV
{
    if(!_classifyV)
    {
        _classifyV = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) andView:backV];
        _classifyV.backgroundColor = [UIColor clearColor];

    }
    return _classifyV;
}
//搭配界面（默认）
-(CollectionView *)collectionV
{
    if(!_collectionV)
    {
        _collectionV = [[CollectionView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _collectionV;
}
//个人中心
-(PersonCenterView *)personCenterV
{
    if(!_personCenterV)
    {
        _personCenterV = [[PersonCenterView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _personCenterV;
}
-(JuPlusTabBarView *)tabBarV
{
    if(!_tabBarV)
    {
        _tabBarV = [[JuPlusTabBarView alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - 49.0f, SCREEN_WIDTH, 49.0f)
                    ];
        _tabBarV.delegate = self;
        _tabBarV.backgroundColor = [UIColor clearColor];
    }
    return _tabBarV;
}
#pragma mark --ClickMethod
-(void)reloadCollectionTab
{
    //点击切换按钮，查看是否显示当前页面，如果不是当前页面，则切回到collectionView
    if (!self.collectionV.listTab.hidden) {
        if(self.collectionV.isShared)
        {
            self.collectionV.isShared = NO;
            self.tabBarV.collocationBtn.selected = NO;
        }
        else
        {
            self.collectionV.isShared = YES;
            self.tabBarV.collocationBtn.selected = YES;
            
        }
        [self.collectionV.listTab reloadData];
    }else{
    }
}

//筛选按钮点击（跳转到九宫格）
-(void)gotoCarma
{
    if ([CommonUtil isLogin]) {
        
        CameraViewController *ca = [[CameraViewController alloc]init];
        [self.navigationController pushViewController:ca animated:YES];
    }else{
        
        LoginViewController *log = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }
}
-(void)classifyBtnPress:(UIButton *)sender
{
    [self.classifyV showClassify];
}
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    //微信分享纯图片，不需要文字信息
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
}

#pragma mark 视图切换
-(void)showCurrentView:(JuPlusUIView *)view
{
    //只有当点击页面不是屏幕显示内容时候才会重新分布位置，否则不做处理
    if(view.origin.x!=0)
    {
    [UIView animateWithDuration:ANIMATION animations:^{
        [backV bringSubviewToFront:view];
        [backV bringSubviewToFront:self.tabBarV];
        [view startHomePageRequest];
        view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,view.height);
        if(view==self.collectionV)
            self.personCenterV.frame = CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH,view.height);
        else
            self.collectionV.frame = CGRectMake(-SCREEN_WIDTH, 0.0f, SCREEN_WIDTH,view.height);

    } completion:^(BOOL finished) {
    
    }];
    }
    else
    {
    
    }
}
#pragma mark --tabBarDelegate
//点击事件的代理
-(void)changeTo:(NSInteger)tag
{
    //点击首页
    /*
    */
    if(tag==ShowCollocation)
    {
        if (self.collectionV.origin.x!=0) {
            [self showCurrentView:self.collectionV];
        }else
            [self reloadCollectionTab];
    }
    //点击个人中心
    else if(tag==ShowPerson)
    {
        if([CommonUtil isLogin])
        {
            [self showCurrentView:self.personCenterV];
        }
        else
        {
            LoginViewController *log = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:log animated:YES];
        }

    }
    else
    {
        [self gotoCarma];
    }

}
#pragma mark --切换tabBar的显示效果
-(void)viewWillAppear:(BOOL)animated
{
    if (self.collectionV.isPackage) {
        self.collectionV.isPackage = NO;
    }
    else
    {
        [self.collectionV.listTab reloadData];
    }
    [super viewWillAppear:animated];
    if(![CommonUtil isLogin])
    {
        self.tabBarV.personBtn.selected = NO;
        ((UIButton *)[self.tabBarV.buttonArr firstObject]).selected = YES;
    [self showCurrentView:self.collectionV];
    }
    else
    {
        if (self.personCenterV) {
            [self.personCenterV startHomePageRequest];
        }
    }
    [UIView animateWithDuration:ANIMATION animations:^{
        self.tabBarV.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 49.0f, SCREEN_WIDTH, 49.0f);
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [UIView animateWithDuration:ANIMATION animations:^{
        self.tabBarV.frame = CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, 49.0f);
    }];
    [super viewWillDisappear:animated];
}

@end
