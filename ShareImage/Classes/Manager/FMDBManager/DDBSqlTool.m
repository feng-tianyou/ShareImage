//
//  DDBSqlTool.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/19.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DDBSqlTool.h"
#import <objc/objc.h>

/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"
#define PrimaryKey  @"primary key"

#define primaryId   @"pk"

@implementation DDBSqlTool
#pragma mark - 私有方法
+ (NSString *)proccessStrValue:(NSString *)strValue{
    if([[strValue class] isSubclassOfClass:[NSString class]]){
        NSArray * arrStr = [strValue componentsSeparatedByString:@"'"];
        if(arrStr && arrStr.count > 0)
        {
            strValue = [arrStr componentsJoinedByString:@"''"];
        }
        
    }
    return strValue;
}

#pragma mark - 暴露方法
/**
 根据类自动生成创建表的SQL语句
 
 @param classModel 类
 @param tableName 表名
 @param transients 不需要的存储字段（操作数据的时候，记得注意不存储的字段）
 @return SQL语句
 */
+ (NSString *)getSqlForCreateUsersTableWithClassModel:(Class)classModel tableName:(NSString *)tableName transients:(NSArray *)transients{
    
    if (tableName.length == 0) return @"";
    if (classModel == NULL) return @"";
    
    // 获取该类的所有属性dic
    NSMutableArray *totalPropertys = [NSMutableArray arrayWithCapacity:0];
    
    unsigned int outCount, i;
    objc_property_t *propertys = class_copyPropertyList(classModel, &outCount);
    for (i = 0; i < outCount; i++) {
        @autoreleasepool {
            objc_property_t property = propertys[i];
            NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
            // 获取属性名
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if ([transients containsObject:propertyName]) {
                continue;
            }
            [propertyDic setObject:propertyName forKey:@"name"];
            
            // 获取属性数据类型
            /*
             c char         C unsigned char
             i int          I unsigned int
             l long         L unsigned long
             s short        S unsigned short
             d double       D unsigned double
             f float        F unsigned float
             q long long    Q unsigned long long
             B BOOL
             @ 对象类型 //指针 对象类型 如NSString 是@“NSString”
             
             
             64位下long 和long long 都是Tq
             SQLite 默认支持五种数据类型TEXT、INTEGER、REAL、BLOB、NULL
             */
            NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            if ([propertyType hasPrefix:@"T@"]) {
                [propertyDic setObject:SQLTEXT forKey:@"type"];
            } else if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]||[propertyType hasPrefix:@"Tq"]||[propertyType hasPrefix:@"TQ"]){
                [propertyDic setObject:SQLINTEGER forKey:@"type"];
            } else {
                [propertyDic setObject:SQLREAL forKey:@"type"];
            }
            [totalPropertys addObject:propertyDic];
        }
    }
    free(propertys);
    
    NSString *strPrefix = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (_id INTEGER PRIMARY KEY", tableName];
    __block NSString *subStr = @"";
    [totalPropertys enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *propertyStr = [NSString stringWithFormat:@", %@ %@", [dic objectForKey:@"name"], [dic objectForKey:@"type"]];
        subStr = [subStr stringByAppendingString:propertyStr];
    }];
    
    if (subStr.length == 0) return @"";
    subStr = [subStr stringByAppendingString:@")"];
    
    NSString *sql = [NSString stringWithFormat:@"%@%@", strPrefix, subStr];
    DLog(@"create sql: %@", sql);
    return sql;
}

/**
 创建用户表的SQL语句
 */
+ (NSString *)getSqlForCreateUsersTable{
    NSString *strCommand = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (_id INTEGER PRIMARY KEY, uid INTEGER default 0, thirdUid TEXT, iconurl TEXT, job TEXT, name TEXT NOT NULL, company TEXT, qq TEXT, email TEXT, address TEXT, sex TEXT, mobile TEXT, birthday TEXT)",TABLE_NAME_USERS];
    return strCommand;
}



