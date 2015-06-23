//
//  HomeFurnishingViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomeFurnishingViewController.h"
@implementation HomeFurnishingViewController
{
    JuPlusUIView *backV;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
   
    [self UIConfig];
}
-(void)UIConfig
{
    
    backV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
    [self.view addSubview:backV];
    [backV addSubview:self.listTab];
    //判断是否需要添加标签页
    [self checkSections];
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
        _classifyV = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height) andView:backV];
    }
    return _classifyV;
}
-(UITableView *)listTab
{
    if(!_listTab)
    {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height+20.0f, SCREEN_WIDTH, view_height - 20.0f) style:UITableViewStylePlain];
        _listTab.dataSource = self;
        _listTab.delegate = self;
    }
    return _listTab;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 360.0f;
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
