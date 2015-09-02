//
//  MyAppointViewController.m
//  JuPlus
//
//  Created by ios_admin on 15/9/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyAppointViewController.h"
#import "MyAppointCell.h"
#import "MyEffectCell.h"
#import "MyappointRequest.h"
#import "MyappointRespon.h"
@interface MyAppointViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate>
{
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    ScrollRefreshView *selectView;
    
    int pageNum;
    int allCount;
}
@property (nonatomic, strong)UITableView *myAppTable;
@end

@implementation MyAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNum = 1;
    [self.titleLabel setText:@"我的预约"];
    self.dataArray = [[NSMutableArray alloc]init];
    [self startRequestApp];
    [self myAppTable];
    
    //上拉刷新
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.myAppTable;
    //下拉加载
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.myAppTable;
    // Do any additional setup after loading the view.
}
//网络请求
- (void)startRequestApp
{
    MyappointRequest *appReq = [[MyappointRequest alloc]init];
    [appReq setField:[CommonUtil getToken] forKey:TOKEN];
    [appReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [appReq setField:PAGESIZE forKey:PageSize];
    MyappointRespon *respon = [[MyappointRespon alloc]init];
    [HttpCommunication request:appReq getResponse:respon Success:^(JuPlusResponse *response) {
        [self.dataArray addObjectsFromArray:respon.appArray];
        [self.myAppTable reloadData];
        [self stopReresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
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
    
    [self startRequestApp];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}
- (UITableView *)myAppTable
{
    if (!_myAppTable) {
        
        _myAppTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _myAppTable.separatorStyle = 0;
        _myAppTable.backgroundColor = RGBACOLOR(235.0f, 235.0f, 235.0f, 0.8);
        _myAppTable.dataSource = self;
        _myAppTable.delegate = self;
        [self.view addSubview:_myAppTable];
    }
    return _myAppTable;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    
    MyappointDTO *dto = [[MyappointDTO alloc]init];
    if ([dto.type integerValue] == 1) {
        MyAppointCell *cellApp = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cellApp) {
            cellApp = [[MyAppointCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        self.dto = [self.dataArray objectAtIndex:indexPath.row];
        [cellApp fileData:_dto];
        return cellApp;
    }else  {
        MyEffectCell *cellEff = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cellEff) {
            cellEff = [[MyEffectCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
        }
        self.dto = [self.dataArray objectAtIndex:indexPath.row];
        [cellEff fileData:_dto];
        return cellEff;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT/2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
