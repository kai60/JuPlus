//
//  PlaceOrderViewController.m
//  JuPlus
//
//  Created by admin on 15/6/29.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "productView.h"
#import "PlaceOrderReq.h"
#import "PlaceOrderRespon.h"
#import "ReceiveMessageView.h"
#import "PostOrderReq.h"
#import "PostOrderRespon.h"
#import "OrderDetailViewController.h"
#import "AddressControlViewController.h"
#import "GetAddressListReq.h"
#import "GetAddressRespon.h"
#import "AddressDTO.h"
#import "AddAddressViewController.h"
#define space 20.0f
@interface PlaceOrderViewController ()
{
    PostOrderReq *postReq;
    PostOrderRespon *postRespon;
    //上送购买字段
    NSMutableArray *productList;
    //价格总数
    CGFloat priceNum;
    
    GetAddressListReq *addReq;
    GetAddressRespon *addRespon;
    
    UIView *middle2;
}
//标题
@property(nonatomic,strong)JuPlusUIView *sectionTitleV;
//内容
@property(nonatomic,strong)UIScrollView *listScrollV;
//所有单品内容
@property(nonatomic,strong)JuPlusUIView *packageV;
//收货地址
@property(nonatomic,strong)ReceiveMessageView *receivedAddressV;

@property(nonatomic,strong)UIButton *addAddressBtn;
//确认下单
@property(nonatomic,strong)JuPlusUIView *placeOrderV;
//总价
@property(nonatomic,strong)JuPlusUILabel *totalPriceL;

