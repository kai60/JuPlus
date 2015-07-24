//
//  UILabel+JuPlusUILabel.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UILabel+JuPlusUILabel.h"

@implementation UILabel (JuPlusUILabel)
-(void)setPriceTxt:(NSString *)price
{
    NSString *str =[NSString stringWithFormat:@"¥%.2f",[price floatValue]];
    CGFloat width = [CommonUtil getLabelSizeWithString:str andLabelHeight:self.height andFont:self.font].width;
    self.frame = CGRectMake(0.0f, self.top, width+10.0f, self.height);
    [self setText:str];
    self.alpha = 0.8;
    self.backgroundColor = HEX_RGB(@"895329");
}
@end
