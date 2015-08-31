//
//  MyWorksListViewController.m
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyWorksListViewController.h"
#import "JuPlusRefreshView.h"
#import "MyworkslistReq.h"
#import "MyworkslistRespon.h"
#import "MyDeleteReq.h"
#import "GetFavListReq.h"
#import "PackageViewController.h"
#import "CameraViewController.h"
#import "HomeFurnishingViewController.h"
#import "FavViewController.h"
@interface MyWorksListViewController ()<UITableViewDelegate,UITableViewDataSource,ScrollRefreshViewDegegate>

{
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    ScrollRefreshView *selectView;
    
    int pageNum;
    int allCount;
    
}

@end

@implementation MyWorksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //重写返回按钮
    [self resetBackView];
    pageNum = 1;
    [self.titleLabel setText:@"我的作品"];
    [self.view addSubview:self.listTab];
    
    [self startRequestMy];
    //去掉分割线
    self.listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = [[NSMutableArray alloc]init];
    
    //发布按钮
    [self.rightBtn setHidden:NO];
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:Color_Basic  forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
    
    //上拉刷新
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.listTab;
    //下拉加载
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.listTab;
    
    // Do any additional setup after loading the view.
}
- (void)release:(UIButton *)button
{
    CameraViewController *cameVC = [[CameraViewController alloc]init];
    [self.navigationController pushViewController:cameVC animated:YES];
}
-(void)resetBackView
{
    [self.leftBtn setHidden:YES];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
}
-(void)backPress:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    NSArray *vcArr = [self.navigationController viewControllers];
//    for (UIViewController *vc in vcArr) {
//        if([vc isKindOfClass:[HomeFurnishingViewController class]])
//        {
//            [self.navigationController popToViewController:vc animated:YES];
//            return;
//        }
//    }
}
#pragma mark --uifig
-(UITableView *)listTab
{
    if(!_listTab)
    {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        _listTab.delegate = self;
        _listTab.dataSource = self;
    
    }return _listTab;
}
#pragma mark --refreshDelegate
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
        if([self.dataArray count]>=allCount)
        {
            //显示无更多内容
            [refreshView setState:RefreshStateALL withAnimate:YES];
            return;
        }
        pageNum++;
    }
    
    [self startRequestMy];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}
//网络请求
- (void)startRequestMy
{
    MyworkslistReq *myReq = [[MyworkslistReq alloc]init
                                     ];
    [myReq setField:[CommonUtil getToken] forKey:TOKEN];
    [myReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [myReq setField:PAGESIZE forKey:PageSize];
    MyworkslistRespon * respon = [[MyworkslistRespon alloc]init];
    [HttpCommunication request:myReq getResponse:respon Success:^(JuPlusResponse *response) {
        allCount = [respon.count integerValue];
        if (pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:respon.myworkArray];
        [self.listTab reloadData];
        [self stopReresh];
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
}
#pragma mark --
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT/2+41.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *work = @"work";
    MyWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:work];
    if (!cell) {
        cell = [[MyWorksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:work];
    }
    cell.deleteBtn.tag = indexPath.row + 1000;

    //复制方法fileData
    self.dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:_dto];
    
    //收藏按钮
    [cell.favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //按钮方法
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//收藏按钮方法
- (void)favBtnClick:(UIButton *)button
{
    FavViewController *favVC = [[FavViewController alloc]init];
    favVC.favId = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:favVC animated:YES];
}
- (void)deleteBtnClick:(UIButton *)button
{
    
//     self.indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    
    self.index = [NSIndexPath indexPathForRow:button.tag - 1000 inSection:0];
    
    NSLog(@"Index = %d", (int)self.index.row);

    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"确定删除此项内容么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alt show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if(buttonIndex == 1){
//       NSLog(@"%ld", (long)self.index);
        
        MyDeleteReq *req = [[MyDeleteReq alloc]init];
        MyWorksDTO *dto = [self.dataArray objectAtIndex:self.index.row];
        NSLog(@"self.dataArray.count = %d", (int)self.dataArray.count);
        
        [req setField:dto.regNo forKey:@"collocateNo"];
        [req setField:[CommonUtil getToken] forKey:TOKEN];
        
        NSLog(@"%@ ------", req);
        JuPlusResponse *respon = [[JuPlusResponse alloc]init];
        
        [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
           
            [CommonUtil postNotification:ReloadAddress Object:nil];
            //删除成功
            [self.dataArray removeObjectAtIndex:self.index.row];
            NSLog(@"删除的Index = %d", (int)self.index.row);

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index.row inSection:0];
            NSLog(@"刷新的Index = %d", (int)self.index.row);
            
            [self.listTab deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //刷新tab
            NSIndexSet *indexset = [[NSIndexSet alloc] initWithIndex:0];
            [self.listTab reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
            
        } failed:^(ErrorInfoDto *errorDTO) {
            [self errorExp:errorDTO];
        } showProgressView:YES with:self.view];
    }
}
//推到详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyWorksDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    PackageViewController *singVC = [[PackageViewController alloc]init];
    singVC.regNo = dto.regNo;
    [self.navigationController pushViewController:singVC animated:YES];

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
