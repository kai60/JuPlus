//
//  GuideViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "GuideViewController.h"
#import "JuPlusAppDelegate.h"
@interface GuideViewController()<UIScrollViewDelegate>

@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation GuideViewController
@synthesize pageControl;
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initGuide];
}

#pragma mark initGuide

-(void)initGuide
{
    UIScrollView *sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
    sv.delegate=self;
    sv.showsHorizontalScrollIndicator = NO;  //控制是否显示水平方向的滚动条
    sv.showsVerticalScrollIndicator = NO;     //是否显示垂直方向滚动条
    sv.bounces = NO;      //控制触到边缘是否反弹
    sv.alwaysBounceHorizontal = NO;   //触到垂直方向是否反弹
    sv.alwaysBounceVertical = NO;      //触到水平方向是否反弹
    sv.pagingEnabled = YES;               //控制翻动时是否整页翻动
    [self.view addSubview:sv];
    
    CGFloat pageControlHeight = 30.0f;
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT-30.0f, SCREEN_WIDTH, pageControlHeight)];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
    NSArray *guideArr1 = [NSArray arrayWithObjects:@"yd1@2x",@"yd2@2x",@"yd3@2x",@"yd4@2x", nil];
    NSArray *guideArr2 = [NSArray arrayWithObjects:@"yd1_5@2x",@"yd2_5@2x",@"yd3_5@2x",@"yd4_5@2x", nil];
    sv.contentSize=CGSizeMake(SCREEN_WIDTH*[guideArr1 count]+0.5, SCREEN_HEIGHT);
    pageControl.numberOfPages = [guideArr1 count];
    
    
    for(int i=0;i<[guideArr1 count];i++)
    {
        NSString *imageString;
        if(SCREEN_HEIGHT<500.0f)
        {
            imageString = [guideArr1 objectAtIndex:i];
        }
        else
        {
            imageString = [guideArr2 objectAtIndex:i];
            
        }
        UIImageView *guideImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageString]];
        guideImageView.frame = CGRectMake(SCREEN_WIDTH*i, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
        guideImageView.userInteractionEnabled=YES;
        [sv addSubview:guideImageView];
        
        
        if(i+1==[guideArr1 count])
        {
            CGFloat orignY;
            CGFloat btnHeight = 60.0f;
            CGFloat btnWidth  = 240.0f;
            if(SCREEN_HEIGHT>=500.0f)
            {
                orignY = 80.0f;
            }
            else
                orignY= 40.0f;
            guideImageView.userInteractionEnabled = YES;
            CGRect frame = CGRectMake((SCREEN_WIDTH-btnWidth)/2, SCREEN_HEIGHT-orignY-btnHeight, btnWidth, btnHeight);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = frame;

            [btn addTarget:self action:@selector(goMain) forControlEvents:UIControlEventTouchUpInside];
            [guideImageView addSubview:btn];

        }
    }
}
-(void)goMain
{
    JuPlusAppDelegate * appDelegate = (JuPlusAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate runNormalMethod];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.x>3*SCREEN_WIDTH) {
        [self goMain];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
}
@end
