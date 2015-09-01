//
//  PersonCell.m
//  JuPlus
//
//  Created by ios_admin on 15/8/31.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PersonCell.h"
@interface PersonCell ()
{
    CGFloat labelH;
}
@end
@implementation PersonCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labelH = 30;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        self.contentView.backgroundColor = RGBACOLOR(235.0f, 235.0f, 235.0f, 1);
        [self.contentView addSubview:self.appointV];
        [self.appointV addSubview:self.appointLabel];
        [self.appointV addSubview:self.appImage];
        
    }
    return self;
}
- (UIView *)appointV
{
    if (!_appointV) {
        _appointV = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10, SCREEN_WIDTH-24, PICTURE_HEIGHT/4-8)];
        _appointV.backgroundColor = Color_White;
    }
    return _appointV;
}
- (UIImageView *)appImage
{
    if (!_appImage) {
        _appImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/12, self.appointV.height*2/7, 40, 40)];
    }
    return _appImage;
}
- (UILabel *)appointLabel
{
    if (!_appointLabel) {
        _appointLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, PICTURE_HEIGHT/12,SCREEN_WIDTH*2/5, labelH)];
        _appointLabel.textAlignment = NSTextAlignmentLeft;
        _appointLabel.numberOfLines = 0;
        _appointLabel.font = FontType(20);
        _appointLabel.tintColor = RGBACOLOR(251, 252, 254, 0.8);
    }
    return _appointLabel;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
