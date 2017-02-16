//
//  DDataBaseProxy.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/19.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DDataBaseProxy.h"
#import <FMDB/FMDB.h>
#import "DSandboxTool.h"


@interface DDataBaseProxy ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@property (nonatomic, strong) NSString *dbBasePath; // 用户的数据库路径
@end

@implementation DDataBaseProxy

#pragma mark - 单例
+ (instancetype)share{
    static DDataBaseProxy *proxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        proxy = [[DDataBaseProxy alloc] init];
    });
    return proxy;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        // 创建文件夹
        [DSandboxTool createDirectoryAtPath:self.dbBasePath];
    }
    return self;
}

#pragma mark - get & set
- (NSString *)dbBasePath{
    if (!_dbBasePath) {
        _dbBasePath = [NSString stringWithFormat:@"%@/%@", [DSandboxTool docPath], kDB_LAST_PATH];
    }
    return _dbBasePath;
}

- (FMDatabaseQueue *)dbQueue{
    if (!_dbQueue) {
        // 用户表路径
        NSString *dbPath = [self.dbBasePath stringByAppendingPathComponent:[NSString stringWithFormat:@"DF%@.db", @(KGLOBALINFOMANAGER.uid)]];
        DLog(@"user_db_path:%@", dbPath);
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return _dbQueue;
}

#pragma mark - 私有方法

/**
 执行SQL语句

 @param sql SQL语句
 @param completedBlock 回调
 */
- (void)executeSql:(NSString *)sql completedBlock:(completedBlock)completedBlock{
    
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        db.logsErrors = YES;
        BOOL isSuccess = NO;
        __block id resultObjc = nil;
        @try {
            isSuccess = [db executeUpdate:sql];
            resultObjc = @([db lastInsertRowId]);
        } @catch (NSException *exception) {
             DLog(@"%@",exception);
            *rollback = YES;
            isSuccess = NO;
        } @finally {
            
        }
        if (!isSuccess) {
            DLog(@"sqlite work fail : %@ ", sql);
        }
        if (completedBlock) {
            completedBlock(isSuccess, resultObjc);
        }
    }];
}

#pragma mark - 暴露方法

#pragma mark - 创建表格

/**
 判断表格是否存在
 
 @param tableName 表名
 @return
 */
- (BOOL)isExistInTableWithName:(NSString *)tableName{
    if (tableName.length == 0) return NO;
    // 创建用户表格表格
    __block BOOL success = NO;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        success = [db tableExists:tableName];
    }];
    return success;
}

/**
 创建表格(可在DDBSqlTool获取或者定制)
 
 @param sql SQL语句
 @return 是否创建成功
 */
- (BOOL)executeCreatTableWithSql:(NSString *)sql{
    if (sql.length == 0) return NO;

    // 创建用户表格表格
    __block BOOL success = NO;
    [self executeSql:sql completedBlock:^(BOOL isSuccess, id result) {
        success = isSuccess;
    }];
    return success;
}

#pragma mark - 释放内存
/**
 释放内存
 */
- (void)clearAllStorage{
    self.dbQueue = nil;
}

#pragma mark - 查询
/**
 查询
 
 @param sql SQL语句
 @param completedBlock 回调
 */
- (void)executeQueryWithSql:(NSString *)sql completedBlock:(completedBlock)completedBlock{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        db.logsErrors = YES;
        BOOL isSuccess = NO;
        __block id resultObjc = nil;
        @try {
            FMResultSet *resultSet = [db executeQuery:sql];
            NSMutableArray *resultArr = [NSMutableArray array];
            while ([resultSet next]) {
                // 记录
                NSMutableDictionary *record = [NSMutableDictionary dictionary];
                for (int i = 0; i<[resultSet columnCount]; i++) {
                    NSString *key = [resultSet columnNameForIndex:i];
                    id value = [resultSet objectForColumnName:key];
                    [record setObject:value forKey:key];
                }
                [resultArr addObject:record];
            }
            resultObjc = resultArr;
            isSuccess = YES;
        } @catch (NSException *exception) {
            DLog(@"%@",exception);
            *rollback = YES;
            isSuccess = NO;
        } @finally {
            
        }
        if (!isSuccess) {
             DLog(@"sqlite work fail : %@ ", sql);
        }
        if (completedBlock) {
            completedBlock(isSuccess, resultObjc);
        }
    }];
}

/**
 条件查询
 
 @param tableName 表名
 @param fieldArr 查询字段集合
 @param conditionDic 查询条件
 @param conditionAndOrderBySql and order 附加查询条件语句
 @param completedBlock 回调
 */
