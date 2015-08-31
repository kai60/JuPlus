//
//  DesignerCell.m
//  JuPlus
//
//  Created by ios_admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerCell.h"
#import "DesignerDTO.h"
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
        [self.contentView addSubview:self.coverUrlImage];
        [self.coverUrlImage addSubview:self.simpleLabel];
        
        UIView *coverV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0, self.coverUrlImage.width, PICTURE_HEIGHT/2-2)];
        coverV.backgroundColor = RGBACOLOR(137, 83, 41, 0.2);
        [self.coverUrlImage addSubview:coverV];
        
           
                                                                                                                                                          }
    return self;
}

- (UIImageView *)coverUrlImage
{
    if (!_coverUrlImage) {
        _coverUrlImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICTURE_HEIGHT / 2 - 2)]; // 留出两个像素的白边
//        _image.image = [UIImage imageNamed:@"psb.png"];
//        [_coverUrlImage setBackgroundColor:Color_Basic];
    }
    return _coverUrlImage;
}
- (UILabel *)simpleLabel
{
    if (!_simpleLabel) {
        _simpleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5, 40, SCREEN_WIDTH*3/5, labelH)];
        _simpleLabel.textAlignment = NSTextAlignmentCenter;
        [_simpleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:FontMaxSize]];
//        _simpleLabel.font = FontType(FontMaxSize);
        _simpleLabel.numberOfLines = 0;
        _simpleLabel.textColor = Color_White;
        
    }
    return _simpleLabel;
}
- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        self.totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/5, PICTURE_HEIGHT/4, SCREEN_WIDTH/5, 20)];
        self.totalPriceLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.8);
        self.totalPriceLabel.textAlignment = NSTextAlignmentCenter;
        self.totalPriceLabel.textColor = Color_Basic;
        self.totalPriceLabel.font = FontType(FontSize);
        [self.coverUrlImage addSubview:self.totalPriceLabel];
    }
    return _totalPriceLabel;
}
- (void)fileData:(DesignerDTO *)dto
{
    [self.coverUrlImage setimageUrl:dto.coverUrl placeholderImage:nil];
    [self.simpleLabel setText:dto.simpleExplain];
    [self.totalPriceLabel setText:dto.totalPrice];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
