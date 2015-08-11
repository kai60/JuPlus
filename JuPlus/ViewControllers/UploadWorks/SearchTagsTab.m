//
//  SearchTagsViewController.m
//  JuPlus
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SearchTagsTab.h"
#import "RelatedTagsReq.h"
#import "RelatedTagsRespon.h"
#import "UploadNotesViewController.h"
@interface SearchTagsTab ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UISearchBarDelegate>
{
    RelatedTagsReq *tagReq;
    
    RelatedTagsRespon *tagRespon;
}

@property (nonatomic,strong)     UITableView *searchResaultTab;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) JuPlusUIView *coverView;


@end

@implementation SearchTagsTab
@synthesize headView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.dataArray = [[NSMutableArray alloc]init];
        headView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, SCREEN_WIDTH, 40.0f)];
        headView.backgroundColor = [UIColor clearColor];
        [self addSubview:headView];
//        
//        UIImageView *addSearch = [[UIImageView alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 20.0f, 20.0f)];
//        [addSearch setImage:[UIImage imageNamed:@"search_add"]];
//        [headView addSubview:addSearch];
        
        [headView addSubview:self.searchBar];
        
        //[headView addSubview:self.clearBtn];
        
        //[headView addSubview:self.cancelBtn];
        
        UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0.0f,headView.height - 1.0f, self.width, 1.0f)];
        [top setBackgroundColor:Color_Gray_lines];
        [headView addSubview:top];
        
        [self addSubview:self.searchResaultTab];
        
        [self addSubview:self.coverView];
        
        [self.searchResaultTab reloadData];
    }
    return self;
}
#pragma request

//获得标签列表
-(void)startRequest
{
    tagReq = [[RelatedTagsReq alloc]init];
tagRespon = [[RelatedTagsRespon alloc]init];

    //[self.tagReq setField:self.searchBar.text forKey:@"searchKey"];
    [tagReq setField:[CommonUtil getToken] forKey:TOKEN];
    [HttpCommunication request:tagReq getResponse:tagRespon Success:^(JuPlusResponse *response) {
        self.dataArray = tagRespon.tagsArray;
        LabelDTO *dto = [[LabelDTO alloc]init];
        dto.productName = [NSString stringWithFormat:@"添加标签：%@",self.searchBar.text];
        [self.dataArray addObject:dto];
        [self.searchResaultTab reloadData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
}

#pragma mark - Initialization

- (UISearchBar *)searchBar
{
    if(!_searchBar)
    {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 40.0f)];
        _searchBar.delegate  = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder = @"搜索标签";
        _searchBar.returnKeyType = UIReturnKeySearch;
    }
    return _searchBar;
    
}


#pragma mark --uifig
-(UITableView *)searchResaultTab
{
    if(!_searchResaultTab)
    {
        _searchResaultTab=[[UITableView alloc]initWithFrame:CGRectMake(0,headView.bottom, SCREEN_WIDTH, self.height - headView.bottom)];
        _searchResaultTab.delegate=self;
        _searchResaultTab.dataSource=self;
        _searchResaultTab.separatorColor = Color_Gray_lines;
        _searchResaultTab.backgroundColor = [UIColor whiteColor];
    }
    return _searchResaultTab;
}
//-(UIButton *)cancelBtn
//{
//    if(!_cancelBtn)
//    {
//        
//        UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(self.searchBar.right+15.0f,5.0f, 1.0f, 30.0f)];
//        [middle setBackgroundColor:Color_Gray_lines];
//        [headView addSubview:middle];
//        
//        //完成 按钮
//        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        _cancelBtn.frame=CGRectMake(middle.right , 5.0f , headView.width - middle.right, 30.0f);
//        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancelBtn.titleLabel setFont:FontType(FontSize)];
//        [_cancelBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
//        [_cancelBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _cancelBtn;
//}
-(JuPlusUIView *)coverView
{
    if(!_coverView)
    {
        _coverView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, headView.bottom, SCREEN_WIDTH, view_height)];
        _coverView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        _coverView.userInteractionEnabled = YES;
        [_coverView setHidden:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesPress:)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}
#pragma mark - Life Cycle

-(void)tapgesPress:(UITapGestureRecognizer *)ges
{
    [self.searchBar resignFirstResponder];
}
#pragma mark - UISearchDisplayDelegate
//开始输入
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    [self.coverView setHidden:NO];
    [self.searchBar setShowsCancelButton:YES animated:YES];
    
}
//搜索框改变，则提交搜索内容，如果搜索出来的联想结果是空，添加此标签

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (IsStrEmpty(searchText)) {
        [self.coverView setHidden:NO];
    }
    else
    {
        [self.coverView setHidden:YES];
        [self startRequest];
    }
    

}
//
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.coverView setHidden:YES];
    [self backPress];
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]||[text isEqualToString:@" "])
    {
        //点击搜索，则按照搜索框内的内容重新加载数据源
        //界面向下收缩
        [searchBar resignFirstResponder];
        [self startRequest];
        return NO;
    }
    
    return YES;

}
-(void)backPress{
    [self.searchBar resignFirstResponder];
    [UIView animateWithDuration:ANIMATION animations:^{
        self.frame = CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

#pragma tableView fig
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tags";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tipCellIdentifier];
    }
    LabelDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dto.productName;
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LabelDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    
    //如果添加标签，则跳转到单品配置界面
    if ([dto.productName rangeOfString:@"添加标签："].location != NSNotFound) {
        self.infoDTO.productName = [dto.productName substringFromIndex:5];
        UploadNotesViewController *upload = [[UploadNotesViewController alloc]init];
        upload.infoDTO = self.infoDTO;
        [[self getSuperViewController].navigationController pushViewController:upload animated:YES];
    }
    else
    {
        self.infoDTO.productName = dto.productName;
        [CommonUtil postNotification:AddLabels Object:self.infoDTO];

    }
    
    [self backPress];
    
}
@end
