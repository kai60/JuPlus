//
//  RegisterViewController.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerificationReq.h"
#import "RegisterRespon.h"
#import "RegisterRequest.h"
@interface RegisterViewController ()
{
    UIScrollView *backView;
    //获取验证码
    VerificationReq *regisReq;
    //注册
    RegisterRequest *registerReq;
    RegisterRespon *registerRespon;
    //倒计时结束之后出现的view
    UIView *identifyView;
    NSMutableArray *fieldArray;
}

@end

@implementation RegisterViewController

-(void)remove
{
    statusLabel.hidden=YES;
}

//信息校验完毕，则提交请求
-(void)startRegist
{
     registerReq = [[RegisterRequest alloc] init];
    for(UITextField *obj in fieldArray)
    {
        if (obj.tag==0) {
            [registerReq setField:obj.text forKey:@"mobile"];
        }
        else if(obj.tag==1){
            [registerReq setField:obj.text forKey:@"msgCode"];
        }
        else if(obj.tag==2){
            [registerReq setField:obj.text forKey:@"nickname"];
        }
        else if(obj.tag==3){
            [registerReq setField:obj.text forKey:@"loginPwd"];
        }
        [obj resignFirstResponder];
    }
    registerRespon = [[RegisterRespon alloc]init];
    [HttpCommunication request:registerReq getResponse:registerRespon Success:^(JuPlusResponse *response) {
      //  <#code#>
    } failed:^(NSDictionary *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //加载UI
    [self loadBaseUI];
  
    UIButton *loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame=CGRectMake(30.0f, 400.0f, SCREEN_WIDTH-60.0f, 30);
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
        [loginButton setBackgroundColor:Color_Basic];
    [loginButton.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:16.0]];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:loginButton];
    [loginButton addTarget:self action:@selector(registerPress:) forControlEvents:UIControlEventTouchUpInside];
    
    //提醒兰
    statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(115, SCREEN_HEIGHT-100, 90, 20)];
    statusLabel.backgroundColor=[UIColor blackColor];
    statusLabel.text=@"验证码已发送";
    statusLabel.hidden=YES;
    statusLabel.textAlignment=NSTextAlignmentCenter;
    statusLabel.textColor=[UIColor whiteColor];
    statusLabel.font=[UIFont fontWithName:FONTSTYLE size:12.0];
    [self.view addSubview:statusLabel];
    
    //按钮上下跳转
    keyboardTopBar = [[KeyBoardTopBar alloc] initWithArray:fieldArray];
    [keyboardTopBar setAllowShowPreAndNext:YES];
    keyboardTopBar.delegate = self;

    
}
#pragma mark ---加载UI
-(void)loadBaseUI
{
    self.titleLabel.text=@"注册";
    [self.leftBtn setHidden:NO];
    self.viewBack.backgroundColor = [UIColor whiteColor];
    backView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0f,nav_height,SCREEN_WIDTH ,view_height)];
    backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backView];
    
    NSArray *array1=[NSArray arrayWithObjects:@"手机号",@"验证码",@"昵称",@"密码",@"确认密码", nil];
    fieldArray=[[NSMutableArray alloc]initWithCapacity:array1.count];
    for (int i=0; i<array1.count; i++) {
        JuPlusTextField *rlView=[[JuPlusTextField alloc]initWithFrame:CGRectMake(30.0f,160.0f+ i*45, SCREEN_WIDTH-60.0f, 45)];
        rlView.contentField.tag=i;
        rlView.headTitleLa.text=[array1 objectAtIndex:i];
        rlView.contentField.delegate=self;
        if(i==1)
        {
        rlView.contentField.frame = CGRectMake(75.0f, 0, rlView.width - 75.0f -100.0f, rlView.height);
        }
        else
        {
        rlView.contentField.frame = CGRectMake(75.0f, 0, rlView.width - 75.0f, rlView.height);
        }
        [backView addSubview:rlView];
        [fieldArray addObject:rlView.contentField];
        if (i==0) {
            rlView.contentField.keyboardType=UIKeyboardTypePhonePad;
        }
        if (i==1) {
            rlView.contentField.clearButtonMode=UITextFieldViewModeNever;
        }
        if (i==3){
            rlView.contentField.secureTextEntry=YES;
            rlView.contentField.placeholder=@"可包含数字、英文字母、下划线";
        }
        if (i==4) {
            rlView.contentField.placeholder=@"请确保两次输入内容一致";
        }
    }

    
    //验证码
    identifyButtom=[TimerButton buttonWithType:UIButtonTypeCustom];
    identifyButtom.frame=CGRectMake(208, 205, 100, 45.0f);
    [identifyButtom addTarget:self action:@selector(identifyPress:) forControlEvents:UIControlEventTouchUpInside];
   
    [identifyButtom.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:14.0]];
    [identifyButtom setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [identifyButtom setTitle:@"获取验证码" forState:UIControlStateNormal];
    [backView addSubview:identifyButtom];
}

