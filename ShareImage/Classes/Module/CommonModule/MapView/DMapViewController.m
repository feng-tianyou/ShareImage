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
    self.locationManager = nil;
    self.geocoder = nil;
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
    NSString *address = self.address;
    NSArray *arrKey = @[@",", @"/", @"，", @"("];
    __block NSRange range = NSMakeRange(0, 0);
    [arrKey enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        range = [self.address rangeOfString:key];
        if (range.length > 0) *stop = YES;
    }];
    if (range.length > 0) {
        address = [self.address substringWithRange:NSMakeRange(0, range.location)];
    }
    
    @weakify(self)
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 取得第一个地表，地表存储了详细的地址信息，：注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        if (!placemark) return ;
        
        // 位置
        @strongify(self)
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D locationCoordinate = location.coordinate;
        DMapAnnotation *annotation = [[DMapAnnotation alloc] init];
        annotation.coordinate = locationCoordinate;
        annotation.title = self.address;
        annotation.image = [UIImage getImageWithName:@"address_big_icon"];
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

/// 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // 由于当前位置的标注也是一个大头针，所以需要判断，返回nil的时候使用系统的大头针
    if ([annotation isKindOfClass:[DMapAnnotation class]]) {
        static NSString *key = @"AnnotationKey";
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:key];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
            //允许交互点击
            annotationView.canShowCallout = YES;
            //annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            //annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_classify_cafe.png"]];//定义详情左侧视图
        }
        // 修改大头针视图
        // 重新设置此类大头针视图的大头针模型（因为有可能草丛缓存吃中取出；哎的）
        annotationView.annotation = annotation;
        //设置大头针视图的图片
        DMapAnnotation *anno = (DMapAnnotation *)annotation;
        annotationView.image = anno.image;
        return annotationView;
    } else {
        return nil;
    }
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
