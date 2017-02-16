//
//  DCacheManager.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DCacheManager.h"
#import <YYKit/YYWebImageManager.h>

#import "DBaseCache.h"
#import "DAudioCache.h"
#import "DImageCache.h"
#import "DPlistCache.h"
#import "DJsonCache.h"

#import "DFileManager.h"

@implementation DCacheManager

/**
*  清除本地所有缓存
*/
+ (void)clearLocalCache{
    
    [DCacheManager refreshFileByName:@"EGOCache"];//清除EGOCache中的缓存文件 对应 TGObject缓存
    [DCacheManager refreshFileByName:@"json"];//清除json中的缓存文件 对应 json缓存
    //    [TGCacheManager refreshFileByName:@"Image"];//清除Image中的缓存文件
    //    [TGCacheManager refreshFileByName:@"ImageForUserIcon"];//清除ImageForUserIcon中的缓存文件
    //    [TGCacheManager refreshFileByName:@"plist"];//清除plist中的缓存文件
    
    
    
}

+ (void)refreshFileByName:(NSString *)name{
    NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    cachesDirectory = [[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] copy];
    
    NSString *pathEGOCache = [[cachesDirectory stringByAppendingPathComponent:name] copy];;
    
    [DFileManager deleteFileAtPath:pathEGOCache];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:pathEGOCache
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
}

/**
 *  根据键值移除缓存
 *
 *  @param key  保存缓存时所使用的键值
 *  @param type 缓存类型
 */
+ (void)removeCacheObjectByKey:(NSString *)key type:(CacheType)type{
    DBaseCache *cache = nil;
    switch (type) {
        case CacheTypeForImageNormal:{
            cache = [DImageCache globalCache];
            break;
        }
        case CacheTypeForImageUserIcon:{
            cache = [DImageCache globalCacheForUserIcon];
            break;
        }
        case CacheTypeForAudio:{
            cache = [DAudioCache globalCache];
            break;
        }
        case CacheTypeForJson:{
            cache = [DJsonCache globalCache];
            break;
        }
        case CacheTypeForPlist:{
            cache = [DPlistCache globalCache];
            break;
        }
        default:
            break;
    }
    if(cache){
        [cache removeCacheForKey:key];
    }
}

//****************************************图片缓存****************************************

/**
 *  根据键值获取缓存图片
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
+ (UIImage *)getCacheImageByKey:(NSString *)key{
    return [[DImageCache globalCache] getCacheImageByKey:key];
}

/**
 *  根据键值获取缓存用户头像
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
+ (UIImage *)getCacheImageForUserIconByKey:(NSString *)key{
    return [[DImageCache globalCacheForUserIcon] getCacheImageForUserIconByKey:key];
}

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 */
+ (void)setCacheImage:(UIImage *)image forKey:(NSString *)key{
    [[DImageCache globalCache] setCacheImage:image forKey:key];
}

/**
 *  缓存本地图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 */
+ (void)setCacheImageForLocalImage:(UIImage *)image forKey:(NSString *)key{
    [[DImageCache globalCache] setCacheImage:image forKey:key withTimeoutInterval:kCacheTimeForOneMonth];
}

/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 */
+ (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key{
    [[DImageCache globalCacheForUserIcon] setCacheImageForUserIcon:image forKey:key];
}

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheImage:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [[DImageCache globalCache] setCacheImage:image forKey:key withTimeoutInterval:timeoutInterval];
}


/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [[DImageCache globalCacheForUserIcon] setCacheImageForUserIcon:image forKey:key withTimeoutInterval:timeoutInterval];
}





//****************************************语音缓存****************************************

/**
 *  获取缓存语音数据
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 缓存语音数据
 */
+ (NSData *)getCacheAudioForKey:(NSString *)key{
    return [[DAudioCache globalCache] getCacheAudioForKey:key];
}

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 */
+ (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key{
    [[DAudioCache globalCache] setCacheAudio:audioData forKey:key];
}

/**
 *  缓存语音数据
 *
 *  @param audioData 语音数据
 *  @param key       获取语音时所需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheAudio:(NSData *)audioData forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [[DAudioCache globalCache] setCacheAudio:audioData forKey:key withTimeoutInterval:timeoutInterval];
}




//****************************************json缓存****************************************

/**
 *  获取缓存的json数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 缓存的json数据
 */
+ (NSData *)getCacheJsonByDataForKey:(NSString *)key{
    return [[DJsonCache globalCache] getCacheJsonByDataForKey:key];
}

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 */
+ (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key{
    [[DJsonCache globalCache] setCacheJsonByData:dataJson forKey:key];
}

/**
 *  缓存json数据
 *
 *  @param dataJson json数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheJsonByData:(NSData *)dataJson forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [[DJsonCache globalCache] setCacheJsonByData:dataJson forKey:key withTimeoutInterval:timeoutInterval];
}


//****************************************object缓存****************************************

/**
 *  获取缓存的对象数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 缓存的json数据
 */
+ (id<NSCoding>)getCacheObjectForKey:(NSString *)key{
    return [[DBaseCache globalCache] objectForKey:key];
}

/**
 *  缓存对象数据
 *
 *  @param anObject 对象数据
 *  @param key      获取数据时需要使用的键值
 */
+ (void)setCacheObjectByData:(id<NSCoding>)anObject forKey:(NSString*)key{
    [[DBaseCache globalCache] setObject:anObject forKey:key];
}

/**
 *  缓存对象数据
 *
 *  @param anObject 对象数据
 *  @param key      获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCacheObjectByData:(id<NSCoding>)anObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [[DBaseCache globalCache] setObject:anObject forKey:key withTimeoutInterval:timeoutInterval];
}


//****************************************plist缓存****************************************

/**
 *  获取缓存的plist数据
 *
 *  @param key 保存时所使用的键值
 *
 *  @return 返回plist数据
 */
+ (NSData *)getCachePlistForKey:(NSString *)key{
    return [[DPlistCache globalCache] getCachePlistForKey:key];
}

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 */
+ (void)setCachePlistByObject:(id)object forKey:(NSString *)key{
    [[DPlistCache globalCache] setCachePlistByObject:object forKey:key];
}

/**
 *  缓存plist数据
 *
 *  @param object 需要缓存的对象
 *  @param key    获取数据时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
+ (void)setCachePlistByObject:(id)object forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [[DPlistCache globalCache] setCachePlistByObject:object forKey:key withTimeoutInterval:timeoutInterval];
}


//清除用户头像缓存数据
+ (void)clearUserImgCacheByUid:(long long)uid{
    
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    NSString *urlSmallStr = [NSString stringWithFormat:@"%@/Api/Face/%@?big=false",kHttpURL,@(uid)];
    [manager.cache removeImageForKey:urlSmallStr];
    NSString *urlBigStr = [NSString stringWithFormat:@"%@/Api/Face/%@?big=true",kHttpURL,@(uid)];
    [manager.cache removeImageForKey:urlBigStr];
    
}


@end
