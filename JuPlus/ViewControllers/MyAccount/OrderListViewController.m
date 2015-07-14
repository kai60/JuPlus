//
//  OrderListViewController.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListReq.h"
#import "OrderListRespon.h"
#import "OrderListCell.h"
#import "OrderDetailViewController.h"
#define defaultH 90.0f
@interface OrderListViewController ()
{
    OrderListReq *listReq;
    OrderListRespon *listRespon;
}
@end

@implementation OrderListViewController

#pragma mark --tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListDTO *dto = [listRespon.orderListArray objectAtIndex:indexPath.row];
    return defaultH + dto.totalCount*80.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listRespon.orderListArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"orderList";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil)
    {
        cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    OrderListDTO *dto = [listRespon.orderListArray objectAtIndex:indexPath.row];
    [cell fileCell:dto];
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"我的订单"];
    [self.view addSubview:self.orderListTab];
    // Do any additional setup after loading the view.
}
-(void)startRequest
{
    listReq = [[OrderListReq alloc]init];
    [listReq setField:[CommonUtil getToken] forKey:TOKEN];
    [listReq setField:@"1" forKey:PageNum];
    [listReq setField:PAGESIZE forKey:PageSize];
    listRespon = [[OrderListRespon alloc]init];
    [HttpCommunication request:listReq getResponse:listRespon Success:^(JuPlusResponse *response) {
        [self.orderListTab reloadData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
-(UITableView *)orderListTab
{
    if(!_orderListTab)
    {
        _orderListTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        _orderListTab.delegate = self;
        _orderListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderListTab.dataSource = self;
    }
    return _orderListTab;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     OrderListDTO *dto = [listRespon.orderListArray objectAtIndex:indexPath.row];
    OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
    detail.orderNo = dto.orderNo;
    [self.navigationController pushViewController:detail animated:YES];

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
