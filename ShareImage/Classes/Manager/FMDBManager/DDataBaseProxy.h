//
//  DDataBaseProxy.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/19.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDBSqlTool.h"

#define kDB_LAST_PATH       @"DF_DB"   // 基本路径
typedef void (^completedBlock)(BOOL isSuccess, id result);

@interface DDataBaseProxy : NSObject

#pragma mark - 单例
+ (instancetype)share;

#pragma mark - 释放内存
/**
 释放内存
 */
- (void)clearAllStorage;

#pragma mark - 创建表格

/**
 判断表格是否存在

 @param tableName 表名
 @return
 */
- (BOOL)isExistInTableWithName:(NSString *)tableName;

/**
 创建表格(可在DDBSqlTool获取或者定制)

 @param sql SQL语句
 @return 是否创建成功
 */
- (BOOL)executeCreatTableWithSql:(NSString *)sql;


#pragma mark - 查询
/**
 查询

 @param sql SQL语句
 @param completedBlock 回调
 */
- (void)executeQueryWithSql:(NSString *)sql completedBlock:(completedBlock)completedBlock;

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
                    completedBlock:(completedBlock)completedBlock;

/**
 查询某个表的总条数
 
 @param tableName 表名
 @param conditionSql 条件语句
 @return 总数
 */
- (NSInteger)executeGetCountWithTableName:(NSString *)tableName
                             conditionSql:(NSString *)conditionSql;

/**
 根据字段查询最小的id条数
 
 @param tableName 表名
 @param field 根据查询的字段
 @param conditionSql 条件语句
 @return 返回的条数
 */
- (NSString *)executeGetMinWithTableName:(NSString *)tableName
                                   field:(NSString *)field
                            conditionSql:(NSString *)conditionSql;


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
                      conditionSql:(NSString *)conditionSql;

#pragma mark - 插入
/**
 插入

 @param tableName 表名
 @param fieldAndValueDic 需要插入的字段与值
 @return 插入位置
 */
- (long long)executeInsertWithTableName:(NSString *)tableName
                       fieldAndValueDic:(NSDictionary *)fieldAndValueDic;

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
                      conditionSql:(NSString *)conditionSql;





@end
