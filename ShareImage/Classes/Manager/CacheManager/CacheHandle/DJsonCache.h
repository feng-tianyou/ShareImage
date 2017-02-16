//
//  DJsonCache.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseCache.h"

@interface DJsonCache : DBaseCache

/**
 *  根据键值移除缓存Json
 *
 *  @param key 保存Json时所使用的键值
 */
- (void)removeCacheJsonByKey:(NSString *)key;

/**
 *  获取缓存的json数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 缓存的json数据
 */
- (NSData *)getCacheJsonByDataForKey:(NSString *)key;

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 */
- (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key;

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;



@end
