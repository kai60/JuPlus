//
//  RegisterViewController.h
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//注册界面

#import "BaseViewController.h"
#import "TimerButton.h"
#import "JuPlusTextField.h"
#import "KeyBoardTopBar.h"
@interface RegisterViewController : BaseViewController<UITextFieldDelegate,UIAlertViewDelegate,keyBoardTopBarDelegate>
{
    TimerButton *identifyButtom;
     KeyBoardTopBar *keyboardTopBar;
    //界面向上弹出的高度
    int movementDistance;
    
    UILabel *statusLabel;
    BOOL agree;

}

@end
