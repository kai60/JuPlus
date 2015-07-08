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
@implementation CollectionView
{
    NSMutableArray *dataArray;
    CollocationReq *collReq;
    CollectionRespon *collRespon;
    NSInteger pageNum;

}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        dataArray = [[NSMutableArray alloc]init];
        [self addSubview:self.listTab];
        self.titleLabel.text = @"搭配";
        [self.rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [self.navView setHidden:NO];
        [self startRequest];
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
#pragma mark --request
-(void)startRequest
{
    collReq = [[CollocationReq alloc]init];
    collRespon = [[CollectionRespon alloc]init];
    [collReq setField:@"1" forKey:@"pageNum"];
    [collReq setField:PAGESIZE forKey:@"pageSize"];

    [HttpCommunication request:collReq getResponse:collRespon Success:^(JuPlusResponse *response) {
        [dataArray addObjectsFromArray:collRespon.listArray];
        [self.listTab reloadData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
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
