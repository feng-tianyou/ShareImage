//
//  DServiceFactory.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBaseManager.h"


@interface DServiceFactory : NSObject

+ (id)getServiceByManager:(DBaseManager *)manager;

@end
