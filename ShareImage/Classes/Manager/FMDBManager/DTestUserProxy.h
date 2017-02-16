//
//  DTestUserProxy.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/20.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTestUserProxy : NSObject

- (BOOL)saveUser:(DUserModel *)userModel;

- (BOOL)updateUser:(DUserModel *)userModel;

- (BOOL)deleteUid:(long long)uid;

- (NSArray *)getAllUser;

- (DUserModel *)getUserWithUid:(long long)uid;

@end
