//
//  DFileManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DFileManager.h"

@implementation DFileManager

#pragma mark 遍历文件夹获得文件夹大小，返回多少M
+(float)folderSizeAtPath:(NSString *)strPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:strPath])
    {
        return 0;
    }
    NSEnumerator *childFile = [fileManager subpathsAtPath:strPath].objectEnumerator;
    NSString *strFileName;
    float folderSize = 0;
    while ((strFileName = [childFile nextObject]) != nil) {
        NSString *strFilePath = [strPath stringByAppendingPathComponent:strFileName];
        folderSize += [DFileManager fileSizeAtPath:strFilePath];
    }
    return folderSize;
}

#pragma mark 单个文件的大小 返回多少M
+(float)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath])
    {
        return [[fileManager attributesOfItemAtPath:filePath error:nil] fileSize]/(1024.0*1024);
    }
    return 0;
}

#pragma mark 指定路径的文件是否存在
+(BOOL)fileIsExistByPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark 删除指定路径的文件
+(FileState)deleteFileAtPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath])
    {
        if([fileManager removeItemAtPath:filePath error:nil])
        {
            return FileDeleteSuccess;
        }
        else
        {
            return FileError;
        }
    }
    else
    {
        return FileNoExist;
    }
}

#pragma mark 删除指定路径的文件
+(FileState)deleteFileAtArrPath:(NSArray *)arrFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for (NSString *filePath in arrFilePath.objectEnumerator) {
        @autoreleasepool {
            if([fileManager fileExistsAtPath:filePath])
            {
                if(![fileManager removeItemAtPath:filePath error:nil])
                {
                    return FileError;
                }
            }
            else
            {
                return FileNoExist;
            }
        }
    }
    return FileDeleteSuccess;
}

+ (NSString *)getImageRootPath{
    NSMutableString *strPath = [NSMutableString new];
    [strPath appendString:[[NSBundle mainBundle] pathForResource:FILE_MAIN_BUNDLE_NAME ofType:@"bundle"]];
    return [strPath stringByAppendingPathComponent:@"image"];
}

+ (NSString *)getEmojiImageRootPath{
    NSMutableString *strPath = [NSMutableString new];
    [strPath appendString:[[NSBundle mainBundle] pathForResource:FILE_MAIN_BUNDLE_EMOTION_NAME ofType:@"bundle"]];
    return strPath;
}

+ (UIImage *)getLocalImageByName:(NSString *)name{
    NSAssert(name, @"图片名字不能为空");
    NSString *filePath = [[self getImageRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:@"png"];
    UIImage *image = nil;
    image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

/**
 *  获取Emoji本地图片，后缀默认为png
 *
 *  @param name 图片名称
 *
 *  @return 返回图片
 */
+ (UIImage *)getLocalEmmojiImageByName:(NSString *)name{
    NSAssert(name, @"图片名字不能为空");
    NSString *filePath = [[self getEmojiImageRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:@"png"];
    UIImage *image = nil;
    image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

+ (UIImage *)getLocalImageByName:(NSString *)name extension:(NSString *)extension{
    NSAssert(name, @"图片名字不能为空");
    NSAssert(extension, @"图片后缀不能为空");
    NSString *filePath = [[self getImageRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:extension];
    UIImage *image = nil;
    image = [UIImage imageWithContentsOfFile:filePath];
    if(image == nil){
        NSString *filePath = [[self getImageRootPath] stringByAppendingPathComponent:name];
        filePath = [filePath stringByAppendingPathExtension:[extension uppercaseString]];
        image = [UIImage imageWithContentsOfFile:filePath];
    }
    return image;
}

+ (NSData *)getLocalImageDataByName:(NSString *)name extension:(NSString *)extension{
    NSAssert(name, @"图片名字不能为空");
    NSAssert(extension, @"图片后缀不能为空");
    NSString *filePath = [[self getImageRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:extension];
    NSData *imgData = nil;
    imgData = [NSData dataWithContentsOfFile:filePath];
    if(imgData == nil){
        NSString *filePath = [[self getImageRootPath] stringByAppendingPathComponent:name];
        filePath = [filePath stringByAppendingPathExtension:[extension uppercaseString]];
        imgData = [NSData dataWithContentsOfFile:filePath];
    }
    return imgData;
}

+ (NSString *)getPlistRootPath{
    NSMutableString *strPath = [NSMutableString new];
    [strPath appendString:[[NSBundle mainBundle] pathForResource:FILE_MAIN_BUNDLE_NAME ofType:@"bundle"]];
    return [strPath stringByAppendingPathComponent:@"other"];
}

+ (NSData *)getLocalPlistByName:(NSString *)name{
    NSAssert(name, @"图片名字不能为空");
    NSString *filePath = [[self getPlistRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:@"plist"];
    NSData *data = nil;
    data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

/**
 *  Json获取
 *
 *  @param name Json文件名(自动添加.plist)
 *
 *  @return Json
 */
+ (NSArray *)plistDataWithName:(NSString *)name
{
    NSAssert(name, @"Json名字不能为空");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getPlistRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:@"plist"];
    if (![fileManager fileExistsAtPath:filePath]) {
        return nil;
    }
    NSArray * plistData = nil;
    plistData=[NSArray arrayWithContentsOfFile:filePath];
    NSAssert(plistData, @"读取Json出错!");
    return plistData;
}

/**
 *  Json获取
 *
 *  @param name Json文件名(自动添加.json)
 *
 *  @return Json
 */
+ (NSArray *)jsonDataWithName:(NSString *)name
{
    NSAssert(name, @"Json名字不能为空");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getPlistRootPath] stringByAppendingPathComponent:name];
    filePath = [filePath stringByAppendingPathExtension:@"js"];
    if (![fileManager fileExistsAtPath:filePath]) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSArray * plistData = nil;
    plistData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSAssert(plistData, @"读取Json出错!");
    return plistData;
}

@end
