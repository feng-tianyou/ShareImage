//
//  DCacheManager.h
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCacheManager : NSObject


/**
 *  清除本地所有缓存
 */
+ (void)clearLocalCache;

/**
 *  根据键值移除缓存
 *
 *  @param key  保存缓存时所使用的键值
 *  @param type 缓存类型
 */
+ (void)removeCacheObjectByKey:(NSString *)key type:(CacheType)type;

//****************************************图片缓存****************************************

/**
 *  根据键值获取缓存图片
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
+ (UIImage *)getCacheImageByKey:(NSString *)key;

/**
 *  根据键值获取缓存用户头像
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
+ (UIImage *)getCacheImageForUserIconByKey:(NSString *)key;

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 */
+ (void)setCacheImage:(UIImage *)image forKey:(NSString *)key;

/**
 *  缓存本地图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 */
+ (void)setCacheImageForLocalImage:(UIImage *)image forKey:(NSString *)key;

/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 */
+ (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key;

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheImage:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;


/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;





//****************************************语音缓存****************************************

/**
 *  获取缓存语音数据
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 缓存语音数据
 */
+ (NSData *)getCacheAudioForKey:(NSString *)key;

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 */
+ (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key;

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;




//****************************************json缓存****************************************

/**
 *  获取缓存的json数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 缓存的json数据
 */
+ (NSData *)getCacheJsonByDataForKey:(NSString *)key;

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 */
+ (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key;

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

//****************************************object缓存****************************************

/**
 *  获取缓存的对象数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 缓存的json数据
 */
+ (id<NSCoding>)getCacheObjectForKey:(NSString *)key;

/**
 *  缓存对象数据
 *
 *  @param anObject 对象数据
 *  @param key      获取数据时需要使用的键值
 */
+ (void)setCacheObjectByData:(id<NSCoding>)anObject forKey:(NSString*)key;

/**
 *  缓存对象数据
 *
 *  @param anObject 对象数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheObjectByData:(id<NSCoding>)anObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

/**
 *  缓存对象数据
 *
 *  @param anObject 对象数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
//+ (void)setCacheObjectWithHighQueueByData:(id<NSCoding>)anObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

///**
// *  缓存对象数据(先保存于内存中)
// *
// *  @param anObject 对象数据
// *  @param key      获取数据时需要使用的键值
// *  @param timeoutInterval 缓存时长
// */
//+ (void)setCacheObjectWithMemoryByData:(id<NSCoding>)anObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;


//****************************************plist缓存****************************************

/**
 *  获取缓存的plist数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 返回plist数据
 */
+ (NSData *)getCachePlistForKey:(NSString *)key;

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 */
+ (void)setCachePlistByObject:(id)object forKey:(NSString *)key;

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCachePlistByObject:(id)object forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

////****************************************清除缓存****************************************
//
////清除圈子列表缓存数据
//+ (void)clearGroupListCache;
//
////清除圈子头像缓存数据
//+ (void)clearGroupImgCacheByGid:(long long)gid;
//
////清除圈子头像缓存数据
//+ (void)clearDiscussImgCacheByDid:(long long)did;
//
////清除用户头像缓存数据
+ (void)clearUserImgCacheByUid:(long long)uid;
//
//+ (void)clearGroupMemberByGid:(long long)gid needReGet:(BOOL)needReGet;
//
//+ (void)clearGroupProjectDetailByGpid:(long long)gpid;
//
//+ (void)clearFriendProject;
//
//+ (void)clearCacheProjectList;



@end
