//
//  DMapViewController.h
//  ShareImage
//
//  Created by FTY on 2017/4/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"
#import <MapKit/MapKit.h>

@interface DMapViewController : DBaseViewController

- (instancetype)initWithAddress:(NSString *)address;
/// 纬度
@property (nonatomic, assign) CLLocationDegrees latitude;
/// 经度
@property (nonatomic, assign) CLLocationDegrees longitude;

@end