- (void)executeSelectWithTableName:(NSString *)tableName
                          fieldArr:(NSArray *)fieldArr
                      conditionDic:(NSDictionary *)conditionDic
            conditionAndOrderBySql:(NSString *)conditionAndOrderBySql
                    completedBlock:(completedBlock)completedBlock{
    // 生成SQL语句
    NSString *sql = [DDBSqlTool createSelectSQLWithTableName:tableName fieldArr:fieldArr conditionDic:conditionDic conditionAndOrderBySql:conditionAndOrderBySql];
    // 执行
    [self executeQueryWithSql:sql completedBlock:completedBlock];
}


/**
 查询某个表的总条数
 
 @param tableName 表名
 @param conditionSql 条件语句
 @return 总数
 */
- (NSInteger)executeGetCountWithTableName:(NSString *)tableName
                             conditionSql:(NSString *)conditionSql{
    
    // SQL语句
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ ", tableName];
    if (conditionSql.length > 0) {
        sql = [NSString stringWithFormat:@"%@%@", sql, conditionSql];
    }
    __block NSInteger totalCount = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        db.logsErrors = YES;
        BOOL isSuccess = NO;
        @try {
            FMResultSet *resultSet = [db executeQuery:sql];
            while ([resultSet next]) {
                totalCount = [resultSet intForColumnIndex:0];
            }
            isSuccess = YES;
        } @catch (NSException *exception) {
            DLog(@"%@",exception);
            *rollback = YES;
            isSuccess = NO;
        } @finally {
            
        }
        if (!isSuccess) {
            DLog(@"sqlite work fail : %@ ", sql);
        }
    }];
    return totalCount;
}

/**
 根据字段查询最小的id条数
 
 @param tableName 表名
 @param field 根据查询的字段
 @param conditionSql 条件语句
 @return 返回的条数
 */
- (NSString *)executeGetMinWithTableName:(NSString *)tableName
                                  field:(NSString *)field
                           conditionSql:(NSString *)conditionSql{
    // SQL语句
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(%@) FROM %@ ", field, tableName];
    if (conditionSql.length > 0) {
        sql = [NSString stringWithFormat:@"%@%@", sql, conditionSql];
    }
    __block id result = 0;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        db.logsErrors = YES;
        BOOL isSuccess = NO;
        @try {
            FMResultSet *resultSet = [db executeQuery:sql];
            while ([resultSet next]) {
                result = [resultSet stringForColumnIndex:0];
            }
            isSuccess = YES;
        } @catch (NSException *exception) {
            DLog(@"%@",exception);
            *rollback = YES;
            isSuccess = NO;
        } @finally {
            
        }
        if (!isSuccess) {
            DLog(@"sqlite work fail : %@ ", sql);
        }
    }];
    return result;
}

#pragma mark - 更新
/**
 更新
 
 @param tableName 表名
 @param fieldAndValueDic 需要更新的字段与值
 @param conditionDic 更新的条件
 @param conditionSql 条件语句
 @return 是否更新成功
 */
- (BOOL)executeUpdateWithTableName:(NSString *)tableName
                  fieldAndValueDic:(NSDictionary *)fieldAndValueDic
                      conditionDic:(NSDictionary *)conditionDic
                      conditionSql:(NSString *)conditionSql{
    // SQL语句
    NSString *sql = [DDBSqlTool createUpdateSQLWithTableName:tableName fieldAndValueDic:fieldAndValueDic conditionDic:conditionDic conditionSql:conditionSql];
    __block BOOL success = NO;
    [self executeSql:sql completedBlock:^(BOOL isSuccess, id result) {
        success = isSuccess;
    }];
    return success;
}

#pragma mark - 插入
/**
 插入
 
 @param tableName 表名
 @param fieldAndValueDic 需要插入的字段与值
 @return 插入id位置
 */
- (long long)executeInsertWithTableName:(NSString *)tableName
                       fieldAndValueDic:(NSDictionary *)fieldAndValueDic{
    // SQL语句
    NSString *sql = [DDBSqlTool createInsertSQLWithTableName:tableName fieldAndValueDic:fieldAndValueDic];
    __block id resultId = @(0);
    [self executeSql:sql completedBlock:^(BOOL isSuccess, id result) {
        if (isSuccess) {
            resultId = result;
        }
    }];
    return [resultId longLongValue];
}

#pragma mark - 删除
/**
 删除
 
 @param tableName 表名
 @param conditionDic 删除的条件
 @param conditionSql 条件语句
 @return 是否删除成功
 */
- (BOOL)executeDeleteWithTableName:(NSString *)tableName
                      conditionDic:(NSDictionary *)conditionDic
                      conditionSql:(NSString *)conditionSql{
    // SQL语句
    NSString *sql = [DDBSqlTool createDeleteSQLWithTableName:tableName conditionDic:conditionDic conditionSql:conditionSql];
    __block BOOL success = NO;
    [self executeSql:sql completedBlock:^(BOOL isSuccess, id result) {
        success = isSuccess;
    }];
    return success;
}



@end