/**
 获取数据库的路径
 
 @param dbName 数据库名
 @return 路径
 */
+ (NSString *)getDataBaseFilePathWithDBName:(NSString *)dbName{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:dbName];
}

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
                    conditionAndOrderBySql:(NSString *)conditionAndOrderBySql{
    if (tableName.length == 0 || tableName == nil) return nil;
    NSString *sqlString = @"SELECT";
    NSString *fields = @"";
    if (fieldArr == nil || [fieldArr count]<1) {
        fields = @" * ";
    } else {
        for (int i = 0; i<[fieldArr count]; i++) {
            @autoreleasepool {
                NSString *seperator = [fields length]<1?@" ":@",";
                fields = [NSString stringWithFormat:@"%@%@%@",fields,seperator,[fieldArr objectAtIndex:i]];
            }
        }
        fields = [fields stringByAppendingString:@" "];
    }
    
    sqlString = [sqlString stringByAppendingString:fields];
    sqlString = [sqlString stringByAppendingString:@"FROM "];
    sqlString = [sqlString stringByAppendingString:tableName];
    
    if (conditionDic && [conditionDic count] > 0) {
        sqlString = [sqlString stringByAppendingString:@" WHERE "];
        
        NSString *conditions = @"";
        for (int j =0; j < [[conditionDic allKeys] count]; j++) {
            @autoreleasepool {
                NSString *key = [[conditionDic allKeys] objectAtIndex:j];
                NSString *value = [self proccessStrValue:[conditionDic objectForKey:key]];
                if([[value class] isSubclassOfClass:[NSString class]]){
                    value = [NSString stringWithFormat:@"'%@'",value];
                }
                
                NSString *seperator = [conditions length] < 1 ? @"":@" AND ";
                conditions = [NSString stringWithFormat:@"%@%@%@=%@",conditions,seperator,key,value];
            }
        }
        sqlString = [sqlString stringByAppendingString:conditions];
    }
    if(conditionAndOrderBySql && conditionAndOrderBySql.length > 0){
        sqlString = [NSString stringWithFormat:@"%@ %@",sqlString,conditionAndOrderBySql];
    }
    return sqlString;
}

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
                              conditionSql:(NSString *)conditionSql{
    if (tableName.length == 0 || tableName == nil) return nil;
    NSString *sqlString = @"UPDATE ";
    
    sqlString = [sqlString stringByAppendingString:tableName];
    
    sqlString = [sqlString stringByAppendingString:@" SET"];
    
    NSString *updateFields = @"";
    
    for (int i = 0; i<[[fieldAndValueDic allKeys] count]; i++) {
        @autoreleasepool {
            NSString *seperator = [updateFields length]<1?@" ":@",";
            NSString *key = [[fieldAndValueDic allKeys] objectAtIndex:i];
            NSString *value = [self proccessStrValue:[fieldAndValueDic objectForKey:key]];
            if([[value class] isSubclassOfClass:[NSString class]]){
                value = [NSString stringWithFormat:@"'%@'",value];
            }
            updateFields = [NSString stringWithFormat:@"%@%@%@=%@",updateFields,seperator,key,value];
        }
    }
    
    sqlString = [sqlString stringByAppendingString:updateFields];
    
    if (conditionDic && [conditionDic count] > 0) {
        sqlString = [sqlString stringByAppendingString:@" WHERE "];
        
        NSString *conditions = @"";
        
        for (int j =0; j < [[conditionDic allKeys] count]; j++) {
            @autoreleasepool {
                NSString *key = [[conditionDic allKeys] objectAtIndex:j];
                NSString *value = [self proccessStrValue:[conditionDic objectForKey:key]];
                if([[value class] isSubclassOfClass:[NSString class]]){
                    value = [NSString stringWithFormat:@"'%@'",value];
                }
                
                NSString *seperator = [conditions length]<1?@"":@" AND ";
                
                conditions = [NSString stringWithFormat:@"%@%@%@=%@",conditions,seperator,key,value];
            }
        }
        
        sqlString = [sqlString stringByAppendingString:conditions];
    }
    
    if(conditionSql.length > 0){
        sqlString = [NSString stringWithFormat:@"%@ %@",sqlString,conditionSql];
    }
    
    return sqlString;
}

