//
//  DesignerCell.m
//  JuPlus
//
//  Created by ios_admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerCell.h"
@interface DesignerCell ()
{
    CGFloat labelH;
}
@end
@implementation DesignerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        labelH = 30;
        CGRect frame = self.contentView.frame;
        frame.size.width = SCREEN_HEIGHT;
        [self.contentView addSubview:self.image];
        [self.image addSubview:self.label];
        
        UIView *coverV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0, self.image.width, PICTURE_HEIGHT/2-2)];
        coverV.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [self.image addSubview:coverV];
        
        UILabel *moneyV = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/5, PICTURE_HEIGHT/4, SCREEN_WIDTH/5, 20)];
        moneyV.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        moneyV.textAlignment = NSTextAlignmentCenter;
        moneyV.textColor = Color_Basic;
        moneyV.text = @"$2333";
        moneyV.font = FontType(FontSize);
        [self.image addSubview:moneyV];
        [moneyV addSubview:self.labelMoney];
        
    }
    return self;
}
- (UIImageView *)image
{
    if (!_image) {
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICTURE_HEIGHT / 2 - 2)]; // 留出两个像素的白边
//        _image.image = [UIImage imageNamed:@"psb.png"];
        [_image setBackgroundColor:Color_Basic];
    }
    return _image;
}
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, labelH)];
        _label.textAlignment = NSTextAlignmentCenter;
//        [_label setFont:FontType(FontMaxSize)];
        [_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontMaxSize]];
        _label.numberOfLines = 0;
        _label.textColor = Color_White;
        _label.text = @"这里会有一些标题之类的东西";
        
    }
    return _label;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
