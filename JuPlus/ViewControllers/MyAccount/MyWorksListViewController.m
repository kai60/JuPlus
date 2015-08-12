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

@interface MyWorksListViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    ScrollRefreshViewHead *header;
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
    
    self.dataArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}
-(void)resetBackView
{
    
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
        NSLog(@"~~~~~~~~%@",self.dataArray);
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
}
#pragma mark --
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *work = @"work";
    MyWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:work];
    if (cell==nil) {
        cell = [[MyWorksCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:work];
    }
    
    //复制方法fileData
    MyWorksDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:dto];
    return cell;
}
//推到详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
