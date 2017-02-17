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

// service
#import "DUserService.h"

@implementation DNetworkFactory

+ (id)getNetworkByService:(id)service{
    id network = nil;
    
    Class serviceClass = [service class];
    
    if([serviceClass isSubclassOfClass:[DUserService class]]){
        network = [DUserNetwork shareEngine];
    }
    
    if(!network){
        DLog(@"not define network for this service %@",serviceClass);
    }
    
    return network;
}

@end
