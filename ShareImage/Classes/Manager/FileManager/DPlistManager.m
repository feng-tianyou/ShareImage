//
//  DPlistManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DPlistManager.h"

#define ERROR_LOG_FILE_NAME         @"ERROR_LOG_FILE_NAME"

@implementation DPlistManager

#pragma mark 获取实例
+(id)shareManager
{
    static DPlistManager *plistManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        plistManager = [[DPlistManager alloc] init];
    });
    return plistManager;
}

#pragma mark 创建文件并返回生成的文件名
-(NSString *)createPlist
{
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *strPlist = [NSString stringWithFormat:@"/Plist/"];
    [fileManager createDirectoryAtPath:[strDoc stringByAppendingPathComponent:strPlist]
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@_%d.plist",
                             [NSDate date],arc4random()%501];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    
    if(![fileManager fileExistsAtPath:strPath])
    {
        if([fileManager createFileAtPath:strPath contents:nil attributes:nil])
        {
            return strPath;
        }
    }
    return nil;
}

#pragma mark 根据名称创建文件
-(FileState)createPlistByName:(NSString *)strName
{
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *strPlist = [NSString stringWithFormat:@"/Plist/"];
    [fileManager createDirectoryAtPath:[strDoc stringByAppendingPathComponent:strPlist]
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    
    if(![fileManager fileExistsAtPath:strPath])
    {
        if([fileManager createFileAtPath:strPath contents:nil attributes:nil])
        {
            DLog(@"%@",strPath);
            return FileCreateSuccess;
        }
        else
        {
            return FileError;
        }
    }
    else
    {
        return FileExist;
    }
}

#pragma mark 记录错误日志
- (void)writeErrorByStrError:(NSString *)strError{
    NSMutableDictionary *dicErrorLog = [NSMutableDictionary new];
    NSDictionary *dicError = [[DPlistManager shareManager] getDataByFileName:ERROR_LOG_FILE_NAME];
    if(dicError != nil){
        [dicErrorLog addEntriesFromDictionary:dicError];
    }
    [dicErrorLog setObject:strError forKey:[[NSDate date] formatToString:@"yyyy-MM-dd HH:mm:ss"]];
    [[DPlistManager shareManager] writeDicToPlistByFileName:ERROR_LOG_FILE_NAME dicData:dicErrorLog];
}

#pragma mark 将dicData写入strName的plist文件
-(FileState)writeDicToPlistByFileName:(NSString *)strName dicData:(NSDictionary *)dicData
{
    [self createPlistByName:strName];
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:strPath])
    {
        return FileNoExist;
    }
    else
    {
        if([dicData writeToFile:strPath atomically:YES])
        {
            return FileWriteSuccess;
        }
        else
        {
            return FileError;
        }
    }
}

#pragma mark 根据文件名称获取dic
-(NSDictionary *)getDataByFileName:(NSString *)strName
{
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:strPath];
    return dic;
}

#pragma mark 将arrData写入strName的plist文件
-(FileState)writeArrToPlistByFileName:(NSString *)strName arrData:(NSArray *)arrData
{
    [self createPlistByName:strName];
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:strPath])
    {
        return FileNoExist;
    }
    else
    {
        if([arrData writeToFile:strPath atomically:YES])
        {
            return FileWriteSuccess;
        }
        else
        {
            return FileError;
        }
    }
}

#pragma mark 根据文件名称获取arr
-(NSArray *)getArrDataByFileName:(NSString *)strName
{
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSArray *arr = [NSArray arrayWithContentsOfFile:strPath];
    return arr;
}

#pragma mark 将data写入strName的plist文件
-(FileState)writeDataToPlistByFileName:(NSString *)strName data:(NSData *)data
{
    [self createPlistByName:strName];
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:strPath])
    {
        return FileNoExist;
    }
    else
    {
        if([data writeToFile:strPath atomically:YES])
        {
            return FileWriteSuccess;
        }
        else
        {
            return FileError;
        }
    }
}

#pragma mark 根据文件名称获取data
-(NSData *)getBitDataByFileName:(NSString *)strName
{
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSData *data = [NSData dataWithContentsOfFile:strPath];
    return data;
}

#pragma mark 根据文件名删除文件
-(FileState)deletePlistByName:(NSString *)strName
{
    NSString *strDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask, YES) objectAtIndex:0];
    NSString *strPlistAll = [NSString stringWithFormat:@"/Plist/%@.plist",strName];
    NSString *strPath=[strDoc stringByAppendingPathComponent:strPlistAll];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:strPath])
    {
        return FileNoExist;
    }
    else
    {
        if([fileManager removeItemAtPath:strPath error:nil])
        {
            DLog(@"deleteSuccess");
            return FileDeleteSuccess;
        }
    }
    return FileError;
}


@end
