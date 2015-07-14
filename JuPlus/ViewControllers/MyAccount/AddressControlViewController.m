//
//  AddressControlViewController.m
//  JuPlus
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//地址管理

#import "AddressControlViewController.h"

@interface AddressControlViewController ()<UITableViewDataSource,UITableViewDelegate>
//添加地址
@property(nonatomic,strong)JuPlusUIView *addView;
//地址列表
@property(nonatomic,strong)UITableView *addressListTab;
//数据源
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation AddressControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uifig];
    // Do any additional setup after loading the view.
}
-(void)uifig
{
    self.titleLabel.text = @"收货地址管理";
    [self.view addSubview:self.addView];
    [self.view addSubview:self.addressListTab];
    
}
-(JuPlusUIView *)addView
{
    if(!_addView)
    {
        _addView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, 40.0f)];
        _addView.backgroundColor = Color_White;
        
        JuPlusUILabel *label = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 100.0f, 30.0f)];
        [label setFont:FontType(16.0f)];
        [label setText:@"新增收货地址"];
        [_addView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 40.0f, 10.0f, 30.0f, 30.0f);
        [btn setImage:[UIImage imageNamed:@"icons_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icons_add"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [_addView addSubview:btn];
    }
    return _addView;
}
-(UITableView *)addressListTab
{
    if(!_addressListTab)
    {
        _addressListTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, self.addView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.addView.bottom) style:UITableViewStylePlain];
        _addressListTab.delegate = self;
        _addressListTab.dataSource = self;
    }
    return _addressListTab;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
-(void)addClick:(UIButton *)sender
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