/**
 创建插入SQL语句
 
 @param tableName 表名
 @param fieldAndValueDic 需要插入的字段与值
 @return SQL语句
 */
+ (NSString *)createInsertSQLWithTableName:(NSString *)tableName
                          fieldAndValueDic:(NSDictionary *)fieldAndValueDic{
    if (tableName.length == 0 || tableName == nil) return nil;
    NSString *sqlString = @"INSERT INTO ";
    sqlString = [sqlString stringByAppendingString:tableName];
    sqlString = [sqlString stringByAppendingString:@" ("];
    
    NSString *keyString = @"";
    
    for (int i = 0 ; i<[[fieldAndValueDic allKeys] count]; i++) {
        @autoreleasepool {
            NSString *seperator = [keyString length]<1?@"":@",";
            NSString *key = [[fieldAndValueDic allKeys] objectAtIndex:i];
            keyString = [NSString stringWithFormat:@"%@%@%@",keyString,seperator,key];
        }
    }
    sqlString = [sqlString stringByAppendingString:keyString];
    sqlString = [sqlString stringByAppendingString:@") VALUES ("];
    
    NSString *valueString = @"";
    for (int j = 0 ; j<[[fieldAndValueDic allKeys] count]; j++) {
        @autoreleasepool {
            NSString *seperator = [valueString length]<1?@"":@",";
            NSString *key = [[fieldAndValueDic allKeys] objectAtIndex:j];
            NSString *value = [self proccessStrValue:[fieldAndValueDic objectForKey:key]];
            if([[value class] isSubclassOfClass:[NSString class]]){
                value = [NSString stringWithFormat:@"'%@'",value];
            }
            valueString = [NSString stringWithFormat:@"%@%@%@",valueString,seperator,value];
        }
    }
    
    sqlString = [sqlString stringByAppendingString:valueString];
    sqlString = [sqlString stringByAppendingString:@")"];
    
    return sqlString;
}

/**
 创建删除SQL语句
 
 @param tableName 表名
 @param conditionDic 删除的条件
 @param conditionSql 条件语句
 @return SQL语句
 */
+ (NSString *)createDeleteSQLWithTableName:(NSString *)tableName
                              conditionDic:(NSDictionary *)conditionDic
                              conditionSql:(NSString *)conditionSql{
    if (tableName.length == 0 || tableName == nil) return nil;
    NSString *sqlString = @"DELETE FROM ";
    sqlString = [sqlString stringByAppendingString:tableName];
    
    if (conditionDic && [conditionDic count] > 0) {
        sqlString = [sqlString stringByAppendingString:@" WHERE "];
        
        NSString *conditions = @"";
        
        for (int j =0; j < [[conditionDic allKeys] count]; j++) {
            @autoreleasepool {
                NSString *key = [[conditionDic allKeys] objectAtIndex:j];
                NSString *value = [self proccessStrValue:[conditionDic objectForKey:key]];
                if([[value class] isSubclassOfClass:[NSString class]]){
                    value = [NSString stringWithFormat:@"'%@'",value];
                }
                
                NSString *seperator = [conditions length]<1?@"":@" AND ";
                
                conditions = [NSString stringWithFormat:@"%@%@%@=%@",conditions,seperator,key,value];
            }
        }
        if(conditions.length > 0){
            sqlString = [sqlString stringByAppendingString:conditions];
        }
    }
    
    if(conditionSql.length > 0){
        sqlString = [NSString stringWithFormat:@"%@ %@",sqlString,conditionSql];
    }
    
    return sqlString;
}

@end
