//
//  LoginViewController.m
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "LoginViewController.h"
#import "JuPlusTextField.h"
@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text=@"登录";
    
    //加载UI
    [self loadBaseUI];
    
    self.registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn.frame=CGRectMake(20, 110, 80, 30);
    [self.registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [self.registerBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:14.0]];
    //[self.registerBtn setTitleColor:Upload_Gray_title forState:UIControlStateNormal];
    [self.view addSubview:self.registerBtn];
    [self.registerBtn addTarget:self action:@selector(regPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetBtn.frame=CGRectMake(220, 110, 80, 30);
    [self.forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:14.0]];
    //[self.forgetBtn setTitleColor:Upload_Gray_title forState:UIControlStateNormal];
    [self.view addSubview:self.forgetBtn];
    [self.forgetBtn addTarget:self action:@selector(passWordPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(10, 160, SCREEN_WIDTH-20, 44);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.tag=11;
    self.loginBtn.layer.cornerRadius=5.0;
    self.loginBtn.layer.masksToBounds=YES;
    //[self.loginBtn setBackgroundColor:Color_Green];
    [self.loginBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:18.0]];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(comPress:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark ---加载UI
-(NSMutableArray *)fieldArray
{
    if(!_fieldArray)
    {
        _fieldArray = [[NSMutableArray alloc]init];
    }
    return _fieldArray;
}
-(void)loadBaseUI
{
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(10, 10,SCREEN_WIDTH-20 , 90)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.masksToBounds=YES;
    backView.layer.cornerRadius=5;
    [self.view addSubview:backView];
    
    NSArray *array1=[NSArray arrayWithObjects:@"手机",@"密码", nil];
    NSArray *array2=[NSArray arrayWithObjects:@"请输入手机",@"请输入密码",nil];
    self.fieldArray=[[NSMutableArray alloc]initWithCapacity:array1.count];
    for (int i=0; i<array1.count; i++) {
        JuPlusTextField *rlView=[[JuPlusTextField alloc]initWithFrame:CGRectMake(0, i*45, SCREEN_WIDTH-20, 45)];
        rlView.contentField.tag=i;
        rlView.headTitleLa.text=[array1 objectAtIndex:i];
        rlView.contentField.placeholder=[array2 objectAtIndex:i];
        rlView.contentField.delegate=self;
        [backView addSubview:rlView];
        [self.fieldArray addObject:rlView.contentField];
        
        if (i==1) {
            
            rlView.contentField.secureTextEntry=YES;
            
        }
        else{
//            //账号
//            if ([CommonUtil getUserDefaultsValue:@"loginName"]!=nil) {
//                rlView.contentField.text=[CommonUtil getUserDefaultsValue:@"loginName"];
//            }
            rlView.contentField.keyboardType=UIKeyboardTypePhonePad;
        }
        
    }
    //画线
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 46, SCREEN_WIDTH-20, 1)];
    //lineView.backgroundColor=Upload_Gray_lines;
    [backView addSubview:lineView];
    
}

//忘记密码
-(void)passWordPress:(UIButton *)sender
{
    
}
//登录
-(void)comPress:(UIButton *)sender
{
    int count=2;
//    for(UITextField *obj in self.fieldArray)
//    {
//
//    }
    if (count==2){
        //获取加密时间
       // [self getServerTime];
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入手机号和密码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alt show];
    }
    
}
//注册
-(void)regPress:(UIButton *)sender
{
}

-(void)loginPost:(NSString*)serverTime
{
}

#pragma mark nextPress

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
//限制11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==0) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    return YES;
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
