//
//  DesignerDetailViewController.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerDetailViewController.h"
#import "AppointViewController.h"
@interface DesignerDetailViewController ()

@end

@implementation DesignerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, SCREEN_WIDTH, SCREEN_HEIGHT-20.0f)];
    [img setImage:[UIImage imageNamed:@"1"]];
    [self.view addSubview:img];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
    [btn addTarget:self action:@selector(nextPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0.0f, 0.0f, 60.0f, 60.0f);
    [back addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
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
