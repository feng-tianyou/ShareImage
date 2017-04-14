//
//  DMapViewController.m
//  ShareImage
//
//  Created by FTY on 2017/4/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMapViewController.h"
#import "DMapAnnotation.h"


@interface DMapViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, copy) NSString *address;
@end

@implementation DMapViewController

- (void)dealloc {
    switch (self.mapView.mapType) {
        case MKMapTypeHybrid:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case MKMapTypeStandard:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
    self.mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = NO;
    [_mapView.layer removeAllAnimations];
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeFromSuperview];
    _mapView.delegate = nil;
    _mapView = nil;
}

- (instancetype)initWithAddress:(NSString *)address{
    self = [super init];
    if (self) {
        self.address = [address copy];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = self.address;
    self.navLeftItemType = DNavigationItemTypeBack;
    
    [self.view addSubview:self.mapView];
    self.mapView.frame = self.view.bounds;
    
    DLog(@"%@", self.locationManager);
    
    //请求定位服务
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 设置大头针
    [self setAnnotation];
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private
- (void)setAnnotation{
    @weakify(self)
    [self.geocoder geocodeAddressString:self.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 取得第一个地表，地表存储了详细的地址信息，：注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        // 位置
        @strongify(self)
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D locationCoordinate = location.coordinate;
        DMapAnnotation *annotation = [[DMapAnnotation alloc] init];
        annotation.coordinate = locationCoordinate;
        annotation.title = self.address;
        [self.mapView addAnnotation:annotation];
        
        
        MKCoordinateRegion region;
        region.center = locationCoordinate;
        [self.mapView setRegion:region animated:YES];
        [self.mapView setSelectedAnnotations:@[annotation]];
    }];
}

#pragma mark - MKMapViewDelegate

/**
 调用非常频繁，不断监测用户的当前位置
 每次调用，都会把用户的最新位置（userLocation参数）传进来
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    DLog(@"%f  %f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
}
/**
 地图的显示区域即将发生改变的时候调用
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}

/**
 地图的显示区域已经发生改变的时候调用
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    [self.mapView removeFromSuperview];
    [self.view addSubview:mapView];
}

#pragma mark - setter * getter
- (MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        _mapView.mapType = MKMapTypeStandard;
    }
    return _mapView;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
