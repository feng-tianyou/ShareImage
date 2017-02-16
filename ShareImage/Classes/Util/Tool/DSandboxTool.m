//
//  DSandboxTool.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/19.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DSandboxTool.h"
#include <sys/stat.h>
#include <dirent.h>


//递归遍历所有文件
long long folderSizeAtPath(const char* folderPath)
{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL)
    {
        return 0;
    }
    
    struct dirent* child;
    while ((child = readdir(dir))!=NULL)
    {
        if (child->d_type == DT_DIR
            && ((child->d_name[0] == '.' && child->d_name[1] == 0)// 忽略目录 .
                || (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                )
            )
        {
            continue;
        }
        
        int folderPathLength = (int)strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/')
        {
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        
        stpcpy(childPath+folderPathLength, child->d_name);
        
        childPath[folderPathLength + child->d_namlen] = 0;
        
        if (child->d_type == DT_DIR)
        {
            // directory
            folderSize += folderSizeAtPath(childPath); // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0)
            {
                folderSize += st.st_size;
            }
        }
        else if (child->d_type == DT_REG || child->d_type == DT_LNK)
        { // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0)
            {
                folderSize += st.st_size;
            }
        }
    }
    
    return folderSize;
}

@implementation DSandboxTool
+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{
    return [NSString stringWithFormat:@"%@/tmp", NSHomeDirectory()];
}

+ (BOOL)fileExistsAtPath:(NSString*)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:nil];
    }
    
    return YES;
}

+(BOOL)deleteDirectory:(NSString*)path
{
    return [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
}

//c函数来实现获取文件大小
+ (long long) fileSizeAtPath:(NSString*) filePath
{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}

//获取文件夹大小
+ (long long)folderSizeAtPath:(NSString*)folderPath
{
    return folderSizeAtPath([folderPath cStringUsingEncoding:NSUTF8StringEncoding]);
}

@end
