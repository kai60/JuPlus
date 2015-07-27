//
//  ImageSCrollViewController.m
//  JuPlus
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ZoomImageViewController.h"

@interface ZoomImageViewController ()

@end

@implementation ZoomImageViewController
{
    CGFloat _x;// 取得缩放图片的位置
    int _n; // scollview偏移量
    float _scale;// 缩放倍数
}
@synthesize imageDataArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"详细大图";
        
    }
    return self;
}

-(void)backPress:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   	[self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",imageDataArray);
    
    NSLog(@"输出尺寸 %f ,%f",self.view.frame.size.height,self.view.frame.size.width);
    
    //返回
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(0, 0, 52, 30);
    [button2 setImage:[UIImage imageNamed:@"back_n_g@2x.png"] forState:UIControlStateNormal];
    // [button2 setImage:[UIImage imageNamed:@"back_selected@2x.png"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem=barButton2;
    
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    
    //添加滚动视图
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*[imageDataArray count], PICTURE_HEIGHT);
    myScrollView.delegate=self;
    myScrollView.pagingEnabled=YES;
    myScrollView.backgroundColor = [UIColor blackColor];
    myScrollView.showsVerticalScrollIndicator=NO;
    myScrollView.showsHorizontalScrollIndicator=NO;
    //不让左弹右弹
    myScrollView.alwaysBounceHorizontal=NO;//
    myScrollView.alwaysBounceVertical=NO ;//
    
    
    
    
    for (int i=0; i<[imageDataArray count]; i++) {
        
        NSDictionary * dic=[imageDataArray objectAtIndex:i];
       UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [imgView setImage:[UIImage imageNamed:@"default_square"]];
        [imgView setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];
        imgView.userInteractionEnabled=YES;
        //给图片添加点击事件
        UITapGestureRecognizer *ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeImage:)];
        [imgView addGestureRecognizer:ges];
        
        
        UIScrollView *pinchScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, (SCREEN_HEIGHT-PICTURE_HEIGHT)/2, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [pinchScroll addSubview:imgView];
        pinchScroll.delegate=self;
        
        pinchScroll.maximumZoomScale=2.5;//放大倍数
        pinchScroll.minimumZoomScale=1;//缩小倍数
        [myScrollView addSubview:pinchScroll];
        
        
        _n = myScrollView.contentOffset.x/SCREEN_WIDTH;
        
        
    }
    [self.view addSubview:myScrollView];
    myScrollView.contentOffset =CGPointMake(SCREEN_WIDTH*self.tag, 0.0f);
    
}

-(void)changeImage:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  [scrollView.subviews objectAtIndex:0];
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if(scrollView!=myScrollView)
    {
        UIView *view = [scrollView.subviews objectAtIndex:0];
        
        NSLog(@"%.2f",self.view.center.y);
        CGFloat hight = view.frame.size.height;
        // 应该上移的高度
        CGFloat hight_1 = (SCREEN_HEIGHT-PICTURE_HEIGHT)/2-(hight-PICTURE_HEIGHT)/2;
        //[myScrollView setFrame:CGRectMake(0, hight_1, SCREEN_WIDTH, view.frame.size.height)];
        [scrollView setFrame:CGRectMake(scrollView.frame.origin.x, hight_1, SCREEN_WIDTH, view.frame.size.height)];
        
        scrollView.tag = 101;
        
        _x = myScrollView.contentOffset.x;
        
        NSLog(@"开始放大");
    }
}
// 取得放大倍数
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    _scale = scale;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == myScrollView)
    {
        _n = scrollView.contentOffset.x/scrollView.frame.size.width;
        CGFloat x_1 = scrollView.contentOffset.x-_x;
        if (x_1 == SCREEN_WIDTH ||x_1 == -SCREEN_WIDTH)
        {
            UIScrollView *view = (UIScrollView *)[self.view viewWithTag:101];
            float n = 1/_scale;
            [view setZoomScale:n];
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
