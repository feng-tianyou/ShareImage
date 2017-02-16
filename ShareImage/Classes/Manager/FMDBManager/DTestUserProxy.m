//
//  DTestUserProxy.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/20.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DTestUserProxy.h"
#import "DDataBaseProxy.h"

@interface DTestUserProxy ()
{
    DDataBaseProxy *_proxy;
    DUserModel *_model;
}
@end

@implementation DTestUserProxy


- (instancetype)init{
    self = [super init];
    if (self) {
        _proxy = [DDataBaseProxy share];
        BOOL isExistTable = [_proxy isExistInTableWithName:@"users"];
        if (!isExistTable) {
//            [_proxy executeCreatTableWithSql:[DDBSqlTool getSqlForCreateUsersTable]];
            
            [_proxy executeCreatTableWithSql:[DDBSqlTool getSqlForCreateUsersTableWithClassModel:[DUserModel class] tableName:@"users" transients:nil]];
            
        }
    }
    return self;
}

- (BOOL)saveUser:(DUserModel *)userModel{
    // model -> dic
    // 注意不要存储的字段、属性
    NSDictionary *dicModel = [userModel modelToJSONObject];
    NSDictionary *conditionDic = @{@"uid":[dicModel objectForKey:@"uid"]};
    
    // 先删除
    [_proxy executeDeleteWithTableName:@"users" conditionDic:conditionDic conditionSql:nil];
    
    // 再插入
    long long saveId = [_proxy executeInsertWithTableName:@"users" fieldAndValueDic:dicModel];
    
    return saveId;
}

- (BOOL)updateUser:(DUserModel *)userModel{
    return NO;
}

- (BOOL)deleteUid:(long long)uid{
    
    return [_proxy executeDeleteWithTableName:@"users" conditionDic:@{@"uid": @(uid)} conditionSql:nil];
}

- (NSArray *)getAllUser{
    NSMutableArray *resultArr = [NSMutableArray array];
    [_proxy executeSelectWithTableName:@"users" fieldArr:nil conditionDic:nil conditionAndOrderBySql:nil completedBlock:^(BOOL isSuccess, id result) {
        DLog(@"%@", result);
        if (isSuccess) {
            if ([result isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in result) {
                    DUserModel *model = [DUserModel modelWithJSON:dic];
                    [resultArr addObject:model];
                }
            }
        }
    }];
    return [resultArr copy];
}

- (DUserModel *)getUserWithUid:(long long)uid{
    __block DUserModel *model = nil;
    [_proxy executeSelectWithTableName:@"users" fieldArr:nil conditionDic:@{@"uid": @(uid)} conditionAndOrderBySql:nil completedBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            if ([result isKindOfClass:[NSArray class]]) {
                model = [DUserModel modelWithJSON:[result lastObject]];
            }
        }
    }];
    return model;
}

@end
