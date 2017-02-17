//
//  DServiceFactory.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DServiceFactory.h"

// service
#import "DUserService.h"
#import "DPhotosService.h"

// manager
#import "DUserAPIManager.h"
#import "DPhotosAPIManager.h"


@implementation DServiceFactory

+ (id)getServiceByManager:(DBaseManager *)manager{
    id service = nil;
    
    Class managerClass = [manager class];
    
    if([managerClass isSubclassOfClass:[DUserAPIManager class]]){
        service = [DUserService getServiceByInfo:manager.info];
    } else if ([managerClass isSubclassOfClass:[DPhotosAPIManager class]]){
        service = [DPhotosService getServiceByInfo:manager.info];
    }

    if(!service){
        DLog(@"not define service for this manager %@",managerClass);
    }
    
    return service;
}

@end
