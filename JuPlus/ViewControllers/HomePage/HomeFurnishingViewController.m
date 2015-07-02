//
//  HomeFurnishingViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomeFurnishingViewController.h"
#import "RegisterViewController.h"
@implementation HomeFurnishingViewController
{
    JuPlusUIView *backV;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
   
    [self UIConfig];
}
-(void)rightPress
{
    RegisterViewController *log = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:log animated:YES];
}
-(void)UIConfig
{
    self.titleLabel.text = @"搭配";
        //如果此处直接用self.view则上层的标签选择页面也会随之变化，因此在self.view上加层透明view放置原来置于self.view层的内容，以方便处理高斯模糊效果
    backV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.width, self.view.height)];
    [self.view addSubview:backV];
    [self addRightBtn];
    [backV addSubview:self.listTab];
    //判断是否需要添加标签页
    [self checkSections];
}
-(void)addRightBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(backV.width - 50.0f, 27.0f, 40.0f, 30.0f);
    [btn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"个人" forState:UIControlStateNormal];
    [btn.titleLabel setFont:FontType(12.0f)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backV addSubview:btn];
}
-(void)checkSections
{
    if(1)
    {
        [self.view addSubview:self.classifyV];
        [backV setVisualEffect];
    }
}
-(ClassifyView *)classifyV
{
    if(!_classifyV)
    {
        _classifyV = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) andView:backV];
    }
    return _classifyV;
}
-(UITableView *)listTab
{
    if(!_listTab)
    {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        _listTab.dataSource = self;
        _listTab.delegate = self;
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTab;
}
#pragma mark --request
-(void)startRequest
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT+90.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"indexPath";
    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[PackageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTipsWithArray:[NSArray array]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
