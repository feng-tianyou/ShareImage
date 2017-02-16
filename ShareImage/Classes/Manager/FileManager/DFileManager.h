//
//  DFileManager.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FILE_MAIN_BUNDLE_NAME   @"DData"
#define FILE_MAIN_BUNDLE_EMOTION_NAME   @"Emotion"

@interface DFileManager : NSObject

#pragma mark 遍历文件夹获得文件夹大小，返回多少M
+(float)folderSizeAtPath:(NSString *)strPath;

#pragma mark 单个文件的大小 返回多少M
+(float)fileSizeAtPath:(NSString *)filePath;

#pragma mark 指定路径的文件是否存在
+(BOOL)fileIsExistByPath:(NSString *)filePath;

#pragma mark 删除指定路径的文件
+(FileState)deleteFileAtPath:(NSString *)filePath;

#pragma mark 删除指定路径的文件
+(FileState)deleteFileAtArrPath:(NSArray *)arrFilePath;

/**
 *  获取本地图片，后缀默认为png
 *
 *  @param name 图片名称
 *
 *  @return 返回图片
 */
+ (UIImage *)getLocalImageByName:(NSString *)name;

/**
 *  获取Emoji本地图片，后缀默认为png
 *
 *  @param name 图片名称
 *
 *  @return 返回图片
 */
+ (UIImage *)getLocalEmmojiImageByName:(NSString *)name;

/**
 *  获取本地图片，后缀默认为png
 *
 *  @param name 图片名称
 *  @param extension 图片后缀
 *
 *  @return 返回图片
 */
+ (UIImage *)getLocalImageByName:(NSString *)name extension:(NSString *)extension;

+ (NSData *)getLocalImageDataByName:(NSString *)name extension:(NSString *)extension;
/**
 *  获取本地plist数据
 *
 *  @param name plist名称
 *
 *  @return plist数据
 */
+ (NSData *)getLocalPlistByName:(NSString *)name;

/**
 *  Json获取
 *
 *  @param name Json文件名(自动添加.xml)
 *
 *  @return Json
 */
+ (NSArray *)plistDataWithName:(NSString *)name;

/**
 *  Json获取
 *
 *  @param name Json文件名(自动添加.json)
 *
 *  @return Json
 */
+ (NSArray *)jsonDataWithName:(NSString *)name;

@end
