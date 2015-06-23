//
//  JuPlusTextField.m
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusTextField.h"
#import "JuPlusEnvironmentConfig.h"
@implementation JuPlusTextField
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    float y=frame.size.height;
    if (self)
    {
        self.userInteractionEnabled=YES;
        
        //标题
        _headTitleLa=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, y)];
        _headTitleLa.backgroundColor=[UIColor clearColor];
        _headTitleLa.textAlignment=NSTextAlignmentLeft;
        _headTitleLa.font= FontType(16.0f);
       // _headTitleLa.textColor=Upload_Gray_title;
        [self addSubview:_headTitleLa];
        
        //field
        _contentField=[[UITextField alloc]initWithFrame:CGRectMake(60, 2, 240, y)];
        [_contentField setBorderStyle:UITextBorderStyleNone];
        _contentField.secureTextEntry=NO;
    //  _contentField.textColor=Upload_Gray_title;
        _contentField.font=[UIFont fontWithName:FONTSTYLE size:16.0];
        _contentField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//自适应字体
        _contentField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        _contentField.delegate=self;
        _contentField.returnKeyType= UIReturnKeyDone;
        _contentField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self addSubview:_contentField];
        
        return self;
        
        
    }
    
    
    return self;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //键盘消失
    [textField resignFirstResponder];
    
    return YES;
}
//重载键盘弹出时的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //解决键盘不能输入问题
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
