//
//  PackageViewController.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageViewController.h"
#import "InfoDisplayView.h"
#import "PackageReq.h"
#import "PackageRespon.h"
#import "PostFaverReq.h"
#import "DeleteFavReq.h"
#import "SingleDetialViewController.h"
#import "LabelDTO.h"
#import "LabelView.h"
#import "LoginViewController.h"
#import "PlaceOrderViewController.h"
#import "productOrderDTO.h"
#import "UINavigationController+RadialTransaction.h"
#import "DesignerDetailViewController.h"
@interface PackageViewController ()
#define space 10.0f
//购买
@property (nonatomic,strong)UIButton *placeOrderBtn;
//套餐详情
@property(nonatomic,strong)UIImageView *packageImageV;

@property (nonatomic,strong)UILabel *priceLabel;

@property (nonatomic,strong)UIButton *favBtn;
//可滑动的背景
@property (nonatomic,strong)UIScrollView *backScroll;

@property (nonatomic,strong)UIView *secBackScroll;
//设计师头像
@property (nonatomic,strong)UIButton *designIcon;
//设计师名称
@property (nonatomic,strong)UILabel *nameLabel;
//体验店
@property (nonatomic,strong)InfoDisplayView *addressView;
//简介
@property (nonatomic,strong)InfoDisplayView *displayView;
//套装下的单品介绍
@property (nonatomic,strong)JuPlusUIView *productListV;
//猜你喜欢
@property (nonatomic,strong)JuPlusUIView *relativedView;
//滚动层
@property (nonatomic,strong)UIScrollView *relativedScroll;
@end
@implementation PackageViewController
{
    PackageReq *req;
    PackageRespon *respon;
    CGFloat rectW1;
    CGFloat rectW2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"套餐介绍";
    rectW1 = (SCREEN_WIDTH - space*3)/2;
    rectW2 = (SCREEN_WIDTH - space*4)/3;

    [self.view addSubview:self.backScroll];
    [self.backScroll addSubview:self.packageImageV];
    [self.packageImageV addSubview:self.favBtn];
    [self.packageImageV addSubview:self.priceLabel];

    [self.backScroll addSubview:self.secBackScroll];
    [self.view addSubview:self.designIcon];
    [self.secBackScroll addSubview:self.nameLabel];
    [self.secBackScroll addSubview:self.addressView];
    [self.secBackScroll addSubview:self.displayView];
    [self.secBackScroll addSubview:self.productListV];
    [self.secBackScroll addSubview:self.relativedView];
    [self.relativedView addSubview:self.relativedScroll];
    [self.view addSubview:self.placeOrderBtn];
    // Do any additional setup after loading the view.
    //自定义转场动画
    [self.leftBtn setHidden:YES];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];

}
-(void)backPress:(UIButton *)sender
{
    if(self.isAnimation)
    {
    [self.packageImageV removeAllSubviews];

    CGRect newF = CGRectMake(self.popSize.origin.x,+ self.backScroll.contentOffset.y+self.popSize.origin.y-nav_height, self.popSize.size.width, self.popSize.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.secBackScroll.alpha = 0;
        self.designIcon.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView  animateWithDuration:1.0f animations:^{
            self.packageImageV.frame = newF;
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];

        }];
    }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --uifig
