//
//  DDBSqlTool.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/19.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//  sql语句的创建于分析工具

#import <Foundation/Foundation.h>

#define TABLE_NAME_USERS     @"users"  // 用户表

@interface DDBSqlTool : NSObject

#pragma mark - 自动根据模型生成
/**
 根据类自动生成创建表的SQL语句

 @param classModel 类
 @param tableName 表名
 @param transients 不需要的存储字段（操作数据的时候，记得注意不存储的字段）
 @return SQL语句
 */
+ (NSString *)getSqlForCreateUsersTableWithClassModel:(Class)classModel tableName:(NSString *)tableName transients:(NSArray *)transients;

#pragma mark - 定制

/**
 创建用户表的SQL语句
 */
+ (NSString *)getSqlForCreateUsersTable;

#pragma mark - 通用方法
/**
 获取数据库的路径

 @param dbName 数据库名
 @return 路径
 */
+ (NSString *)getDataBaseFilePathWithDBName:(NSString *)dbName;

/**
 创建条件查询SQL语句

 @param tableName 表名
 @param fieldArr 查询字段集合
 @param conditionDic 查询条件
 @param conditionAndOrderBySql and order 附加查询条件语句
 @return SQL语句
 */
+ (NSString *)createSelectSQLWithTableName:(NSString *)tableName
                                  fieldArr:(NSArray *)fieldArr
                              conditionDic:(NSDictionary *)conditionDic
                    conditionAndOrderBySql:(NSString *)conditionAndOrderBySql;

/**
 创建更新SQL语句

 @param tableName 表名
 @param fieldAndValueDic 需要更新的字段与值
 @param conditionDic 更新的条件
 @param conditionSql 条件语句
 @return SQL语句
 */
+ (NSString *)createUpdateSQLWithTableName:(NSString *)tableName
                          fieldAndValueDic:(NSDictionary *)fieldAndValueDic
                              conditionDic:(NSDictionary *)conditionDic
                              conditionSql:(NSString *)conditionSql;

/**
 创建插入SQL语句

 @param tableName 表名
 @param fieldAndValueDic 需要插入的字段与值
 @return SQL语句
 */
+ (NSString *)createInsertSQLWithTableName:(NSString *)tableName
                          fieldAndValueDic:(NSDictionary *)fieldAndValueDic;

/**
 创建删除SQL语句

 @param tableName 表名
 @param conditionDic 删除的条件
 @param conditionSql 条件语句
 @return SQL语句
 */
+ (NSString *)createDeleteSQLWithTableName:(NSString *)tableName
                              conditionDic:(NSDictionary *)conditionDic
                              conditionSql:(NSString *)conditionSql;

@end
