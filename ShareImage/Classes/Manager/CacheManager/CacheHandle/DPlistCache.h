//
//  DPlistCache.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseCache.h"

@interface DPlistCache : DBaseCache

/**
*  根据键值移除缓存Plist
*
*  @param key 保存Plist时所使用的键值
*/
- (void)removeCachePlistByKey:(NSString *)key;

/**
 *  获取缓存的plist数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 返回plist数据
 */
- (NSData *)getCachePlistForKey:(NSString *)key;

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 */
- (void)setCachePlistByObject:(id)object forKey:(NSString *)key;

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCachePlistByObject:(id)object forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;



@end
