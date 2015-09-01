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
        [self.contentView addSubview:self.appointImageUrl];
        [self.appointImageUrl addSubview:self.personHeadImage];
        
        [self.appointImageUrl addSubview:self.designerLabel];
        [self.appointImageUrl addSubview:self.appointLabel];
     
        
    }
    return self;
}
- (UIImageView *)appointImageUrl
{
    if (!_appointImageUrl) {
        _appointImageUrl = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-20, PICTURE_HEIGHT/2-8)];
        _appointImageUrl.image = [UIImage imageNamed:@"psb8.jpg"];
        UIView *vc = [[UIView alloc]init];
        
        vc.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [self.appointImageUrl addSubview:vc];
    }
    return _appointImageUrl;
}
- (UIImageView *)personHeadImage
{
    if (!_personHeadImage) {
        _personHeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3/7, PICTURE_HEIGHT/12, PICTURE_HEIGHT/7, PICTURE_HEIGHT/7)];
        _personHeadImage.image = [UIImage imageNamed:@"1.jpg"];
        _personHeadImage.layer.masksToBounds = YES;
        _personHeadImage.layer.cornerRadius= PICTURE_HEIGHT/14;
    }
    return _personHeadImage;
}
- (UIButton *)designerLabel
{
    if (!_designerBut) {
        _designerBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _designerBut.frame = CGRectMake((SCREEN_WIDTH/2)*3/4, PICTURE_HEIGHT/12+PICTURE_HEIGHT/7+8, SCREEN_WIDTH/4,labelH);
        _designerBut.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        [_designerBut setTitleColor:Color_Basic forState:UIControlStateNormal];
        [_designerBut setTitle:@"预约设计师" forState:UIControlStateNormal];
        _designerBut.titleLabel.font = FontType(FontMinSize);
    }
    return _designerBut;
}
- (UILabel *)appointLabel
{
    if (!_appointLabel) {
        _appointLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/5, PICTURE_HEIGHT/12+PICTURE_HEIGHT/7+labelH+14,SCREEN_WIDTH/5, labelH)];
        _appointLabel.textAlignment = NSTextAlignmentCenter;
        _appointLabel.numberOfLines = 0;
        _appointLabel.font = FontType(FontMinSize);
        _appointLabel.textColor = Color_Basic;
        _appointLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        _appointLabel.text = @"预约成功";
    }
    return _appointLabel;
}
- (void)fileData:(PersonDTO *)dto
{

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
