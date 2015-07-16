//
//  CollectionView.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CollectionView.h"
#import "HomePageInfoDTO.h"
#import "CollocationReq.h"
#import "CollectionRespon.h"
#import "PackageCell.h"
#import "PackageViewController.h"
@implementation CollectionView
{
    NSMutableArray *dataArray;
    CollocationReq *collReq;
    CollectionRespon *collRespon;
    ScrollRefreshViewHead *header;
    ScrollRefreshViewFooter * footer;
    ScrollRefreshView *selectView;
    int pageNum;
    //数据总数
    int totalCount;

}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        dataArray = [[NSMutableArray alloc]init];
        [self addSubview:self.listTab];
        pageNum = 1;
        header = [ScrollRefreshViewHead header];
        header.delegate = self;
        header.scrollView =  self.listTab;
        
        footer = [ScrollRefreshViewFooter footer];
        footer.delegate = self;
        footer.scrollView = self.listTab;
        
        self.titleLabel.text = @"搭配";
        [self.rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [self.navView setHidden:NO];
        [self startHomePageRequest];
    }
    return self;
}
-(UITableView *)listTab
{
    if(!_listTab)
    {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height - TABBAR_HEIGHT) style:UITableViewStylePlain];
        _listTab.dataSource = self;
        _listTab.delegate = self;
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTab;
}
#pragma mark --refresh
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    selectView = refreshView;
    //下拉刷新
    if(refreshView.viewType == RefreshViewTypeHeader)
    {
        pageNum = 1;
        //下拉刷新则重载上拉加载更多选项
        [footer setState:RefreshStateNormal withAnimate:NO];
    }
    //上拉加载更多
    else
    {
       if([dataArray count]>=totalCount)
       {
           //显示无更多内容
           [refreshView setState:RefreshStateALL withAnimate:YES];
           return;
       }
        pageNum++;
    }
    [self startHomePageRequest];
}
#pragma mark --request
-(void)startHomePageRequest
{
    collReq = [[CollocationReq alloc]init];
    collRespon = [[CollectionRespon alloc]init];
    [collReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:@"pageNum"];
    [collReq setField:PAGESIZE forKey:@"pageSize"];

    [HttpCommunication request:collReq getResponse:collRespon Success:^(JuPlusResponse *response) {
        totalCount = [collRespon.count intValue];
        if (pageNum==1) {
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:collRespon.listArray];
        [self.listTab reloadData];
        [self stopReresh];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self];
}
-(void)stopReresh
{
    [selectView endRefreshing];
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
    PackageViewController *pack = [[PackageViewController alloc]init];
    HomePageInfoDTO *homePage = [dataArray objectAtIndex:indexPath.row];
    pack.regNo = homePage.regNo;
    [[self getSuperViewController].navigationController pushViewController:pack animated:YES];
}

@end
