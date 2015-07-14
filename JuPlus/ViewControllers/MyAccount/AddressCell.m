//
//  AddressCell.m
//  JuPlus
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//地址管理

#import "AddressCell.h"

@interface AddressCell ()
{
    CGFloat labelH;
    CGFloat space;
}
@property(nonatomic,strong)JuPlusUIView *topView;
//收件人
@property(nonatomic,strong)JuPlusUILabel *nameL;
//联系方式
@property(nonatomic,strong)JuPlusUILabel *mobileL;
//地址
@property(nonatomic,strong)JuPlusUILabel *addressL;
//设为默认
@property(nonatomic,strong)UIButton *setDetaultBtn;
//
@property(nonatomic,strong)JuPlusUIView *botView;
@end

@implementation AddressCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        space = 10.0f;
        labelH = 30.0f;
    }
    return self;
}
-(JuPlusUIView *)topView
{
    if(!_topView)
    {
        _topView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.width, 10.0f)];
        [_topView setBackgroundColor:Color_Bottom];
    }
    return _topView;
}
-(JuPlusUIView *)botView
{
    if(!_botView)
    {
        _botView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.contentView.width, 40.0f)];
        [_botView setBackgroundColor:Color_Bottom];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(space,0.0f,self.contentView.width - space , 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_botView addSubview:line];
    }
    return _botView;
}

-(JuPlusUILabel *)nameL
{
    if(!_nameL)
    {
        _nameL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space, space, 80.0f, labelH)];
        [_nameL setFont:FontType(18.0f)];
        [_nameL setTextColor:Color_Black];
    }
    return _nameL;
}
-(JuPlusUILabel *)mobileL
{
    if(!_mobileL)
    {
        _mobileL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.nameL.right, space, 120.0f, labelH)];
        [_mobileL setFont:FontType(18.0f)];
        [_mobileL setTextColor:Color_Black];
    }
    return _mobileL;
}
-(JuPlusUILabel *)addressL
{
    if(!_addressL)
    {
        _addressL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space, self.mobileL.bottom, self.width - 110.0f, labelH)];
        [_addressL setFont:FontType(16.0f)];
        [_addressL setTextColor:Color_Gray];
    }
    return _addressL;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
