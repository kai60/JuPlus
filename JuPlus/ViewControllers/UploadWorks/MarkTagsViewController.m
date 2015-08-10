//
//  MarkTagsViewController.m
//  JuPlus
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MarkTagsViewController.h"
#import "SearchTagsTab.h"
#import "LabelDTO.h"
#import "MarkLabeiView.h"
#import "UploadNotesViewController.h"
@interface MarkTagsViewController ()
{
    UIView *selectedView;
    
    CGPoint currentPoint;
}
@property (nonatomic,strong)UIImageView *topImgView;

@property (nonatomic,strong)UIButton *nextBtn;

@property (nonatomic,strong)JuPlusUIView *bottomView;
//标签筛选
@property (nonatomic,strong)SearchTagsTab *searchTab;
//添加的标签数组内容
@property (nonatomic,strong)NSMutableArray *tagsArray;
@end

@implementation MarkTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"添加标签";
    
    self.tagsArray = [[NSMutableArray alloc]init];
    
    [self.view addSubview:self.topImgView];
    
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.nextBtn];
    
    [self.topImgView setImage:self.postImage];
    //选择标签栏
    [self.view addSubview:self.searchTab];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileLabels:) name:AddLabels object:nil];
    
    // Do any additional setup after loading the view.
}
#pragma mark --labels相关
//添加标签
-(void)fileLabels:(NSNotification *)noti
{
    LabelDTO *dto = [noti object];
    CGFloat orignX = dto.locX;
    CGFloat orignY = dto.locY;
    CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(FontMaxSize)];
    orignY = MAX(dto.locY, 50.0f);
    
    MarkLabeiView *la;
    if(orignX<SCREEN_WIDTH - size.width -15.0f)
    {
        dto.direction = @"1";
        la = [[MarkLabeiView alloc]initWithFrame:CGRectMake(orignX, orignY-50.0f, size.width +15.0f, 50.0f) andDirect:dto.direction] ;

    }
        else
        {
        dto.direction = @"2";
        la = [[MarkLabeiView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY-50.0f, size.width +15.0f, 50.0f) andDirect:dto.direction];

        }
    la.infoDTO = dto;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesTap:)];
    [la addGestureRecognizer:gesTap];
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    [la addGestureRecognizer:tap];
    
    [la showText:dto.productName];
    
    [self.topImgView addSubview:la];

}
#pragma mark UItapGesture--
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    if (touch.view ==self.topImgView) {
        //判断标签是否超过3个
        if ([self.topImgView.subviews count]>=3) {
            [self showAlertView:@"标签添加不超过3个" withTag:0];
        }
        else
        {
        CGPoint currTouchPoint = [touch locationInView:self.topImgView];
        LabelDTO *dto = [[LabelDTO alloc]init];
        dto.locX = currTouchPoint.x;
        dto.locY = currTouchPoint.y;
        self.searchTab.infoDTO = dto;
        [UIView animateWithDuration:0.5 animations:^{
            [self.searchTab.searchBar setShowsCancelButton:YES animated:YES];
            [self.searchTab.searchBar becomeFirstResponder];
            self.searchTab.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        }
    }
}
//标签点击触发此事件(改变标签朝向)
-(void)gesTap:(UITapGestureRecognizer *)tap
{
    MarkLabeiView *tapView = (MarkLabeiView *)tap.view;
    CGRect frame = tapView.frame;
    if (tapView.isLeft) {
        //判断切换朝向之后，是否会触碰到边界
        if (frame.origin.x>=tapView.width) {
            [tapView setDirectionWithDire];
        }
    }else{
        if (tapView.right+tapView.width<=SCREEN_WIDTH) {
            [tapView setDirectionWithDire];
        }
    }
    
}
//长按有两个状态，开始触发和结束触发，都会调用此方法
-(void)longTap:(UILongPressGestureRecognizer *)tap
{
    //长按开始触发
    if(tap.state == UIGestureRecognizerStateBegan)
    {
    selectedView = tap.view;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要删除当前标签吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        if(buttonIndex==1)
        {
            [selectedView removeFromSuperview];
        }
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
#pragma mark --uifig
-(UIImageView *)topImgView
{
    if(!_topImgView)
    {
        _topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, nav_height, PICTURE_HEIGHT, PICTURE_HEIGHT)];
        _topImgView.userInteractionEnabled = YES;
    }
    return _topImgView;
}
-(UIButton *)nextBtn
{
    if(!_nextBtn)
    {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_nextBtn.titleLabel setFont:FontType(FontSize)];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:Color_Basic];
        _nextBtn.alpha = ALPHLA_BUTTON;
        [_nextBtn addTarget:self action:@selector(nextPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextBtn;
}

-(JuPlusUIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.topImgView.bottom, SCREEN_WIDTH, view_height - self.topImgView.bottom - TABBAR_HEIGHT)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(SearchTagsTab *)searchTab
{
    if(!_searchTab)
    {
        _searchTab = [[SearchTagsTab alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _searchTab;
}

#pragma fileData
//此时统计需要上传的位置信息以及标签内容
-(void)nextPress:(UIButton *)sender
{
    if (IsArrEmpty(self.topImgView.subviews)) {
        [self showAlertView:@"请至少添加一种标签" withTag:0];
    }
    else
    {
        [self getTagsArray];
        UploadNotesViewController *upload = [[UploadNotesViewController alloc]init];
        upload.dataArray = self.tagsArray;
        upload.postImage = self.postImage;
        [self.navigationController pushViewController:upload animated:YES];
    }
    //下一步
}
//得到上传标签的所有信息
-(void)getTagsArray
{
    [self.tagsArray removeAllObjects];
    for(UIView *view in self.topImgView.subviews)
    {
        if ([view isKindOfClass:[MarkLabeiView class]]) {
            MarkLabeiView *mark = (MarkLabeiView *)view;
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:[NSString stringWithFormat:@"%.2f",(mark.infoDTO.locX/SCREEN_WIDTH)*100] forKey:@"positionX"];
            [dic setObject:[NSString stringWithFormat:@"%.2f",(mark.infoDTO.locY/SCREEN_WIDTH)*100] forKey:@"positionY"];
            [dic setObject:mark.infoDTO.productName forKey:@"productName"];
            [dic setObject:mark.infoDTO.direction forKey:@"direction"];
            [self.tagsArray addObject:dic];
        }
    }
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