-(UIButton *)placeOrderBtn
{
    if(!_placeOrderBtn)
    {
        _placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeOrderBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_placeOrderBtn.titleLabel setFont:FontType(FontSize)];
        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeOrderBtn setTitle:@"全部单品购买" forState:UIControlStateNormal];
        [_placeOrderBtn setBackgroundColor:Color_Pink];
        _placeOrderBtn.alpha = ALPHLA_BUTTON;
        [_placeOrderBtn addTarget:self action:@selector(payPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}

-(UIImageView *)packageImageV
{
    if(!_packageImageV)
    {
        _packageImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [_packageImageV setimageUrl:self.imgUrl placeholderImage:nil];
        _packageImageV.userInteractionEnabled = YES;
    }
    return _packageImageV;
}
-(UIButton *)favBtn
{
    if(!_favBtn)
    {
        CGFloat btnR = 50.0f;
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favBtn setImage:[UIImage imageNamed:@"fav_unsel"] forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"fav_sel"] forState:UIControlStateSelected];
        _favBtn.frame = CGRectMake(self.packageImageV.width - btnR - 10.0f, 10.0f, btnR, btnR);
        [_favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _favBtn;
}
-(UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.packageImageV.height - 40.0f , 220.0f, 30.0f)];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.alpha = ALPHLA_BUTTON;
        [_priceLabel setFont:FontType(16.0f)];
        [_priceLabel setTextColor:Color_White];
    }
    return _priceLabel;
}
-(UIScrollView *)backScroll
{
    if(!_backScroll)
    {
        _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        _backScroll.delegate = self;
        _backScroll.showsVerticalScrollIndicator = NO;
    }
    return _backScroll;
}
-(UIView *)secBackScroll
{
    if(!_secBackScroll)
    {
        _secBackScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, PICTURE_HEIGHT, SCREEN_WIDTH, view_height)];
        _secBackScroll.backgroundColor = Color_White;
        _secBackScroll.alpha = 0;
    }
    return _secBackScroll;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(space, 0.0f, self.backScroll.width - space*2, 40.0f)];
        [_nameLabel setFont:FontType(FontSize)];
        [_nameLabel setTextColor:Color_Basic];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.nameLabel.height - 1.0f, _nameLabel.width, 1.0f)];
        v.backgroundColor = Color_Gray_lines;
        [_nameLabel addSubview:v];
    }
    return _nameLabel;
}
-(UIButton *)designIcon
{
    if(!_designIcon)
    {
        CGFloat imgW = 50.0f;
        _designIcon = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width - 60.0f,nav_height + PICTURE_HEIGHT -imgW/2, imgW, imgW)];
        _designIcon.layer.borderColor = [Color_White CGColor];
        _designIcon.layer.borderWidth = 1.0f;
        _designIcon.layer.cornerRadius = imgW/2;
        _designIcon.layer.masksToBounds =YES;
        _designIcon.alpha = 0;
        [_designIcon addTarget:self action:@selector(designerPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _designIcon;
}
-(InfoDisplayView *)addressView
{
    if(!_addressView)
    {
        _addressView = [[InfoDisplayView alloc]initWithFrame:CGRectMake(0.0f, self.nameLabel.bottom, self.backScroll.width, 70.0f)];
        _addressView.headerL.text = @"线下体验店";
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, _addressView.width, _addressView.height);
        [_addressView addSubview:btn];
    }
    return _addressView;
}
-(InfoDisplayView *)displayView
{
    if(!_displayView)
    {
        _displayView = [[InfoDisplayView alloc]initWithFrame:CGRectMake(0.0f, self.addressView.bottom, self.backScroll.width, 70.0f)];
        _displayView.headerL.text = @"简装介绍";
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, _addressView.width, _addressView.height);
    }
    return _displayView;
}
-(JuPlusUIView *)productListV
{
    if(!_productListV)
    {
        _productListV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.displayView.bottom+space, SCREEN_WIDTH, 100.0f)];
    }
    return _productListV;
}
-(JuPlusUIView *)relativedView
{
    if(!_relativedView)
    {
        _relativedView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.productListV.bottom, SCREEN_WIDTH, 140.0f)];
        _relativedView.autoresizingMask = YES;
       UILabel *title  = [[UILabel alloc]initWithFrame:CGRectMake(space, 0.0f, self.backScroll.width - space*2, 30.0f)];
        [title setText:@"猜你喜欢"];
        [title setFont:FontType(FontSize)];
        [title setTextColor:Color_Basic];
        title.textAlignment = NSTextAlignmentCenter;
        [_relativedView addSubview:title];
        
    }
    return _relativedView;

}
-(UIScrollView *)relativedScroll
{
    if(!_relativedScroll)
    {
        _relativedScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 30.0f, self.relativedView.width, 110.0f)];
        _relativedScroll.showsVerticalScrollIndicator = NO;
    }
    return _relativedScroll;
}
#pragma mark --frame reload
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}
#pragma mark --dataRequest
-(void)startRequest
{
    req = [[PackageReq alloc]init];
    [req setField:self.regNo forKey:@"collocateNo"];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    respon = [[PackageRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self fileData];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
#pragma mark --数据加载

-(void)fileData
{
    //是否收藏
    if([respon.isFav intValue]==1)
    {
        [self.favBtn setSelected:YES];
    }
    //价格
    [self.priceLabel setPriceTxt:respon.price];
    //底图
    [self.packageImageV setimageUrl:respon.imgUrl placeholderImage:nil];
    //加标签
    [self fileLabels];
    //设计师
    [self.nameLabel setText:[NSString stringWithFormat:@"设计师 %@",respon.designer]];
    [self.designIcon setimageUrl:respon.portraitUrl placeholderImage:nil];
    //地址
    [self.addressView.textL setText:respon.address];
    //简介
    [self fileContent:respon.content];
    
    if([respon.labelArray count]<=1)
    {
        self.productListV.frame = CGRectMake(0.0f,self.displayView.bottom , self.productListV.width, 0.0f);
    }
    else if ([respon.labelArray count]==2)
    {
        self.productListV.frame = CGRectMake(0.0f,self.displayView.bottom , self.productListV.width, rectW1+20.0f);
    }
    else if([respon.labelArray count]==3)
    {
        self.productListV.frame = CGRectMake(0.0f,self.displayView.bottom , self.productListV.width, rectW2+20.0f);
    }
    else
    {
        self.productListV.frame = CGRectMake(0.0f,self.displayView.bottom , self.productListV.width, rectW2+rectW1+30.0f);
    }
    //添加单品
    int count = [respon.labelArray count];
    if(count>1)
    {
        [self fileProductList:count];
    }
    //添加喜欢
    [self fileRelative];
    //重置frame
    [self layoutSubFrame];
    
    [self.view bringSubviewToFront:self.designIcon];
}
//添加标签
-(void)fileLabels
{
    for(int i=0;i<[respon.labelArray count];i++)
    {
        LabelDTO *dto = [respon.labelArray objectAtIndex:i];
        CGFloat orignX = (dto.locX/100)*self.packageImageV.width;
        CGFloat orignY = (dto.locY/100)*self.packageImageV.height - 50.0f;
        
        CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(12.0f)];
        LabelView *la;
        if ([dto.direction floatValue]==1) {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
        }
        else
        {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
            
        }
        
        la.tag = [dto.productNo intValue];
        [la showText:dto.productName];
        [self.packageImageV addSubview:la];
    }
    
}
//简介
-(void)fileContent:(NSString *)str
{
    //描述文字
    [self.displayView.textL setText:str];

    CGSize optimumSize = [self.displayView.textL optimumSize];
    
    CGRect frame = [self.displayView.textL frame];
    frame.size.height = (int)optimumSize.height+10; // +10 to fix height issue, this should be automatically fixed in iOS5
    [self.displayView.textL setFrame:frame];
    
}

//填充单品详情内容
-(void)fileProductList:(int)count
{
   
    for(int i=0;i<[respon.labelArray count];i++)
    {
        LabelDTO *dic = [respon.labelArray objectAtIndex:i];
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        if(count==2)
        {
            btn.frame = CGRectMake(space+(space+rectW1)*i, space, rectW1, rectW1);
        }
        else if(count==3)
        {
            btn.frame = CGRectMake(space+(space+rectW2)*i, space, rectW2, rectW2);
        }
        else
        {
            if(i<2)
                btn.frame = CGRectMake(space+(space+rectW1)*i, space, rectW1, rectW1);
            else
                btn.frame = CGRectMake(space+(space+rectW2)*(i-2), space*2+rectW1, rectW2, rectW2);
        }
        btn.tag = [dic.productNo intValue];
        [btn setimageUrl:dic.coverUrl placeholderImage:nil];
        [btn addTarget:self action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.productListV addSubview:btn];
    }
}
//猜你喜欢
-(void)fileRelative
{
    if([respon.packageList count]>0)
    {
        for (int i =0; i<[respon.packageList count]; i++) {
            CGFloat imgW = 90.0f;
            NSDictionary *relateDic = [respon.packageList objectAtIndex:i];
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.frame = CGRectMake(space+(space+imgW)*i, space, imgW, imgW);
            [imgBtn setBackgroundImage:[UIImage imageNamed:@"default_square"] forState:UIControlStateNormal];
            [imgBtn setimageUrl:[relateDic objectForKey:@"coverUrl"] placeholderImage:nil];
            [imgBtn setTitle:[relateDic objectForKey:@"coverUrl"] forState:UIControlStateNormal];
            [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            imgBtn.tag = [[relateDic objectForKey:@"collocatePicNo"] intValue];
            [imgBtn addTarget:self action:@selector(relativedClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.relativedScroll addSubview:imgBtn];
            self.relativedScroll.contentSize = CGSizeMake((space+imgW)*[respon.packageList count]+space*2, self.relativedScroll.height);
        }
    }
    else
    {
        self.relativedView.frame = CGRectMake(self.relativedView.left, self.productListV.bottom, self.relativedView.width, 0.0f);
    }
}
#pragma mark --scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==self.backScroll)
    {
        CGFloat orignY = scrollView.contentOffset.y;
        if(orignY>0)
           [self.view bringSubviewToFront:self.backScroll];
        else
            [self.view bringSubviewToFront:self.packageImageV];
        [self.view bringSubviewToFront:self.designIcon];
        [self.view bringSubviewToFront:self.placeOrderBtn];
        [self.view bringSubviewToFront:self.navView];
        CGFloat backY =  2*orignY/3;
        CGFloat iconY = nav_height+PICTURE_HEIGHT - 25.0f - orignY;
        if(iconY<nav_height)
            iconY = nav_height;
        self.designIcon.frame = CGRectMake(self.designIcon.left, iconY, self.designIcon.width, self.designIcon.height);
        
        self.packageImageV.frame = CGRectMake(self.packageImageV.left, backY, self.packageImageV.width, self.packageImageV.height);

    }
}
#pragma mark --buttonPress 
-(void)designerPress:(UIButton *)sender
{
    DesignerDetailViewController *design = [[DesignerDetailViewController alloc]init];
    [self.navigationController pushViewController:design animated:YES];
}
//收藏、取消收藏
-(void)favBtnClick:(UIButton *)sender
{
    if([CommonUtil isLogin])
    {
        if(sender.selected==YES)
        {
            [self cancelFav];
        }
        else
        {
            [self postFav];
        }
    }
    else
    {
        [self login];
    }
}
-(void)login
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}

//取消收藏
-(void)cancelFav
{
    DeleteFavReq *favReq = [[DeleteFavReq alloc]init];
    JuPlusResponse *favRespon =[[JuPlusResponse alloc]init];
    [favReq setField:[CommonUtil getToken] forKey:TOKEN];
    [favReq setField:self.regNo forKey:@"objNo"];
    [favReq setField:@"2" forKey:@"objType"];
    
    [HttpCommunication request:favReq getResponse:favRespon Success:^(JuPlusResponse *response) {
        [self.favBtn startAnimation];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
}
//添加收藏
-(void)postFav
{
    PostFaverReq *favReq = [[PostFaverReq alloc]init];
    [favReq setField:[CommonUtil getToken] forKey:TOKEN];
    [favReq setField:self.regNo forKey:@"objNo"];
    [favReq setField:@"2" forKey:@"objType"];
    
    JuPlusResponse *favRespon =[[JuPlusResponse alloc]init];
    [HttpCommunication request:favReq getResponse:favRespon Success:^(JuPlusResponse *response) {
        [self.favBtn startAnimation];
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}

//猜你喜欢相关点击事件
-(void)relativedClick:(UIButton *)sender
{
    //先给本界面加白色底层
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
    backV.backgroundColor = Color_White;
    [self.view addSubview:backV];
    //在白色底层上添加转场动画
    UIImageView *imageView = [[UIImageView alloc] initWithImage:sender.imageView.image];
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [sender convertRect:sender.frame toView:self.view];
    frameInSuperview.origin.x = sender.origin.x +self.relativedScroll.contentOffset.x;
    frameInSuperview.origin.y -=10.0f;
    imageView.frame = frameInSuperview;
    [backV addSubview:imageView];
    
    CGRect rect = imageView.frame;
    [UIView animateWithDuration:1.0f animations:^{
        imageView.frame = CGRectMake(0.0f, nav_height, PICTURE_HEIGHT, PICTURE_HEIGHT);
    } completion:^(BOOL finished) {
        PackageViewController *pack = [[PackageViewController alloc]init];
        pack.regNo = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        pack.popSize = rect;
        pack.imgUrl = sender.titleLabel.text;
        pack.isAnimation = YES;
        [self.navigationController pushViewController:pack animated:NO];
        [backV setHidden:YES];
        
    }];

   }
-(void)layoutSubFrame
{
    self.productListV.frame = CGRectMake(self.productListV.left, self.displayView.bottom+space, self.productListV.width, self.productListV.height);
    self.relativedView.frame = CGRectMake(self.relativedView.left, self.productListV.bottom, self.relativedView.width, self.relativedView.height);
    self.secBackScroll.frame = CGRectMake(self.secBackScroll.left, self.secBackScroll.top, self.secBackScroll.width,self.relativedView.bottom);
    self.backScroll.contentSize = CGSizeMake(self.backScroll.width, self.relativedView.bottom+PICTURE_HEIGHT+TABBAR_HEIGHT);
    [self.view bringSubviewToFront:self.packageImageV];
    
}
//单品详情点击事件
-(void)productClick:(UIButton *)sender
{

    CGPoint point2 = [sender convertPoint:sender.center toView:nil];
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
    backV.alpha = 0.99;
    backV.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
    [self.view addSubview:backV];
    [UIView animateWithDuration:1.0f animations:^{
        backV.alpha = 1;
    } completion:^(BOOL finished) {
        [backV removeFromSuperview];
    }];
    
    CGPoint startPoint = CGPointMake(sender.center.x-25.0f,point2.y-25.0f);
    SingleDetialViewController *sing = [[SingleDetialViewController alloc]init];
    sing.regNo = self.regNo;
    sing.isfromPackage = YES;
    sing.singleId =  [NSString stringWithFormat:@"%ld",(long)sender.tag];
    sing.point = startPoint;
    [self.navigationController radialPushViewController:sing withDuration:1.0f withStartFrame:CGRectMake(startPoint.x,startPoint.y,50.0f,50.0f) comlititionBlock:^{
        
    }];
    

   }
//购买
-(void)payPress
{
    if([CommonUtil isLogin])
    {
        PlaceOrderViewController *order = [[PlaceOrderViewController alloc]init];
        NSMutableArray *regArr = [[NSMutableArray alloc]init];
        for (int i=0; i<[respon.labelArray count]; i++) {
            productOrderDTO *singleDTO = [[productOrderDTO alloc]init];
            LabelDTO *dto = [respon.labelArray objectAtIndex:i];
            singleDTO.productNo = dto.productNo;
            singleDTO.regNo = self.regNo;
            singleDTO.imgUrl = dto.coverUrl;
            
            singleDTO.price = dto.price;
            singleDTO.productName = dto.productName;
            singleDTO.countNum = @"1";
            [regArr addObject:singleDTO];
        }
        order.regArray = regArr;
        [self.navigationController pushViewController:order animated:YES];
    }
    else
    {
        [self login];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.secBackScroll.alpha = 1;
        self.designIcon.alpha = 1;

    }];
}
-(void)viewWillDisppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.secBackScroll.alpha = 0;
//        self.designIcon.alpha = 0;
//
//    }];
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
