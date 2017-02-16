//
//  DImageCache.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseCache.h"

@interface DImageCache : DBaseCache

+ (instancetype)globalCache;

+ (instancetype)globalCacheForUserIcon;

/**
 *  根据键值移除缓存图片
 *
 *  @param key 保存图片时所使用的键值
 */
- (void)removeCacheImageByKey:(NSString *)key;

/**
 *  根据键值移除缓存用户头像
 *
 *  @param key 保存图片时所使用的键值
 */
- (void)removeCacheImageForUserIconByKey:(NSString *)key;

/**
 *  根据键值获取缓存图片
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
- (UIImage *)getCacheImageByKey:(NSString *)key;

/**
 *  根据键值获取缓存用户头像
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
- (UIImage *)getCacheImageForUserIconByKey:(NSString *)key;

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 */
- (void)setCacheImage:(UIImage *)image forKey:(NSString *)key;

/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 */
- (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key;

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheImage:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;


/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;



@end
