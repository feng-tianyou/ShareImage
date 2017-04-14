//
//  DLocationTool.m
//  ShareImage
//
//  Created by FTY on 2017/4/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DLocationTool.h"
#import <CoreLocation/CoreLocation.h>

@interface DLocationTool ()<CLLocationManagerDelegate>
/// 定位
@property (nonatomic, strong) CLLocationManager *locationManager;
/// 地理编码
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation DLocationTool

- (void)userAuthLocation{
    
    // 用户手动授权
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 开始定位
    [self.locationManager startUpdatingLocation];
}





/**
 根据地名确定地理坐标

 @param address 地址
 */
- (void)getCoordinateByAddress:(NSString *)address{
    // 地理编码
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // 取得第一个地表，地表存储了详细的地址信息，：注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [placemarks firstObject];
        
        // 位置
        CLLocation *location = placemark.location;
        // 区域
        CLRegion *region = placemark.region;
        // 详细地址信息字典
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
//        NSString *name=placemark.name;//地名
//        NSString *thoroughfare=placemark.thoroughfare;//街道
//        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
//        NSString *locality=placemark.locality; // 城市
//        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
//        NSString *administrativeArea=placemark.administrativeArea; // 州
//        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
//        NSString *postalCode=placemark.postalCode; //邮编
//        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
//        NSString *country=placemark.country; //国家
//        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
//        NSString *ocean=placemark.ocean; // 海洋
//        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}


- (void)getAdressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    // 反编码
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
    }];
}




#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    // 获取用户位置额对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    DLog(@"经度：%f---维度：%f", coordinate.longitude, coordinate.latitude);
    // 停止定位
    [manager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}

#pragma mark - getter & setter
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
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
