//
//  OrderListCell.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListCell.h"
#import "OrderProductView.h"
@implementation OrderListCell
#define orignX 10.0f
#define labelH 30.0f
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self.contentView addSubview:self.orderNoL];
    [self.contentView addSubview:self.timeL];
    [self.contentView addSubview:self.productScroll];
}
-(JuPlusUILabel *)orderNoL
{
    if(!_orderNoL)
    {
        _orderNoL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(orignX, 0.0f, 150.0f, labelH)];
        [_orderNoL setTextColor:Color_Gray];
        [_orderNoL setFont:FontType(16.0f)];
    }
    return _orderNoL;
}

-(JuPlusUILabel *)timeL
{
    if(!_timeL)
    {
        _timeL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.orderNoL.right, 0.0f, 150.0f, labelH)];
        [_timeL setTextColor:Color_Gray];
        _timeL.textAlignment = NSTextAlignmentRight;
        [_timeL setFont:FontType(16.0f)];
    }
    return _timeL;
}
-(UIScrollView *)productScroll
{
    if(!_productScroll)
    {
        _productScroll = [[UIScrollView alloc]init];
    }
    return _productScroll;
}
-(UIButton *)moreBtn
{
    if(!_moreBtn)
    {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(orignX,labelH -1.0f,self.contentView.width - orignX , 1.0f)];
            [line setBackgroundColor:Color_Gray_lines];
            [_moreBtn addSubview:line];
        
        [_moreBtn.titleLabel setTextColor:Color_Gray_lines];
        [_moreBtn.titleLabel setFont:FontType(16.0f)];
    }
    return _moreBtn;
}
-(JuPlusUIView *)countView
{
    if(!_countView)
    {
        _countView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(orignX, self.moreBtn.bottom, self.contentView.width - orignX, 40.0f)];
    }
    return _countView;
}
-(JuPlusUILabel *)totalCountL
{
    if(!_totalCountL)
    {
        _totalCountL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(80.0f, orignX, 100.0f, 20.0f)];
        [_totalCountL setTextColor:Color_Black];
        [_totalCountL setFont:FontType(16.0f)];
    }
    return _totalCountL;
}
-(JuPlusUILabel *)totalPayL
{
    if(!_totalPayL)
    {
        _totalPayL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(200.0f, orignX, 140.0f, 20.0f)];
        [_totalPayL setTextColor:Color_Black];
        [_totalPayL setFont:FontType(16.0f)];
    }
    return _totalPayL;
}
//数据加载
-(void)fileCell:(OrderListRespon *)respon
{
    [self.orderNoL setText:[NSString stringWithFormat:@"订单号：%@",respon.orderNo]];
    [self.timeL setText:respon.orderTime];
    [self.totalCountL setText:[NSString stringWithFormat:@"共%d件商品",respon.totalCount]];
    [self.totalPayL setPriceText:respon.totalPrice];
    if(respon.totalCount<3)
    {
    
        
    }
    [self.productScroll removeAllSubviews];
}
-(void)layoutSubviews
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
