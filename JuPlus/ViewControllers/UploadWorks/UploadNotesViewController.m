//
//  UploadNotesViewController.m
//  JuPlus
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UploadNotesViewController.h"
#import "InfoChangeV.h"
#import "ClassifyView.h"
#import "UMSocial.h"
@interface UploadNotesViewController ()<UITextViewDelegate,ClassifyViewDelegate,UITextFieldDelegate,UMSocialUIDelegate>

@property (nonatomic,strong)UIScrollView *backSCroll;
//输入内容
@property (nonatomic,strong)UITextView *detailView;
//字数限制
@property (nonatomic,strong)UILabel *countLabel;

@property (nonatomic,strong)UILabel *placeholderLabel;

@property (nonatomic,strong)InfoChangeV *clfyPickView;

@property (nonatomic,strong)UITextField *urlTextView;

@property (nonatomic,strong)UILabel *remindL;

@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)ClassifyView *classify;
@end

@implementation UploadNotesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"发布作品";
    
    [self.rightBtn setHidden:NO];
    [self.rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(sharePress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backSCroll];

    [self.backSCroll addSubview:self.detailView];
    [self.backSCroll addSubview:self.placeholderLabel];
    [self.backSCroll addSubview:self.countLabel];
    [self.backSCroll addSubview:self.clfyPickView];
    [self.backSCroll addSubview:self.urlTextView];
    [self.backSCroll addSubview:self.remindL];
    self.backSCroll.contentSize = CGSizeMake(self.backSCroll.width, self.remindL.bottom+TABBAR_HEIGHT);
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.classify];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    // Do any additional setup after loading the view from its nib.
}
-(void)sharePress:(UIButton *)sender
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UM_APPKey shareText:@"测试" shareImage:[UIImage imageNamed:@"Icon"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil] delegate:self];

}
#pragma mark --uifig
-(UIScrollView *)backSCroll
{
    if(!_backSCroll)
    {
        _backSCroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
    }
    return _backSCroll;
}
-(UITextView *)detailView
{
    if(!_detailView)
    {
        _detailView=[[UITextView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 300.0f,200.0f)];
        _detailView.delegate=self;
        _detailView.backgroundColor=[UIColor whiteColor];
        [_detailView setEditable:YES];
        _detailView.layer.borderColor= [Color_Gray_lines CGColor];
        _detailView.returnKeyType=UIReturnKeyDone;
        _detailView.layer.borderWidth=1;
        _detailView.layer.cornerRadius=5.0;
        _detailView.layer.masksToBounds=YES;
        _detailView.textColor= Color_Gray;
        _detailView.font=FontType(FontSize);
    }
        
    return _detailView;
}
-(UILabel *)countLabel
{
    if(!_countLabel)
    {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.detailView.right - 80.0f, 10.0f+self.detailView.bottom, 80.0f, 30.0f)];
        _countLabel.backgroundColor=[UIColor clearColor];
        _countLabel.font=FontType(FontSize);
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.textColor=Color_Gray;
        _countLabel.text=@"0/140字";

    }
    return _countLabel;
}
-(UILabel *)placeholderLabel
{
    if(!_placeholderLabel)
    {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 10.0f, 280.0f, 60.0f)];
        _placeholderLabel.backgroundColor=[UIColor clearColor];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font=FontType(FontSize);
        _placeholderLabel.textAlignment=NSTextAlignmentLeft;
        _placeholderLabel.textColor=Color_Gray;
        _placeholderLabel.text=@"请添加内容";
    }
    return _placeholderLabel;
}
-(InfoChangeV *)clfyPickView
{
    if(!_clfyPickView)
    {
        _clfyPickView = [[InfoChangeV alloc]initWithFrame:CGRectMake(0.0f, self.countLabel.bottom, self.backSCroll.width, 40.0f)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _clfyPickView.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_clfyPickView addSubview:line];
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _clfyPickView.height - 1.0f, _clfyPickView.width, 1.0f)];
        [line1 setBackgroundColor:Color_Gray_lines];
        [_clfyPickView addSubview:line1];
        _clfyPickView.titleL.text = @"选择分类";
        [_clfyPickView.botomV removeFromSuperview];
        [_clfyPickView.clickBtn addTarget:self action:@selector(rightBtnPress:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _clfyPickView;
}
-(UIButton *)sureBtn
{
    if(!_sureBtn)
    {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
        [_sureBtn setBackgroundColor:Color_Basic];
        _sureBtn.alpha = ALPHLA_BUTTON;
        [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font=FontType(FontMaxSize);
        [_sureBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sureBtn;
}
-(ClassifyView *)classify
{
    if(!_classify)
    {
        _classify = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) andView:self.sureBtn];
        _classify.delegate = self;
        _classify.backgroundColor = [UIColor whiteColor];
        [_classify setHidden:YES];
    }
    return _classify;
}
-(UITextField *)urlTextView
{
    if(!_urlTextView)
    {
        _urlTextView = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, self.clfyPickView.bottom, self.backSCroll.width - 20.0f, 40.0f)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10.0f, _urlTextView.height - 1.0f, _clfyPickView.width -20.0f, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        _urlTextView.delegate = self;
        [_urlTextView addSubview:line];
        [_urlTextView setFont:FontType(FontSize)];
        _urlTextView.placeholder = @"请输入购买地址或链接";

    }
    return _urlTextView;
}
-(UILabel *)remindL
{
    if(!_remindL)
    {
        
        _remindL = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, self.urlTextView.bottom+10.0f, self.backSCroll.width - 20.0f, 60.0f)];
        _remindL.numberOfLines = 0;
        [_remindL setFont:FontType(FontSize)];
        [_remindL setText:@"我们的工作人员将在2个工作日内联系你，如果物品可以出售，你将获得百分之十的返点"];
        [_remindL sizeToFit];
    }
    return _remindL;
}
#pragma mark --Click
//显示可选择的分类
-(void)rightBtnPress:(UIButton *)sender
{
    [self.classify showClassify];
}
-(void)reloadInfo:(ClassifyTagsDTO *)info
{
    [self.clfyPickView.textL setText:info.name];
    self.clfyPickView.tag = [info.tagId integerValue];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureBtnPress:(UIButton *)sender
{
    if(IsStrEmpty(self.detailView.text)||IsStrEmpty(self.urlTextView.text)||self.clfyPickView.tag==0)
    {
        [self showAlertView:@"请补充完整信息" withTag:0];
        return;
    }
    else if(self.detailView.text.length>140)
    {
        [self showAlertView:@"您输入的内容过长" withTag:0];
    }
    else
    {
        [self postData];
    }
}
//发送post表单，推送
-(void)postData
{
   
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{

}
#pragma mark --textField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:ANIMATION animations:^{
        CGRect frame = self.backSCroll.frame;
        frame.origin.y = -50.0f;
        self.backSCroll.frame = frame;
    }];
    

}
#pragma mark --textView
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:ANIMATION animations:^{
        CGRect frame = self.backSCroll.frame;
        frame.origin.y = nav_height;
        self.backSCroll.frame = frame;
    }];

}
//退出键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>0)
    {
        [self.placeholderLabel setHidden:YES];
    }
    else
        [self.placeholderLabel setHidden:NO];
    self.countLabel.text = [NSString stringWithFormat:@"%lu/140字",(unsigned long)textView.text.length];
    
}

#pragma mark --keyboard
-(void)keyboardWillShow:(NSNotification *)noti
{
//    NSDictionary *info = [noti userInfo];
//    CGFloat height = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    if ([self.urlTextView isFirstResponder]) {
        [UIView animateWithDuration:ANIMATION animations:^{
            CGRect frame = self.backSCroll.frame;
            frame.origin.y = -50.0f;
            self.backSCroll.frame = frame;
        }];
    }
    else
    {
        [UIView animateWithDuration:ANIMATION animations:^{
            CGRect frame = self.backSCroll.frame;
            frame.origin.y = nav_height;
            self.backSCroll.frame = frame;
        }];
    }
}
-(void)keyboardWillHidden:(NSNotification *)noti
{
    [UIView animateWithDuration:ANIMATION animations:^{
        CGRect frame = self.backSCroll.frame;
        frame.origin.y = nav_height;
        self.backSCroll.frame = frame;
    }];
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
