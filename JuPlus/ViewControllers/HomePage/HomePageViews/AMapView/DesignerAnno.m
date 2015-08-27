//
//  DesignerAnno.m
//  JuPlus
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerAnno.h"

@implementation DesignerAnno
//@synthesize myTitle,myCoordinate,myImagePath,myTag,gbType;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andImagePath:(NSString *)imagePath andType:(int)type;
{
    if(self = [super init])
    {

        self.myCoordinate = coordinate;
        self.portraitPath = imagePath;
        self.type = type;
        self.myCoordinate = coordinate;
        [self addSubview:self.backImg];
        [self.backImg addSubview:self.topImg];
    }
    return self;
}
-(UIImageView *)backImg
{
    if(!_backImg)
    {
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 40.0f)];
        if (self.type==1) {
            [_backImg setImage:[UIImage imageNamed:@"designer_map"]];

        }else
        [_backImg setImage:[UIImage imageNamed:@"collocation_map"]];

    }
    return _backImg;
}
-(UIImageView *)topImg
{
    if (!_topImg) {
        _topImg = [[UIImageView alloc]initWithFrame:CGRectMake(1.0f, 5.0f, self.backImg.width - 2.0f, self.backImg.height - 10.0f)];
        _topImg.layer.masksToBounds = YES;
        _topImg.layer.cornerRadius = _topImg.width/2;
    }
    return _topImg;
}
//coordinate不能直接赋值,需要使用第三方传传值，即_myCoordinate
-(CLLocationCoordinate2D )coordinate
{
    return _myCoordinate;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
