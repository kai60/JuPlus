//
//  DesignerMapView.m
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerMapView.h"
#import "JuPlusGetLocation.h"
#import "GetDesignerMapReq.h"
#import "GetDesignerRespon.h"
#import "MapDesignerDTO.h"
#import "MapCollocationDTO.h"
#import "DesignerDetailViewController.h"
#import "CollocationViewController.h"
@interface DesignerMapView()<MAMapViewDelegate>
{
    MAMapView *aMapView;
    NSInteger totalCount;
}
//地图撒点内容
@property (nonatomic,strong)NSMutableArray *dataArray;
@end


@implementation DesignerMapView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化地图key
        self.dataArray = [[NSMutableArray alloc]init];
        [self initMapView];
    }
    return self;
}
-(void)initMapView
{
    aMapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    aMapView.delegate = self;
    //开启定位
    aMapView.showsUserLocation = YES;
    //mapView
    [self addSubview:aMapView];
    
    [self performSelector:@selector(setMapRegin) withObject:nil];
    
    [self startRequest];
}
#pragma mark --request
-(void)startRequest
{
    GetDesignerMapReq * req = [[GetDesignerMapReq alloc]init];
    GetDesignerRespon *respon = [[GetDesignerRespon alloc]init];
  
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
       // totalCount = [respon.count intValue];
        //添加地图撒点
        [self loadTipsWithDesignerArray:respon.designerArray];
        [self loadTipsWithCollocationArray:respon.collocationArray];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
}
//加载效果图
-(void)loadTipsWithCollocationArray:(NSArray *)array
{
    if (!IsArrEmpty(array)) {
        for (MapDesignerDTO *obj in array) {
            DesignerAnno *anno = [[DesignerAnno alloc]initWithCoordinate:CLLocationCoordinate2DMake([obj.lat floatValue], [obj.lon floatValue])andImagePath:nil andType:2];
            anno.regNo = obj.regNo;
            [aMapView addAnnotation:anno];
        }
    }
    else{
       
    }

}
//加载设计师
-(void)loadTipsWithDesignerArray:(NSArray *)array
{
    if (!IsArrEmpty(array)) {
        for (MapDesignerDTO *obj in array) {
            DesignerAnno *anno = [[DesignerAnno alloc]initWithCoordinate:CLLocationCoordinate2DMake([obj.lat floatValue], [obj.lon floatValue]) andImagePath:obj.portraitImg andType:1];
            anno.regNo = obj.regNo;
            [aMapView addAnnotation:anno];
        }
    }
    else{
    }
}
//设置地图中心点
-(void)setMapRegin
{
    [[JuPlusGetLocation sharedInstance] getLocation];
    CLLocationCoordinate2D coordinate1=CLLocationCoordinate2DMake([JuPlusGetLocation sharedInstance].locLat, [JuPlusGetLocation sharedInstance].locLong);
    //缩放比例
    MACoordinateSpan span=MACoordinateSpanMake(0.05, 0.05);
    MACoordinateRegion region=MACoordinateRegionMake(coordinate1, span);
    
    [aMapView setRegion:region animated:YES];
    

}
//当地图位置更新时候调用（默认5秒一次）
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
#pragma mark --大头针相关
//打开并制作气泡
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
//点击大头针的点击事件
    
    //[self getSuperViewController].navigationController
}
//关闭气泡
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {

}
//自定义大头针或者气泡
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //static NSString *annotati = @"annotation";
    if ([annotation isKindOfClass:[DesignerAnno class]]) {
        // NSLog(@"JINLAI 制作大头针");
        DesignerAnno *anno=(DesignerAnno *)annotation;
        if (anno.type ==1) {
            [anno.topImg setimageUrl:anno.portraitPath placeholderImage:nil];
        }
        
        return anno;
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
