//
//  DesignerDetailViewController.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerDetailViewController.h"
#import "DesignerCell.h"
#import "DesignerHeaderView.h"
#import "DesignerRequest.h"
#import "DesignerRespon.h"
#import "DesignerDTO.h"
#import "PackageViewController.h"
#import "AppointRequest.h"
#import "AppointRespon.h"
@interface DesignerDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate>
{
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    ScrollRefreshView *selectView;
    
    int pageNum;
    int allCount;
    DesignerHeaderView *tableHeader;
}

@property (nonatomic,strong)UIButton *appointmentBtn;
@end

@implementation DesignerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageNum = 1;
    [self.titleLabel setText:@"设计师"];
   
    self.dataArray = [[NSMutableArray alloc]init];
    [self startRequestDes];
    [self createTable];
    [self.view addSubview:self.appointmentBtn];

    //上拉刷新
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.tableV;
    //下拉加载
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.tableV;
    // Do any additional setup after loading the view.
}
- (void)createTable
{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = 0; // 去掉分割线
    
    // 初始化tableHeaderView
    tableHeader = [[DesignerHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICTURE_HEIGHT /2-40)];
    self.tableV.tableHeaderView = tableHeader;
    
    [self.view addSubview:self.tableV];
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
    
    [self startRequestDes];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}
//网络请求
- (void)startRequestDes
{
    DesignerRequest *designerReq = [[DesignerRequest alloc]init];
    [designerReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [designerReq setField:PAGESIZE forKey:PageSize];
    [designerReq setField:self.userId forKey:@"memNo"];
    //NSLog(@"---------%@", self.userId);
    DesignerRespon * respon = [[DesignerRespon alloc]init];
    [HttpCommunication request:designerReq getResponse:respon Success:^(JuPlusResponse *response) {
    allCount = [respon.count integerValue];
    if (pageNum == 1) {
        [self.dataArray removeAllObjects];
    }
        
        [tableHeader.personHeadImageView setimageUrl:respon.portraitPath placeholderImage:nil];
        [tableHeader.detail setText:respon.nickname];
        [self.dataArray addObjectsFromArray:respon.designerArray];
//        //判断是否可以预约设计师
//        if ([respon.orderFlag intValue]== 0) {
//            NSLog(@"%@",respon.orderFlag);
//        }else if ([respon.orderFlag intValue] == 1){
//            [self.view addSubview:self.appointmentBtn];
//        }
        [self.tableV reloadData];
        [self stopReresh];
    
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    DesignerCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[DesignerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    self.dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:_dto];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return PICTURE_HEIGHT / 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PackageViewController *packVC = [[PackageViewController alloc]init];
    [self.navigationController pushViewController:packVC animated:YES];
}
-(UIButton *)appointmentBtn
{
    if(!_appointmentBtn)
    {
        _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _appointmentBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_appointmentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_appointmentBtn setTitle:@"预约设计师" forState:UIControlStateNormal];
        [_appointmentBtn setBackgroundColor:Color_Pink];
        _appointmentBtn.titleLabel.font = FontType(FontSize);
        _appointmentBtn.alpha = ALPHLA_BUTTON;
        [_appointmentBtn addTarget:self action:@selector(appointment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appointmentBtn;
}
- (void)appointment
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"您是否确定预约" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alt.tag = 10;
    [alt show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag == 10){
        if (buttonIndex == 1) {
          //网络请求
            
        }
    }
}
- (void)appoin
{
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"恭喜您已预约成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
    [aler show];
    
}
-(void)backPress
{
    [self.navigationController popViewControllerAnimated:YES];
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
