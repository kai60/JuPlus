//
//  CollectionView.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CollectionView.h"
#import "HomePageInfoDTO.h"
#import "CollocationReq.h"
#import "CollectionRespon.h"
#import "PackageCell.h"
#import "PackageViewController.h"
#import "PackageCell.h"
@implementation CollectionView
{
    NSMutableArray *dataArray;
    CollocationReq *collReq;
    CollectionRespon *collRespon;
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter * footer;
    ScrollRefreshView *selectView;
    int pageNum;
    //数据总数
    int totalCount;

}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.masksToBounds = YES;
        dataArray = [[NSMutableArray alloc]init];
        [self addSubview:self.listTab];
        pageNum = 1;
        header = [ScrollRefreshViewHeader header];
        header.delegate = self;
        header.scrollView =  self.listTab;
        
        footer = [ScrollRefreshViewFooter footer];
        footer.delegate = self;
        footer.scrollView = self.listTab;
        
        self.listTab.tableHeaderView = self.headerView;
        
        [self.navView setHidden:NO];

        self.titleLabel.text = @"居+";
        [self.rightBtn setTitle:@"分类" forState:UIControlStateNormal];
        [self.rightBtn setHidden:NO];
        [self.navView addSubview:self.switchBtn];
       self.design = [[DesignerMapView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        //切换显示效果
        [self.switchBtn addTarget:self action:@selector(switchBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.design];
        [self.design setHidden:YES];
        
        [self startHomePageRequest];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFromClassify) name:ReloadList object:nil];
    }
    return self;
}

-(UIButton *)switchBtn
{
    if(!_switchBtn)
    {
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchBtn.frame = CGRectMake(self.navView.width - 54.0f- 44.0f, 20.0f, 44.0f, 44.0f);
        [_switchBtn setImage:[UIImage imageNamed:@"Icons_move_up"] forState:UIControlStateNormal];
        [_switchBtn setImage:[UIImage imageNamed:@"Icons_move_down"] forState:UIControlStateSelected];
    }
    return _switchBtn;
}

-(UITableView *)listTab
{
    if(!_listTab)
    {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, self.width, view_height) style:UITableViewStylePlain];
        _listTab.dataSource = self;
        _listTab.delegate = self;
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTab;
}
-(UIScrollView *)headerView
{
    if(!_headerView)
    {
        _headerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 120*(SCREEN_WIDTH/320.0f)+2.0f)];
    }
    return _headerView;
}
#pragma mark --refresh
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    selectView = refreshView;
    //下拉刷新
    if(refreshView.viewType == RefreshViewTypeHeader)
    {
        pageNum = 1;
        //下拉刷新则重载上拉加载更多选项
        [footer setState:RefreshStateNormal withAnimate:NO];
    }
    //上拉加载更多
    else
    {
       if([dataArray count]>=totalCount)
       {
           //显示无更多内容
           [refreshView setState:RefreshStateALL withAnimate:YES];
           return;
       }
        pageNum++;
    }
    [self startHomePageRequest];
}
#pragma mark --一键切换显示方式
//地图模式切换
-(void)switchBtnPress:(UIButton *)sender
{
    if (!self.isShowMap) {
        [self.design setHidden:NO];
        [self.listTab setHidden:YES];
        self.isShowMap = YES;
    }else{
        [self.design setHidden:YES];
        [self.listTab setHidden:NO];
        self.isShowMap = NO;
    }
    
}

#pragma mark --request
-(void)reloadFromClassify
{
    pageNum = 1;
    [self startHomePageRequest];
}
-(void)startHomePageRequest
{
    collReq = [[CollocationReq alloc]init];
    collRespon = [[CollectionRespon alloc]init];
    NSString *tagId = [CommonUtil getUserDefaultsValueWithKey:LabelTag];
    NSString *reqUrl = [NSString stringWithFormat:@"list?pageNum=%d&pageSize=%@&tagId=%@",pageNum,PAGESIZE,tagId?tagId:@"0"];
    [collReq setField:reqUrl forKey:@"FunctionName"];
    [HttpCommunication request:collReq getResponse:collRespon Success:^(JuPlusResponse *response) {
        for (int i=0; i<1; i++) {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.headerView.width, 0.0f, self.headerView.width, self.headerView.height - 2.0f)];
            [img setImage:[UIImage imageNamed:@"banner@3x.jpg"]];
            [self.headerView addSubview:img];
        }
        //添加分割线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _headerView.height - 2.0f, SCREEN_WIDTH, 2.0f)];
        self.headerView.contentSize = CGSizeMake(SCREEN_WIDTH*1, self.headerView.height);
        
        [line setBackgroundColor:Color_Gray];
        [_headerView addSubview:line];

        totalCount = [collRespon.count intValue];
        if (pageNum==1) {
            [self.listTab setContentOffset:CGPointMake(0.0f, 0.0f)];
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:collRespon.listArray];
        [self.listTab reloadData];
        [self stopReresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isShared) {
        return PICTURE_HEIGHT+2.0f;
    }
    else
    return PICTURE_HEIGHT+90.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"indexPath";
    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[PackageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomePageInfoDTO *homePage = [dataArray objectAtIndex:indexPath.row];
    [cell loadCellInfo:homePage withShow:self.isShared];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%ld",(long)indexPath.row);
    //先给本界面加白色底层
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
    backV.backgroundColor = Color_White;
    [self addSubview:backV];
    //在白色底层上添加转场动画
    PackageCell *cell = (PackageCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.showImgV.image];
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [cell.showImgV convertRect:cell.showImgV.frame toView:self];
    frameInSuperview.origin.y -= nav_height+25;
    imageView.frame = frameInSuperview;
    [backV addSubview:imageView];

    CGRect rect = imageView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        imageView.frame = CGRectMake(0.0f, nav_height, SCREEN_WIDTH, PICTURE_HEIGHT);
    } completion:^(BOOL finished) {
        PackageViewController *pack = [[PackageViewController alloc]init];
        HomePageInfoDTO *homePage = [dataArray objectAtIndex:indexPath.row];
        pack.regNo = homePage.regNo;
        pack.imgUrl = homePage.collectionPic;
        pack.popSize = rect;
        pack.isAnimation = YES;
        [[self getSuperViewController].navigationController pushViewController:pack animated:NO];
        [backV setHidden:YES];
        self.isPackage = YES;

    }];

}


@end
