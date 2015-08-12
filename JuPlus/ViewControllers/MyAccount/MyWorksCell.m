//
//  MyWorksCell.m
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyWorksCell.h"

@implementation MyWorksCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        //  [self.contentView addSubview:self.backImage];
        
        self.back = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT/2)];
        [self.contentView addSubview:self.back];
        self.back.layer.masksToBounds = YES;
        [self.back addSubview:self.backImage];
        
        
        UIView *coverV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, PICTURE_HEIGHT/4, self.backImage.width, PICTURE_HEIGHT/2)];
        coverV.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [self.backImage addSubview:coverV];
        
        [self.backImage addSubview:self.dateLabel];
        
        [self.backImage addSubview:self.nameLabel];
        
        [self.contentView addSubview:self.bottomView];
        
        [self.bottomView addSubview:self.favBtn];
        
        [self.bottomView addSubview:self.payBtn];
        
        [self.bottomView addSubview:self.deleteBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.bottomView.bottom, self.contentView.width, 5.0f)];
        line.backgroundColor = Color_Gray_lines;
        [self.contentView addSubview:line];
    }
    return self;
}

-(UIImageView *)backImage
{
    if(!_backImage)
    {
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, -80.0f, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [_backImage setImage:[UIImage imageNamed:@"default_square"]];
        
    }
    return _backImage;
    
}
-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0.0f, (self.backImage.height - 30.0f)/2, self.contentView.width, 30.0f)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:FontType(FontSize)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textColor = Color_White;
    }
    return _nameLabel;
}

-(UILabel *)dateLabel
{
    if(!_dateLabel)
    {
        _dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(0.0f, PICTURE_HEIGHT/4+10.0f, 120.0f, 30.0f)];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        [_dateLabel setFont:FontType(FontSize)];
        _dateLabel.numberOfLines = 0;
        _dateLabel.backgroundColor = Color_Basic;
        _dateLabel.alpha = ALPHLA_BUTTON;
        _dateLabel.textColor = Color_White;
    }
    return _dateLabel;
}
-(JuPlusUIView*)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.back.bottom, self.width, 60.0f)];
        _bottomView.backgroundColor = Color_White;
    }
    return _bottomView;
}
-(UIButton *)deleteBtn
{
    if(!_deleteBtn)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(10.0f, 15.0f, 60.0f, 30.0f);
        [_deleteBtn setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
        [_deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_favBtn.imageView.image.size.width, 0.0, 0.0)];
    }
    return _deleteBtn;
}

-(UIButton *)favBtn
{
    if(!_favBtn)
    {
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _favBtn.frame = CGRectMake(180.0f, 15.0f, 60.0f, 30.0f);
        [_favBtn setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [_favBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
        [_favBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_favBtn.imageView.image.size.width, 0.0, 0.0)];
    }
    return _favBtn;
}
-(UIButton *)payBtn
{
    if(!_payBtn)
    {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(250.0f, 15.0f, 60.0f, 30.0f);
        [_payBtn setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [_payBtn setTitleColor:Color_Basic forState:UIControlStateNormal];
        [_payBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,_favBtn.imageView.image.size.width, 0.0, 0.0)];
    }
    return _payBtn;
}

-(void)fileData:(MyWorksDTO *)dto
{
    if (IsStrEmpty(dto.uploadTime)) {
        [self.dateLabel setHidden:YES];
    }else{
        [self.dateLabel setHidden:NO];
        CGSize size = [CommonUtil getLabelSizeWithString:dto.uploadTime andLabelHeight:self.dateLabel.height andFont:self.dateLabel.font];
        
        self.dateLabel.frame = CGRectMake(self.dateLabel.left, self.dateLabel.top, size.width + 10.0f, self.dateLabel.height);
        [self.dateLabel setText:dto.uploadTime];
    }
    [self.nameLabel setText:dto.status];
    [self.favBtn setTitle:dto.favCount forState:UIControlStateNormal];
    [self.payBtn setTitle:dto.payCount forState:UIControlStateNormal];

    [self.backImage setimageUrl:dto.coverUrl placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
