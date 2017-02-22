//
//  DNetworkFactory.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DNetworkFactory.h"

// network
#import "DUserNetwork.h"
#import "DPhotosNetwork.h"
#import "DCollectionsNetwork.h"

// service
#import "DUserService.h"
#import "DPhotosService.h"
#import "DCollectionsService.h"

@implementation DNetworkFactory

+ (id)getNetworkByService:(id)service{
    id network = nil;
    
    Class serviceClass = [service class];
    
    if([serviceClass isSubclassOfClass:[DUserService class]]){
        network = [DUserNetwork shareEngine];
    } else if ([serviceClass isSubclassOfClass:[DPhotosService class]]){
        network = [DPhotosNetwork shareEngine];
    } else if ([serviceClass isSubclassOfClass:[DCollectionsService class]]){
        network = [DCollectionsNetwork shareEngine];
    }
    
    if(!network){
        DLog(@"not define network for this service %@",serviceClass);
    }
    
    return network;
}

@end
