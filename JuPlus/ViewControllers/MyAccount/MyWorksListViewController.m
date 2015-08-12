//
//  MyWorksListViewController.m
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyWorksListViewController.h"
#import "JuPlusRefreshView.h"
@interface MyWorksListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ScrollRefreshViewHead *header;
    ScrollRefreshViewFooter *footer;
}
@end

@implementation MyWorksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //重写返回按钮
    [self resetBackView];
    [self.titleLabel setText:@"我的作品"];
    [self.view addSubview:self.listTab];
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
    MyWorksDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:dto];
    return cell;
}
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
