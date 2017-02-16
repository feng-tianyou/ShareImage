//
//  DPlistCache.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DPlistCache.h"
#import "EGOCache.h"

#define PLISTPATH   @"plist"

@implementation DPlistCache


+ (instancetype)globalCache{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:PLISTPATH] copy];
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

/**
 *  根据键值移除缓存Plist
 *
 *  @param key 保存Plist时所使用的键值
 */
- (void)removeCachePlistByKey:(NSString *)key{
    [self removeCacheForKey:key];
}

/**
 *  获取缓存的plist数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 返回plist数据
 */
- (NSData *)getCachePlistForKey:(NSString *)key{
    return [self dataForKey:key];
}

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 */
- (void)setCachePlistByObject:(id)object forKey:(NSString *)key{
    [self setObject:object forKey:key];
}

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCachePlistByObject:(id)object forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self setObject:object forKey:key withTimeoutInterval:timeoutInterval];
}


@end
