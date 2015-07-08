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
#define space 20.0f
@interface PlaceOrderViewController ()
{
    PlaceOrderReq *getReq;
    PlaceOrderRespon *getRespon;
    PostOrderReq *postReq;
    PostOrderRespon *postRespon;
    //上送购买字段
    NSMutableArray *productList;
    //价格总数
    CGFloat priceNum;
}
//标题
@property(nonatomic,strong)JuPlusUIView *sectionTitleV;
//内容
@property(nonatomic,strong)UIScrollView *listScrollV;
//所有单品内容
@property(nonatomic,strong)JuPlusUIView *packageV;
//收货地址
@property(nonatomic,strong)ReceiveMessageView *receivedAddressV;
//确认下单
@property(nonatomic,strong)JuPlusUIView *placeOrderV;
//总价
@property(nonatomic,strong)JuPlusUILabel *totalPriceL;

@property(nonatomic,strong)UIButton *postOrderBtn;
@end

@implementation PlaceOrderViewController
{
    NSMutableArray *productArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"我的订单";
    productArr = [[NSMutableArray alloc]init];
    productList = [[NSMutableArray alloc]init];
    self.view.backgroundColor = RGBCOLOR(239, 239, 239);
    
    [self.view addSubview:self.listScrollV];
    
    [self.listScrollV addSubview:self.sectionTitleV];

    [self.listScrollV addSubview:self.packageV];
    
    UIView *middle1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.bottom, SCREEN_WIDTH, 20.0f)];
    [middle1 setBackgroundColor:RGBCOLOR(239, 239, 239)];
    [self.listScrollV addSubview:middle1];
    
    [self.listScrollV addSubview:self.receivedAddressV];
    
    UIView *middle2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.receivedAddressV.bottom, SCREEN_WIDTH, self.listScrollV.height - self.receivedAddressV.bottom)];
    [middle2 setBackgroundColor:RGBCOLOR(239, 239, 239)];
    [self.listScrollV addSubview:middle2];

    
    [self.view addSubview:self.placeOrderV];
    
    [self.placeOrderV addSubview:self.totalPriceL];
    
    [self.placeOrderV addSubview:self.postOrderBtn];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"导演",@"name",@"15902180128",@"mobile",@"普陀区云岭东路651号304",@"address", nil];
    [self.receivedAddressV setAddressInfo:dic];
    
    [self.totalPriceL setText:[NSString stringWithFormat:@"总价：¥%.2f",[self.price floatValue]]];
    [self fileData];
    //添加通知中心，观察总价的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetTotalPrice) name:ResetPrice object:nil];
    // Do any additional setup after loading the view.
}
//暂时无购物车，数据从上界面返回
#pragma mark --request
////网络交互
//-(void)startRequest
//{
//    getReq = [[PlaceOrderReq alloc]init];
//    [getReq setField:self.regNo forKey:@"productNo"];
//    getRespon = [[PlaceOrderRespon alloc]init];
//    [HttpCommunication request:getReq getResponse:getRespon Success:^(JuPlusResponse *response) {
//      //数据加载成功
//        [self fileData];
//    } failed:^(NSDictionary *errorDTO) {
//        [self errorExp:errorDTO];
//    } showProgressView:YES with:self.view];
//}
-(void)fileData
{
    
   // for(int i=0;i<[getRespon.productArr count];i++)
    for(int i=0;i<1;i++)
    {
        
        productView *pro = [[productView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _packageV.width, _packageV.height)];
        [pro.iconImgV setimageUrl:self.imgUrl placeholderImage:nil];
        [pro.titleL setText:self.name];
        [pro.priceL setText:[NSString stringWithFormat:@"¥%.2f",[self.price floatValue]]];
        [pro.countV setCountNum:1];
        
        //[pro loadData:[NSDictionary dictionary]];
        [_packageV addSubview:pro];
        [productArr addObject:pro];
    }

}
#pragma mark changePrice
-(void)resetTotalPrice
{
    productView *pro = [productArr lastObject];
    
    CGFloat total = [self.price floatValue]*[pro.countV getCountNum];
    [self.totalPriceL setText:[NSString stringWithFormat:@"总价：%.2f",total]];
}
#pragma mark --UI
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
        _packageV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(space, space+self.sectionTitleV.bottom, SCREEN_WIDTH - space*2, 100.0f)];
        
           }
    return _packageV;
}
//收货地址
-(JuPlusUIView *)receivedAddressV
{
    if(!_receivedAddressV)
    {
        _receivedAddressV =[[ReceiveMessageView alloc]initWithFrame:CGRectMake(0.0f, self.packageV.bottom+20.0f, SCREEN_WIDTH, 100.0f)];
        
    }
    return _receivedAddressV;
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
        [_postOrderBtn setBackgroundColor:Color_Basic];
        [_postOrderBtn setTitle:@"确认下单" forState:UIControlStateNormal];
        [_postOrderBtn.titleLabel setFont:FontType(16.0f)];
        [_postOrderBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_postOrderBtn addTarget:self action:@selector(postPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postOrderBtn;
}
//点击下单按钮弹出下单成功提示
-(void)postPressed:(UIButton *)sender
{
    postReq = [[PostOrderReq alloc]init];
    postRespon = [[PostOrderRespon alloc]init];
    [postReq setField:[CommonUtil getToken] forKey:TOKEN];
    //收货人信息
    [postReq setField:self.receivedAddressV.nameL.text forKey:@"receiverName"];
    [postReq setField:self.receivedAddressV.mobileL.text forKey:@"receiverMobile"];
    [postReq setField:self.receivedAddressV.addressL.text forKey:@"receiverAddress"];
    [postReq setField:[self getPostList] forKey:@"productList"];
    
    [HttpCommunication request:postReq getResponse:postRespon Success:^(JuPlusResponse *response) {
        [self showAlertView:@"订单提交成功" withTag:0];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
-(NSArray *)getPostList
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(int i=0;i<[productArr count];i++)
    {
        productView *pro = [productArr objectAtIndex:i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:self.regNo forKey:@"productNo"];
        [dict setObject:[NSString stringWithFormat:@"%d",[pro.countV getCountNum]] forKey:@"productNum"];
        [arr addObject:dict];
    }
    return arr;
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
