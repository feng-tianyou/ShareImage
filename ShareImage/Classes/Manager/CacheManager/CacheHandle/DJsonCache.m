//
//  DJsonCache.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DJsonCache.h"
#import "EGOCache.h"

#define JSONPATH @"json"

@interface DJsonCache()


@end

@implementation DJsonCache

+ (instancetype)globalCache{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:JSONPATH] copy];
        instance = [[[self class] alloc] initWithCacheDirectory:cachesDirectory];
    });
    return instance;
}

- (id)initWithCacheDirectory:(NSString*)cacheDirectory{
    if(self = [super init]){
        self.cache = [[EGOCache alloc] initWithCacheDirectory:cacheDirectory];
    }
    return self;
}

//- (void)clearCache{
//    [super clearCache];
//    NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:JSONPATH] copy];
//    self.cache = [[EGOCache alloc] initWithCacheDirectory:cachesDirectory];
//}

/**
 *  根据键值移除缓存Json
 *
 *  @param key 保存Json时所使用的键值
 */
- (void)removeCacheJsonByKey:(NSString *)key{
    [self removeCacheForKey:key];
}

/**
 *  获取缓存的json数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 缓存的json数据
 */
- (NSData *)getCacheJsonByDataForKey:(NSString *)key{
    return [self dataForKey:key];
}

- (NSString *)getCacheJsonByStringForKey:(NSString *)key{
    return [self stringForKey:key];
}

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 */
- (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key{
    [self setData:dataJson forKey:key];
}

- (void)setCacheJsonByString:(NSString *)strJson forKey:(NSString *)key{
    [self setString:strJson forKey:key];
}

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self setData:dataJson forKey:key withTimeoutInterval:timeoutInterval];
}

- (void)setCacheJsonByString:(NSString *)strJson forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self setString:strJson forKey:key withTimeoutInterval:timeoutInterval];
    
}


@end
