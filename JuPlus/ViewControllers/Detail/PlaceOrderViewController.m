//
//  PlaceOrderViewController.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "productView.h"
#define space 20.0f
@interface PlaceOrderViewController ()
//标题
@property(nonatomic,strong)JuPlusUIView *sectionTitleV;
//内容
@property(nonatomic,strong)UIScrollView *listScrollV;
//所有单品内容
@property(nonatomic,strong)JuPlusUIView *packageV;
//收货地址
@property(nonatomic,strong)JuPlusUIView *receivedAddressV;
//确认下单
@property(nonatomic,strong)JuPlusUIView *placeOrderV;
@end

@implementation PlaceOrderViewController
{
    NSMutableArray *productArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"我的订单";
    productArr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [self.view addSubview:self.listScrollV];
    
    [self.listScrollV addSubview:self.sectionTitleV];

    [self.listScrollV addSubview:self.packageV];
    
    [self.listScrollV addSubview:self.receivedAddressV];
    
    [self.view addSubview:self.placeOrderV];
    // Do any additional setup after loading the view.
}
//标题
-(JuPlusUIView *)sectionTitleV
{
    if(!_sectionTitleV)
    {
        _sectionTitleV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, space, self.view.width - space*2, 30.0f)];
        JuPlusUILabel *left = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
        [left setFont:FontType(14.0f)];
        [left setTextColor:Color_Gray];
        [left setText:@"单品详情"];
        [_sectionTitleV addSubview:left];
        JuPlusUILabel *right = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(_sectionTitleV.width - 100.0f, 0.0f, 100.0f, 30.0f)];
        [right setFont:FontType(14.0f)];
        [right setTextColor:Color_Gray];
        [right setText:@"发件数量"];
        right.textAlignment = NSTextAlignmentRight;
        [_sectionTitleV addSubview:right];
        JuPlusUIView *line = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, _sectionTitleV.bottom -1.0f, _sectionTitleV.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
    }
    return _sectionTitleV;
}
//滑动层
-(UIScrollView *)listScrollV
{
    if (!_listScrollV) {
        _listScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH , view_height - 44.0f)];
        
    }
    
    return _listScrollV;
}
-(JuPlusUIView *)packageV
{
    if(!_packageV)
    {
        _packageV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, space+self.sectionTitleV.bottom, SCREEN_WIDTH - space*2, 100.0f)];
        
        for(int i=0;i<1;i++)
        {
            productView *pro = [[productView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _packageV.width, _packageV.height)];
            [pro.countV setCountNum:1];
            [_packageV addSubview:pro];
            [productArr addObject:pro];
        }
    }
    return _packageV;
}
//收货地址
-(JuPlusUIView *)receivedAddressV
{
    if(!_receivedAddressV)
    {
        _receivedAddressV =[[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.listScrollV.bottom+20.0f, SCREEN_WIDTH, 120.0f)];
        
    }
    return _receivedAddressV;
}

-(JuPlusUIView *)placeOrderV
{
    if(!_placeOrderV)
    {
        _placeOrderV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.receivedAddressV.bottom+20.0f, SCREEN_WIDTH, 44.0f)];
    }
    return _placeOrderV;
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
