//
//  DGlobalManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DGlobalManager.h"


@interface DGlobalManager ()

@property (nonatomic, strong) NSMutableArray *arrManager;

@end

@implementation DGlobalManager

- (NSMutableArray *)arrManager{
    if (!_arrManager) {
        _arrManager = [NSMutableArray array];
    }
    return _arrManager;
}

- (void)addManager:(DBaseManager *)manager{
    if(![self.arrManager containsObject:manager]){
        [self.arrManager addObject:manager];
    }
}

- (void)removeManager:(DBaseManager *)manager{
    if([self.arrManager containsObject:manager]){
        [self.arrManager removeObject:manager];
    }
}

- (void)removeManagerByUserInfo:(NSDictionary *)userInfo{
    if(userInfo){
        NSString *viewName = @"";
        DicHasKeyAndDo(userInfo, KVIEWNAME, viewName = [userInfo objectForKey:KVIEWNAME];)
        if(viewName.length > 0){
            for (NSInteger i = self.arrManager.count - 1; i >= 0; i--) {
                DBaseManager *manager = [self.arrManager objectAtIndex:i];
                NSString *controllerViewName = @"";
                DicHasKeyAndDo(manager.info, KVIEWNAME, controllerViewName = [manager.info objectForKey:KVIEWNAME];)
                if([controllerViewName isEqualToString:viewName]){
                    [self.arrManager removeObject:manager];
                }
            }
        }
    }
}


@end
