//
//  OrderDetailViewController.m
//  JuPlus
//
//  Created by admin on 15/7/9.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "PlaceOrderReq.h"
#import "PlaceOrderRespon.h"
#import "ReceiveMessageView.h"
#import "productView.h"
#import "productOrderDTO.h"
#import "AddressDTO.h"
#define space 10.0f
@interface OrderDetailViewController ()
{
    PlaceOrderReq *getReq;
    PlaceOrderRespon *getRespon;
    //上送购买字段
    NSMutableArray *productList;
    //价格总数
    CGFloat priceNum;
    
    NSMutableArray *productArr;
}
//标题
@property(nonatomic,strong)JuPlusUIView *sectionTitleV;
//内容
@property(nonatomic,strong)UIScrollView *listScrollV;
//所有单品内容
@property(nonatomic,strong)JuPlusUIView *packageV;
//收货地址
@property(nonatomic,strong)ReceiveMessageView *receivedAddressV;
//总价
@property(nonatomic,strong)JuPlusUILabel *placeOrderV;

@property(nonatomic,strong)JuPlusUILabel *statusL;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"订单详情";
    productArr = [[NSMutableArray alloc]init];
    productList = [[NSMutableArray alloc]init];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [self.view addSubview:self.listScrollV];
    
    [self.listScrollV addSubview:self.sectionTitleV];
    
    [self.listScrollV addSubview:self.packageV];
    
    [self.listScrollV addSubview:self.receivedAddressV];
    
    [self.view addSubview:self.placeOrderV];
    
}
//暂时无购物车，数据从上界面返回
#pragma mark --request
//网络交互
-(void)startRequest
{
    getReq = [[PlaceOrderReq alloc]init];
    [getReq setField:self.orderNo forKey:@"orderNo"];
    [getReq setField:[CommonUtil getToken] forKey:TOKEN];
    getRespon = [[PlaceOrderRespon alloc]init];
    [HttpCommunication request:getReq getResponse:getRespon Success:^(JuPlusResponse *response) {
      //数据加载成功
        [self fileData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
-(void)fileData
{
    for(int i=0;i<[getRespon.productArr count];i++)
    {
        productOrderDTO *dto = [getRespon.productArr objectAtIndex:i];
        productView *pro = [[productView alloc]initWithFrame:CGRectMake(0.0f, 100.0f*i, _packageV.width, 100.0f)];
        pro.titleL.frame = CGRectMake(pro.titleL.left, pro.titleL.top, 180.0f, pro.titleL.height);
        [pro.countV setHidden:YES];
        [pro.typeLabel setHidden:NO];
        [pro.typeLabel setText:[NSString stringWithFormat:@"X%@",dto.countNum]];
        [pro loadData:dto];
        [_packageV addSubview:pro];
        [productArr addObject:pro];
    }
    AddressDTO *dto = [[AddressDTO alloc]init];
    dto.addName = getRespon.receictName;
    dto.addAddress = getRespon.receictAddress;
    dto.addMobile = getRespon.receictMobile;
    //发货状态
    [self.statusL setText:getRespon.status];
    
    [self.receivedAddressV setAddressInfo:dto];
    
    [self resetFrames];
    [self.placeOrderV setText:[NSString stringWithFormat:@"总价：%.2f",[getRespon.totalAmt floatValue]]];
}
-(void)resetFrames
{
    CGRect frame = self.packageV.frame;
    frame.size.height = 100.0f*[getRespon.productArr count];
    self.packageV.frame = frame;
    
    UIView *middle1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.bottom, SCREEN_WIDTH, 10.0f)];
    [middle1 setBackgroundColor:RGBCOLOR(239, 239, 239)];
    [self.listScrollV addSubview:middle1];

    self.receivedAddressV.frame = CGRectMake(0.0f, self.packageV.bottom+10.0f, SCREEN_WIDTH, 60.0f);
    
    UIView *middle2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.receivedAddressV.bottom, SCREEN_WIDTH, self.listScrollV.height - self.receivedAddressV.bottom)];
    [middle2 setBackgroundColor:RGBCOLOR(239, 239, 239)];
    [self.listScrollV addSubview:middle2];

    [self.listScrollV setContentSize:CGSizeMake(self.listScrollV.width, self.receivedAddressV.bottom+10.0f)];
}

#pragma mark --UI
//标题
-(JuPlusUIView *)sectionTitleV
{
    if(!_sectionTitleV)
    {
        _sectionTitleV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, 0.0f, self.view.width - space*2, 30.0f)];
        JuPlusUILabel *left = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 30.0f)];
        [left setFont:FontType(14.0f)];
        [left setTextColor:Color_Gray];
        [left setText:@"单品详情"];
        [_sectionTitleV addSubview:left];
        
        self.statusL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(left.right, 0.0f, 70.0f, 30.0f)];
        [self.statusL setFont:FontType(14.0f)];
        [self.statusL setTextColor:Color_Basic];
        [_sectionTitleV addSubview:self.statusL];
        JuPlusUILabel *right = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(_sectionTitleV.width - 100.0f, 0.0f, 100.0f, 30.0f)];
        [right setFont:FontType(14.0f)];
        [right setTextColor:Color_Gray];
        [right setText:@"发件数量"];
        right.textAlignment = NSTextAlignmentRight;
        [_sectionTitleV addSubview:right];
        JuPlusUIView *line = [[JuPlusUIView alloc]initWithFrame:CGRectMake(left.left, _sectionTitleV.bottom -1.0f, _sectionTitleV.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_sectionTitleV addSubview:line];
    }
    return _sectionTitleV;
}
//滑动层
-(UIScrollView *)listScrollV
{
    if (!_listScrollV) {
        _listScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH , view_height - 44.0f)];
        _listScrollV.backgroundColor = Color_White;
    }
    
    return _listScrollV;
}
-(JuPlusUIView *)packageV
{
    if(!_packageV)
    {
        _packageV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space,self.sectionTitleV.bottom, SCREEN_WIDTH - space*2, 100.0f)];
        
    }
    return _packageV;
}
//收货地址
-(JuPlusUIView *)receivedAddressV
{
    if(!_receivedAddressV)
    {
        _receivedAddressV =[[ReceiveMessageView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.bottom+space, SCREEN_WIDTH, 60.0f)];
        
    }
    return _receivedAddressV;
}
//底部下单条
-(JuPlusUILabel *)placeOrderV
{
    if(!_placeOrderV)
    {
        _placeOrderV = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f)];
        [_placeOrderV setFont:[UIFont boldSystemFontOfSize:17.0f]];
        _placeOrderV.backgroundColor = Color_White;
        _placeOrderV.textColor = Color_Basic;
        _placeOrderV.textAlignment = NSTextAlignmentCenter;
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