#pragma mark----修改获得验证码状态
-(void)changeIdentify
{
//    [identifyButtom setHidden:YES];
//    [identifyView setHidden:NO];
}

#pragma mark buttonPress
//注册
-(void)registerPress:(UIButton *)sender
{
    NSString *passWordStr;
    NSString *passWordStr1;

        int count=5;
        for(UITextField *obj in fieldArray)
        {
            if ((obj.tag<5)&&IsStrEmpty(obj.text)) {
                count--;
            }
            else if(obj.tag==3){
                passWordStr=obj.text;
            }
            else if(obj.tag==4)
                passWordStr1 = obj.text;
            
        }
        if (count==5){
        
            //验证密码的完整性
            if (passWordStr.length<6||passWordStr.length>12) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码为6-12位（仅可使用大小写字母、数字、下划线）" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                count--;
            }
            else{
                if(![passWordStr isEqualToString:passWordStr1])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"两次密码输入不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    count--;
                }
                else
                {
                    //判断是否有非法字符
                    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"] invertedSet];
                    NSRange userNameRange = [passWordStr rangeOfCharacterFromSet:nameCharacters];
                    if (userNameRange.location != NSNotFound) {
                        //  NSLog(@"包含特殊字符");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码为6-12位（仅可使用大小写字母、数字、下划线）" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alert show];
                        count--;
                    }
                    
                    else{
                        //提交注册信息
                        [self startRegist];
                    }
                }
            }
        }
        else{
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请补充完整注册信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alt show];
        }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==10002) {
        if (buttonIndex==0) {
            //列表
          //  [self gotoRootCarListViewWithNsIndex:[NSIndexPath indexPathForRow:0 inSection:0]];
            
        }
        else{
         //   [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:CheckingFrom];
        //    CheckingViewController *checkView=[[CheckingViewController alloc]init];
          //  [self.navigationController pushViewController:checkView animated:YES];
            
        }
        
    }
    
}

//验证码
-(void)identifyPress:(UIButton *)sender
{
    //    验证电话号码是否正确
    int num=1;
    for(UITextField *obj in fieldArray)
    {
        if (obj.tag==0&&IsStrEmpty(obj.text)) {
            num--;
        }
        [obj resignFirstResponder];
    }
    if (num==0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag=10001;
        [alert show];
        
    }
    else
    {//号码合法
        
        regisReq = [[VerificationReq alloc]init];
        JuPlusResponse *response = [[JuPlusResponse alloc]init];
        [regisReq setField:((UITextField *)[fieldArray objectAtIndex:0]).text forKey:@"mobile"];
        [HttpCommunication request:regisReq getResponse:response Success:^(JuPlusResponse *response) {
            
        } failed:^(NSDictionary *er) {
            [self errorExp:er];
        } showProgressView:YES with:self.view];
 
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField.tag==2) {
        //判断是否有非法字符
        NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"] invertedSet];
        NSRange userNameRange = [textField.text rangeOfCharacterFromSet:nameCharacters];
        if (userNameRange.location != NSNotFound||textField.text.length>12) {
            // NSLog(@"包含特殊字符");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码为6-12位（仅可使用大小写字母、数字、下划线）" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
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
//重载键盘弹出时的方法,界面上弹的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //解决键盘不能输入问题
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
    //界面向上弹出
    [self animateTextField:textField withTag:textField.tag up:YES];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [keyboardTopBar ShowBar:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField withTag:textField.tag up:NO];
}

-(void)animateTextField:(UITextField *)textField withTag:(int)tag up:(BOOL)up
{
    if (self.view.frame.origin.y==0 &&up==NO) {
        //界面处于正常状态，界面不下弹
    }
    else
    {
        CGFloat upHeight = 50.0f;
        //界面向上弹出的高度
        if (tag==0) {
            movementDistance =60-upHeight;
        }
        if (tag==1) {
            movementDistance =105-upHeight;
        }
        if (tag==2) {
            movementDistance =150-upHeight;
        }
        if (tag==3) {
            movementDistance =195-upHeight;
        }
        if (tag==4) {
            movementDistance =240-upHeight;
        }
        
        const float movementDuration = 0.3f;
        int movement = (up?-movementDistance:movementDistance);
        [UIView beginAnimations:@"anim" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    
}
-(void)keyBoardTopBarConfirmClicked:(UITextField *)textField{
    
    [textField resignFirstResponder];
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
