//
//  DesignerAnno.h
//  JuPlus
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface DesignerAnno : MAAnnotationView<MAAnnotation>

@property (nonatomic,strong)UIImageView *backImg;

@property (nonatomic,strong)UIImageView *topImg;
@property(nonatomic,assign)CLLocationCoordinate2D myCoordinate;
@property(nonatomic,strong)NSString *portraitPath;
@property(nonatomic,strong)NSString *regNo;
//是设计师还是套餐1、设计师2、套餐效果图
@property(nonatomic,assign)int type;
-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andImagePath:(NSString *)imagePath andType:(int)type;
@end
