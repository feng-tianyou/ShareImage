//
//  DMapAnnotation.h
//  ShareImage
//
//  Created by FTY on 2017/4/14.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