@property(nonatomic,strong)UIButton *postOrderBtn;
//得到收货地址列表
@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation PlaceOrderViewController
{
    NSMutableArray *productArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"确认订单";
    productArr = [[NSMutableArray alloc]init];
    productList = [[NSMutableArray alloc]init];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [self.view addSubview:self.listScrollV];
    
    [self.listScrollV addSubview:self.sectionTitleV];

    [self.listScrollV addSubview:self.packageV];
    
    
    [self.view addSubview:self.placeOrderV];
    
    [self.placeOrderV addSubview:self.totalPriceL];
    
    [self.placeOrderV addSubview:self.postOrderBtn];
    
    [self fileData];
    
    [self.listScrollV addSubview:self.receivedAddressV];
    
    [self.listScrollV addSubview:self.addAddressBtn];
    
    middle2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.receivedAddressV.bottom, SCREEN_WIDTH, self.listScrollV.height - self.receivedAddressV.bottom)];
    [middle2 setBackgroundColor:RGBCOLOR(239, 239, 239)];
    [self.listScrollV addSubview:middle2];

    //添加通知中心，观察总价的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetTotalPrice) name:ResetPrice object:nil];
    //添加通知中心，实时改变地址
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRequest) name:ReloadAddress object:nil];

    // Do any additional setup after loading the view.
}
//暂时无购物车，数据从上界面返回
#pragma mark --request
//网络交互
-(void)startRequest
{
    addReq = [[GetAddressListReq alloc]init];
    [addReq setField:[CommonUtil getToken] forKey:TOKEN];
    addRespon = [[GetAddressRespon alloc]init];
    [HttpCommunication request:addReq getResponse:addRespon Success:^(JuPlusResponse *response) {
        self.dataArray = addRespon.addressArray;
      //数据加载成功
        [self fileAddress];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
//补充地址信息
-(void)fileAddress
{
    UIView *header;
    if([self.dataArray count]==0)
    {
        [self.receivedAddressV setHidden:YES];
        [self.addAddressBtn setHidden:NO];
        header = self.addAddressBtn;
    }
    else
    {
        [self.receivedAddressV setHidden:NO];
        [self.addAddressBtn setHidden:YES];
        header = self.receivedAddressV;
    for (AddressDTO *dto in self.dataArray) {
        if (dto.isDefault) {
            [self.receivedAddressV setAddressInfo:dto];
        }
    }
    }
    middle2.frame = CGRectMake(0.0f, header.bottom, middle2.width, self.listScrollV.height - header.bottom);
}
-(void)fileData
{
    
    for(int i=0;i<[self.regArray count];i++)
    {
        productOrderDTO *dto = [self.regArray objectAtIndex:i];
        productView *pro = [[productView alloc]initWithFrame:CGRectMake(0.0f, 100.0f*i, self.packageV.width, 100.0f)];
        [pro loadData:dto];
        [self.packageV addSubview:pro];
        [productArr addObject:pro];
    }
    //重置frame
    [self resetFrames];
    [self resetTotalPrice];
}
-(void)resetFrames
{
    CGRect frame = self.packageV.frame;
    frame.size.height = 100.0f*[self.regArray count];
    self.packageV.frame = frame;
    
    self.receivedAddressV.frame = CGRectMake(0.0f, self.packageV.bottom+20.0f, SCREEN_WIDTH, 60.0f);
    
    UIView *middle1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.bottom, SCREEN_WIDTH, 20.0f)];
    [middle1 setBackgroundColor:RGBCOLOR(239, 239, 239)];
    [self.listScrollV addSubview:middle1];

    
    self.addAddressBtn.frame = CGRectMake(0.0f, self.packageV.bottom+20.0f, SCREEN_WIDTH, 30.0f);
    [self.listScrollV setContentSize:CGSizeMake(self.listScrollV.width, self.receivedAddressV.bottom+10.0f +TABBAR_HEIGHT)];
}
#pragma mark changePrice
//计算总价
-(void)resetTotalPrice
{
    CGFloat total = 0;
    for(int i =0;i<[self.regArray count];i++)
    {
        productView *pro = [productArr objectAtIndex:i];
        productOrderDTO *dto = [self.regArray objectAtIndex:i];
        total+= [dto.price floatValue]*[pro.countV getCountNum];
    }
    
    [self.totalPriceL setText:[NSString stringWithFormat:@"总价：¥%.2f",total]];
}
#pragma mark --UI
//标题
-(JuPlusUIView *)sectionTitleV
{
    if(!_sectionTitleV)
    {
        _sectionTitleV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, 0.0f, self.view.width - space*2, 30.0f)];
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
        _listScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH , view_height )];
        _listScrollV.backgroundColor = Color_White;
    }
    
    return _listScrollV;
}
-(JuPlusUIView *)packageV
{
    if(!_packageV)
    {
        _packageV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, self.sectionTitleV.bottom, SCREEN_WIDTH - space*2, 100.0f)];
        
           }
    return _packageV;
}
//收货地址(如果有)
-(ReceiveMessageView *)receivedAddressV
{
    if(!_receivedAddressV)
    {
        _receivedAddressV =[[ReceiveMessageView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.bottom+space/2, SCREEN_WIDTH, 60.0f)];
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, _receivedAddressV.width, _receivedAddressV.height);
        [btn addTarget:self action:@selector(addressClick:) forControlEvents:UIControlEventTouchUpInside];
        [_receivedAddressV addSubview:btn];
    }
    return _receivedAddressV;
}
//收货地址(如果无)
-(UIButton *)addAddressBtn
{
    if(!_addAddressBtn)
    {
    _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addAddressBtn.frame = CGRectMake(0.0f, self.packageV.bottom+20.0f, SCREEN_WIDTH, 30.0f);
    [_addAddressBtn setImage:[UIImage imageNamed:@"add_address"] forState:UIControlStateNormal];
    [_addAddressBtn setTitle:@"请添加收货地址" forState:UIControlStateNormal];
    [_addAddressBtn.titleLabel setFont:FontType(16.0f)];
    [_addAddressBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
    [_addAddressBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_addAddressBtn.imageView.image.size.width, 0.0, 0.0)];
        [_addAddressBtn addTarget:self action:@selector(addAddressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;

}
-(void)addAddressBtnClick:(UIButton *)sender
{
    AddressControlViewController *add = [[AddressControlViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
//底部下单条
-(JuPlusUIView *)placeOrderV
{
    if(!_placeOrderV)
    {
        _placeOrderV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f)];
    }
    return _placeOrderV;
}
-(JuPlusUILabel *)totalPriceL
{
    if(!_totalPriceL)
    {
        _totalPriceL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f,  0.0f,self.placeOrderV.width/2, self.placeOrderV.height)];
        [_totalPriceL setTextColor:Color_Basic];
        [_totalPriceL setFont:FontType(16.0f)];
        [_totalPriceL setBackgroundColor:Color_White];
        _totalPriceL.textAlignment = NSTextAlignmentCenter;
    }
    return _totalPriceL;
}
-(UIButton *)postOrderBtn
{
    if(!_postOrderBtn)
    {
        _postOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postOrderBtn.frame = CGRectMake(self.totalPriceL.right, 0.0f, self.placeOrderV.width/2, self.placeOrderV.height);
        [_postOrderBtn setBackgroundColor:Color_Pink];
        [_postOrderBtn setTitle:@"确认下单" forState:UIControlStateNormal];
        [_postOrderBtn.titleLabel setFont:FontType(16.0f)];
        _postOrderBtn.alpha = ALPHLA_BUTTON;

        [_postOrderBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_postOrderBtn addTarget:self action:@selector(postPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postOrderBtn;
}
#pragma mark --btnClick
-(void)addressClick:(UIButton *)sender
{
    AddressControlViewController *control = [[AddressControlViewController alloc]init];
    [self.navigationController pushViewController:control animated:YES];
}
//点击下单按钮弹出下单成功提示
-(void)postPressed:(UIButton *)sender
{
    if (self.receivedAddressV.hidden) {
        [self showAlertView:@"请先添加收货地址" withTag:0];
    }
    else
    {
    postReq = [[PostOrderReq alloc]init];
    postRespon = [[PostOrderRespon alloc]init];
    [postReq setField:[CommonUtil getToken] forKey:TOKEN];
    //收货人信息
    [postReq setField:[NSString stringWithFormat:@"%ld",(long)self.receivedAddressV.tag] forKey:@"receiverId"];
    [postReq setField:[self getPostList] forKey:@"productList"];
    
    [HttpCommunication request:postReq getResponse:postRespon Success:^(JuPlusResponse *response) {
        
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"你的订单已预订成功，稍后将由客服与您确认并发货。" delegate:self cancelButtonTitle:Remind_Knowit otherButtonTitles:nil , nil];
        alt.tag = 101;
        [alt show];
        } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    }
}
-(NSArray *)getPostList
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i=0;i<[productArr count];i++)
    {
        productView *pro = [productArr objectAtIndex:i];
        productOrderDTO *dto = [self.regArray objectAtIndex:i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:dto.productNo forKey:@"productNo"];
        [dict setObject:dto.regNo forKey:@"collocatePicNo"];
        [dict setObject:[NSString stringWithFormat:@"%d",[pro.countV getCountNum]] forKey:@"productNum"];
        [arr addObject:dict];
    }
    return arr;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];

    if(alertView.tag==101)
    {
        OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
        detail.orderNo = postRespon.orderNo;
        [self.navigationController pushViewController:detail animated:YES];

    }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
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
