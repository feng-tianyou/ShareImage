//
//  DAudioCache.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseCache.h"

@interface DAudioCache : DBaseCache


/**
 *  根据键值移除缓存语音
 *
 *  @param key 保存语音时所使用的键值
 */
- (void)removeCacheAudioByKey:(NSString *)key;

/**
 *  获取缓存语音数据
 *
 *  @param key 保存语音时所使用的键值
 *
 *  @return 缓存语音数据
 */
- (NSData *)getCacheAudioForKey:(NSString *)key;

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 */
- (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key;

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;



@end
