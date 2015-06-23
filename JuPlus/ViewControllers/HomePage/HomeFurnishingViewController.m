//
//  HomeFurnishingViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomeFurnishingViewController.h"
@implementation HomeFurnishingViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self UIConfig];
}
-(void)UIConfig
{

    [self.view addSubview:self.listTab];
  //  UIWindow*  Hywindow = [[[UIApplication sharedApplication] delegate] window];
  //  [Hywindow addSubview:self.classifyV];
    //[self.view setVisualEffect];
}
-(ClassifyView *)classifyV
{
    if(!_classifyV)
    {
        _classifyV = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height) andView:self.view];
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
    return 300.0f;
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
    [cell setTipsWithArray:[NSArray array]];
    
    return cell;
}
@end
