//
//  DesignerDetailViewController.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerDetailViewController.h"
#import "AppointViewController.h"
#import "DesignerCell.h"
#import "DesignerHeaderView.h"
@interface DesignerDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableV;
@property (nonatomic, strong)NSMutableArray *detailArray;
@property (nonatomic,strong)UIButton *appointmentBtn;
@end

@implementation DesignerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.titleLabel setText:@"stella"];
    [self createTable];
    [self.view addSubview:self.appointmentBtn];
    // Do any additional setup after loading the view.
}
- (void)createTable
{
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height) style:UITableViewStylePlain];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.separatorStyle = 0; // 去掉分割线
    
    // 初始化tableHeaderView
    DesignerHeaderView *tableHeader = [[DesignerHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICTURE_HEIGHT /2-40)];
    self.tableV.tableHeaderView = tableHeader;
    
    [self.view addSubview:self.tableV];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    DesignerCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[DesignerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return PICTURE_HEIGHT / 2;
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
        _appointmentBtn.alpha = ALPHLA_BUTTON;
        [_appointmentBtn addTarget:self action:@selector(appointment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appointmentBtn;
}
- (void)appointment
{
    
}
-(void)nextPress
{
    AppointViewController *app = [[AppointViewController alloc]init];
    [self.navigationController pushViewController:app animated:YES];
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
