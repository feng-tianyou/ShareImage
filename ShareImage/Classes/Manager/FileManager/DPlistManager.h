//
//  DPlistManager.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTypeDefine.h"

@interface DPlistManager : NSObject


#pragma mark 获取实例
+(id)shareManager;

#pragma mark 创建文件并返回生成的文件名
-(NSString *)createPlist;

#pragma mark 根据名称创建文件
-(FileState)createPlistByName:(NSString *)strName;

#pragma mark 记录错误日志
- (void)writeErrorByStrError:(NSString *)strError;

#pragma mark 将dicData写入strName的plist文件
-(FileState)writeDicToPlistByFileName:(NSString *)strName dicData:(NSDictionary *)dicData;

#pragma mark 将arrData写入strName的plist文件
-(FileState)writeArrToPlistByFileName:(NSString *)strName arrData:(NSArray *)arrData;

#pragma mark 将data写入strName的plist文件
-(FileState)writeDataToPlistByFileName:(NSString *)strName data:(NSData *)data;

#pragma mark 根据文件名称获取dic
-(NSDictionary *)getDataByFileName:(NSString *)strName;

#pragma mark 根据文件名称获取arr
-(NSArray *)getArrDataByFileName:(NSString *)strName;

#pragma mark 根据文件名称获取data
-(NSData *)getBitDataByFileName:(NSString *)strName;

#pragma mark 根据文件名删除文件
-(FileState)deletePlistByName:(NSString *)strName;

@end
