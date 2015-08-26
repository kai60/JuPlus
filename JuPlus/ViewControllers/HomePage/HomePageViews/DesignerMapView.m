//
//  DesignerMapView.m
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerMapView.h"
#import "JuPlusGetLocation.h"

@interface DesignerMapView()<MAMapViewDelegate>
{
    MAMapView *mapView;
}

@end


@implementation DesignerMapView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化地图key
        [MAMapServices sharedServices].apiKey = AMap_Key;
        [self initMapView];
    }
    return self;
}
-(void)initMapView
{
    mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    mapView.delegate = self;

       //开启定位
    mapView.showsUserLocation = YES;
    //mapView
    [self addSubview:mapView];
    
    [self performSelector:@selector(setMapRegin) withObject:nil];
}
//设置地图中心点
-(void)setMapRegin
{
    [[JuPlusGetLocation sharedInstance] getLocation];
    CLLocationCoordinate2D coordinate1=CLLocationCoordinate2DMake([JuPlusGetLocation sharedInstance].locLat, [JuPlusGetLocation sharedInstance].locLong);
    //缩放比例
    MACoordinateSpan span=MACoordinateSpanMake(0.05, 0.05);
    MACoordinateRegion region=MACoordinateRegionMake(coordinate1, span);
    
    [mapView setRegion:region animated:YES];
    

}
//当地图位置更新时候调用
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation) {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    } }
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
