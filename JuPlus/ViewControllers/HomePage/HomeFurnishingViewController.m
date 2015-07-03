//
//  HomeFurnishingViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomeFurnishingViewController.h"
#import "RegisterViewController.h"
#import "HomePageInfoDTO.h"
#import "CollocationReq.h"
#import "CollectionRespon.h"
#import "LoginViewController.h"
@implementation HomeFurnishingViewController
{
    JuPlusUIView *backV;
    CollocationReq *collReq;
    CollectionRespon *collRespon;
    NSMutableArray *dataArray;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
   
    [self UIConfig];
}
-(void)rightPress
{
   if([CommonUtil isLogin])
   {
   
   }
    else
    {
        LoginViewController *log = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];

    }
}
-(void)UIConfig
{
    dataArray = [[NSMutableArray alloc]init];
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
    [self.leftBtn setHidden:YES];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(backV.width - 54.0f, 20, 44.0f, 44.0f);
    [btn addTarget:self action:@selector(rightPress) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"个人" forState:UIControlStateNormal];
    [btn.titleLabel setFont:FontType(14.0f)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIView *black = [[UIView alloc]initWithFrame:CGRectMake((btn.width - 15.0f)/2, 42.0f, 15.0f, 2.0f)];
    [black setBackgroundColor:[UIColor blackColor]];
    [btn addSubview:black];
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
    collReq = [[CollocationReq alloc]init];
    collRespon = [[CollectionRespon alloc]init];
    [HttpCommunication request:collReq getResponse:collRespon Success:^(JuPlusResponse *response) {
        [dataArray addObjectsFromArray:collRespon.listArray];
        [self.listTab reloadData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT+90.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
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
    HomePageInfoDTO *homePage = [dataArray objectAtIndex:indexPath.row];
    [cell loadCellInfo:homePage];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
