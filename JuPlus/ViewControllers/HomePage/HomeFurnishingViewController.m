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
    backV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.width, self.view.height)];
    [self.view addSubview:backV];
    
    [backV addSubview:self.collectionV];
    
    [backV addSubview:self.centerV];
    
    [self.viewArray addObject:self.collectionV];
    [self.viewArray addObject:self.centerV];

    [backV addSubview:self.tabBarV];

    //原定筛选按钮
    [self.collectionV.rightBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarV.personBtn addTarget:self action:@selector(personBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.classifyV];
    [self.classifyV setHidden:YES];
    //检测是否第一次加载
    [self checkSections];

}
-(void)addRightBtn
{
    [self.leftBtn setHidden:YES];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(backV.width - 54.0f, 20, 44.0f, 44.0f);
    [btn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"兴趣" forState:UIControlStateNormal];
    [btn.titleLabel setFont:FontType(14.0f)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIView *black = [[UIView alloc]initWithFrame:CGRectMake((btn.width - 15.0f)/2, 42.0f, 15.0f, 2.0f)];
    [black setBackgroundColor:[UIColor blackColor]];
    [btn addSubview:black];
    [backV addSubview:btn];
}
-(void)show
{
    [self.classifyV showClassify];
}
-(void)checkSections
{
    if(IsStrEmpty([CommonUtil getUserDefaultsValueWithKey:isShowClassify]))
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show) name:ShowClassify object:nil];
    }
    else
    {
        
    }
}
//标签选择界面
-(ClassifyView *)classifyV
{
    if(!_classifyV)
    {
        _classifyV = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) andView:backV];
    }
    return _classifyV;
}
//搭配界面（默认）
-(CollectionView *)collectionV
{
    if(!_collectionV)
    {
        _collectionV = [[CollectionView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT)];
        
    }
    return _collectionV;
}
//个人中心
-(PersonCenterView *)centerV
{
    if(!_centerV)
    {
        _centerV = [[PersonCenterView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT)];
        
    }
    return _centerV;
}
-(JuPlusTabBarView *)tabBarV
{
    if(!_tabBarV)
    {
        _tabBarV = [[JuPlusTabBarView alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f)
                    ];
        _tabBarV.delegate = self;
        _tabBarV.backgroundColor = [UIColor whiteColor];
    }
    return _tabBarV;
}
#pragma mark --ClickMethod
//筛选按钮点击（跳转到九宫格）
-(void)selectClick:(UIButton *)sender
{
    [self.classifyV showClassify];
}
#pragma mark 视图切换
-(void)showCurrentView:(JuPlusUIView *)view
{
    //只有当点击页面不是屏幕显示内容时候才会重新分布位置，否则不做处理
    if(view.origin.x!=0)
    {
    [UIView animateWithDuration:ANIMATION animations:^{
        [backV bringSubviewToFront:view];
        [view startHomePageRequest];
        view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,view.height);
    } completion:^(BOOL finished) {
        for (JuPlusUIView *vi in self.viewArray) {
            if(vi!=view)
            {
                vi.frame = CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH, vi.height);
            }
        }
    }];
    }
    else
    {
    
    }
}
-(void)personBtnClick:(UIButton *)sender
{
    if([CommonUtil isLogin])
    {
        [self.tabBarV resetButtonArray];
        [self.tabBarV.personBtn setSelected:YES];
        [self showCurrentView:self.centerV];
    }
    else
    {
        LoginViewController *log = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }

}
#pragma mark --tabBarDelegate
-(void)changeTo:(NSInteger)tag
{
    if(tag==0)
    {
        [self showCurrentView:self.collectionV];
    }

}
#pragma mark --切换tabBar的显示效果
-(void)viewWillAppear:(BOOL)animated
{
    [self.collectionV.listTab reloadData];
    if(![CommonUtil isLogin])
    {
        self.tabBarV.personBtn.selected = NO;
        ((UIButton *)[self.tabBarV.buttonArr firstObject]).selected = YES;
    [self showCurrentView:self.collectionV];
    }
    [super viewWillAppear:animated];
    [UIView animateWithDuration:ANIMATION animations:^{
        self.tabBarV.frame = CGRectMake(0.0f, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [UIView animateWithDuration:ANIMATION animations:^{
        self.tabBarV.frame = CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
    }];
    [super viewWillDisappear:animated];
}

@end
