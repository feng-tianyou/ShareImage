//
//  DMapViewController.m
//  ShareImage
//
//  Created by FTY on 2017/4/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMapViewController.h"
#import "DMapAnnotation.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define kMAP_APPLE_SCHEME           @"apple"
#define kMAP_GAODE_SCHEME           @"iosamap://"
#define kMAP_BAIDU_SCHEME           @"baidumap://"
#define kMAP_TENCENT_SCHEME         @"qqmap://"
#define kMAP_GOOGLE_SCHEME          @"comgooglemaps://"


@interface DMapViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;  //!< 要导航的坐标

@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSArray *mapTitles;
@end

@implementation DMapViewController

- (void)dealloc {
    
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
    if ([self isCanOpenOtherMap]) {
        self.navRighItemType = DNavigationItemTypeRightMenu;
    }
    
    //请求定位服务
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.view addSubview:self.mapView];
    self.mapView.frame = self.view.bounds;
    
    // 设置大头针
    [self setAnnotation];
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.mapTitles.count];
        [self.mapTitles enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [titles addObject:[[dic allValues] firstObject]];
        }];
        FSActionSheet *sheet = [[FSActionSheet alloc] initWithTitle:@"选择打开地图" delegate:nil cancelButtonTitle:@"取消" highlightedButtonTitle:nil otherButtonTitles:[titles copy]];
        @weakify(self)
        [sheet showWithSelectedCompletion:^(NSInteger selectedIndex) {
            @strongify(self)
            [self openOtherMapWithSelectIndex:selectedIndex];
        }];
    }
}

#pragma mark - Private
- (BOOL)isCanOpenOtherMap{
    // 判断是否安装高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_GAODE_SCHEME]]) return YES;
    
    // 判断是否安装百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_BAIDU_SCHEME]]) return YES;
    
    // 判断是否安装google地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_GOOGLE_SCHEME]]) return YES;
    
    return NO;
}

- (void)openOtherMapWithSelectIndex:(NSInteger)selectedIndex{
    NSDictionary *mapDic = self.mapTitles[selectedIndex];
    __block NSString *mapStr = [[mapDic allKeys] firstObject];
    [self.mapTitles enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = [[dic allKeys] firstObject];
        if ([title isEqualToString:mapStr]) {
            if ([mapStr isEqualToString:kMAP_APPLE_SCHEME]) {
                MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
                NSArray *items = @[currentLoc,toLocation];
                NSDictionary *dic = @{
                                      MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                                      MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                                      MKLaunchOptionsShowsTrafficKey : @(YES)
                                      };
                
                [MKMapItem openMapsWithItems:items launchOptions:dic];
                return ;
            } else if ([mapStr isEqualToString:kMAP_GAODE_SCHEME]) {
                mapStr = [[NSString stringWithFormat:@"iosamap://marker?position=%f,%f&name=%@&src=mypage&coordinate=gaode&callnative=0",self.coordinate.latitude,self.coordinate.longitude, self.address]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else if ([mapStr isEqualToString:kMAP_BAIDU_SCHEME]) {
                mapStr = [[NSString stringWithFormat:@"baidumap://map/geocoder?address=%@", self.address] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else if ([mapStr isEqualToString:kMAP_TENCENT_SCHEME]) {
                mapStr = [[NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=%f,%f&coord_type=1&policy=0",self.coordinate.latitude, self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            } else if ([mapStr isEqualToString:kMAP_GOOGLE_SCHEME]) {
                mapStr = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"",@"",self.coordinate.latitude, self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mapStr]];
        }
    }];
}

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
    if (address.length == 0) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMaximumDismissTimeInterval:2.0];
        [SVProgressHUD showErrorWithStatus:@"你的地址未能定位到！"];
        return;
    }
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    @weakify(self)
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 取得第一个地表，地表存储了详细的地址信息，：注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        if (!placemark && error) {
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD setMaximumDismissTimeInterval:2.0];
            [SVProgressHUD showErrorWithStatus:@"你的地址未能定位到！"];
            return;
        }
        
        // 位置
        @strongify(self)
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D locationCoordinate = location.coordinate;
        
        self.coordinate = locationCoordinate;
        DLog(@"address:%f,%f", locationCoordinate.latitude, locationCoordinate.longitude);
        DMapAnnotation *annotation = [[DMapAnnotation alloc] init];
        annotation.coordinate = locationCoordinate;
        annotation.title = self.address;
        annotation.image = [UIImage getImageWithName:@"customer_location_icon"];
        [self.mapView addAnnotation:annotation];
        
        MKCoordinateSpan span = self.mapView.region.span;
        span.latitudeDelta = span.latitudeDelta/6.0;
        span.longitudeDelta = span.longitudeDelta/6.0;
        MKCoordinateRegion region = MKCoordinateRegionMake(locationCoordinate, span);
        
        [self.mapView setRegion:region animated:YES];
        [self.mapView setSelectedAnnotations:@[annotation]];
    }];
}

#pragma mark - MKMapViewDelegate

/// 显示大头针时调用，注意方法中的annotation参数是即将显示的大头针对象
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    // 由于当前位置的标注也是一个大头针，所以需要判断，返回nil的时候使用系统的大头针
    if ([annotation isKindOfClass:[DMapAnnotation class]]) {
        static NSString *key = @"AnnotationKey";
        MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:key];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
            annotationView.canShowCallout = YES;
        }
        // 修改大头针视图
        // 重新设置此类大头针视图的大头针模型（因为有可能草丛缓存吃中取出；哎的）
        annotationView.annotation = annotation;
        //设置大头针视图的图片
        DMapAnnotation *anno = (DMapAnnotation *)annotation;
        annotationView.image = anno.image;
        return annotationView;
    } else {
        return [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@""];
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

- (NSArray *)mapTitles{
    if (!_mapTitles) {
        NSMutableArray *titles = [NSMutableArray array];
        
        [titles addObject:@{kMAP_APPLE_SCHEME:@"苹果地图"}];
        
        // 判断是否安装高德地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_GAODE_SCHEME]]) {
            [titles addObject:@{kMAP_GAODE_SCHEME:@"高德地图"}];
        }
        
        // 判断是否安装百度地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_BAIDU_SCHEME]]) {
            [titles addObject:@{kMAP_BAIDU_SCHEME:@"百度地图"}];
        }
        
        // 判断是否安装腾讯地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_TENCENT_SCHEME]]) {
            [titles addObject:@{kMAP_TENCENT_SCHEME:@"腾讯地图"}];
        }
        
        // 判断是否安装google地图
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kMAP_GOOGLE_SCHEME]]) {
            [titles addObject:@{kMAP_GOOGLE_SCHEME:@"谷歌地图"}];
        }
        _mapTitles = [titles copy];
    }
    return _mapTitles;
}

@end
