//
//  MyFavourCell.m
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyFavourCell.h"

@implementation MyFavourCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
      //  [self.contentView addSubview:self.backImage];
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT/2)];
        [self.contentView addSubview:back];
        back.layer.masksToBounds = YES;
        [back addSubview:self.backImage];
        [self.backImage addSubview:self.nameLabel];

        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 160.0f , self.contentView.width, 2.0f)];
        line.backgroundColor = Color_White;
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
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0.0f, (self.backImage.height - 20.0f)/2, self.contentView.width, 20.0f)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [_nameLabel setFont:FontType(14.0f)];
        _nameLabel.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
        _nameLabel.textColor = Color_Basic;
    }
    return _nameLabel;
}
-(void)fileData:(MyFavourDTO *)dto
{
    CGSize size = [CommonUtil getLabelSizeWithString:dto.name andLabelHeight:self.nameLabel.height andFont:self.nameLabel.font];
    self.nameLabel.frame = CGRectMake((SCREEN_WIDTH - size.width-20.0f)/2, self.nameLabel.top, size.width+20.0f, self.nameLabel.height);
    [self.nameLabel setText:dto.name];
    
    [self.backImage setimageUrl:dto.coverUrl placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
