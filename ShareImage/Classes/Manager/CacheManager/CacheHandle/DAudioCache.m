//
//  DAudioCache.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DAudioCache.h"
#import "EGOCache.h"
#import "DPlistManager.h"

#define kAudioPathManager @"audioPathManager"
#define AUDIOPATH         @"audio"

@interface DAudioCache ()

@property (nonatomic, copy) NSString *todayFullPath;
@property (nonatomic, copy) NSString *todayPath;

@end

@implementation DAudioCache

+ (instancetype)globalCache{
    NSString *today = [[NSDate date] formatToString:@"yyyy-MM-dd"];
    static DAudioCache *instance;
    
    if (instance == nil || ![instance.todayPath isEqualToString:today]) {
        NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:AUDIOPATH] copy];
        cachesDirectory = [[cachesDirectory stringByAppendingPathComponent:today] copy];
        instance = [[[self class] alloc] initWithCacheDirectory:cachesDirectory];
        instance.todayPath = today;
        instance.todayFullPath = cachesDirectory;
        DLog(@"%@",cachesDirectory);
    }
    return instance;
}

- (id)initWithCacheDirectory:(NSString*)cacheDirectory{
    if(self = [super init]){
        self.cache = [[EGOCache alloc] initWithCacheDirectory:cacheDirectory];
    }
    return self;
}

- (void)createAudioPathPlistForKey:(NSString *)key{
    DPlistManager *plistManager = [DPlistManager shareManager];
    NSDictionary *dic;
    NSString *strImgManagerName = [NSString stringWithFormat:@"%@",
                                   kAudioPathManager];
    NSString *todayPath = self.todayFullPath;
    if([plistManager createPlistByName:strImgManagerName] == FileCreateSuccess)
    {
        dic = @{key:todayPath};
    }
    else
    {
        NSDictionary *dicPlist = [plistManager getDataByFileName:strImgManagerName];
        NSMutableDictionary *dicAdd = [[NSMutableDictionary alloc]
                                       initWithDictionary:dicPlist];
        [dicAdd setObject:todayPath forKey:key];
        dic = dicAdd;
        
    }
    [plistManager writeDicToPlistByFileName:strImgManagerName dicData:dic];
}

- (EGOCache *)getAudioPathForKey:(NSString *)key{
    DPlistManager *plistManager = [DPlistManager shareManager];
    NSString *strImgManagerName = [NSString stringWithFormat:@"%@",
                                   kAudioPathManager];
    NSDictionary *dicPlist = [plistManager getDataByFileName:strImgManagerName];
    if(dicPlist == nil)
    {
        return nil;
    }
    else
    {
        NSString *strPath = [dicPlist objectForKey:key];
        if(strPath.length > 0){
            if([strPath isEqualToString:self.todayFullPath]){
                return self.cache;
            }
            return [[EGOCache alloc] initWithCacheDirectory:strPath];
        }
        return nil;
    }
}

/**
 *  根据键值移除缓存语音
 *
 *  @param key 保存语音时所使用的键值
 */
- (void)removeCacheAudioByKey:(NSString *)key{
    EGOCache *cache = [self getAudioPathForKey:key];
    if(cache){
        [cache removeCacheForKey:key];
    }
}

/**
 *  获取缓存语音数据
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 缓存语音数据
 */
- (NSData *)getCacheAudioForKey:(NSString *)key{
    EGOCache *cache = [self getAudioPathForKey:key];
    if(cache){
        return [cache dataForKey:key];
    }
    return nil;
}

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 */
- (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key{
    [self createAudioPathPlistForKey:key];
    [self setData:audioData forKey:key];
}

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self createAudioPathPlistForKey:key];
    [self setData:audioData forKey:key withTimeoutInterval:timeoutInterval];
}


@end
