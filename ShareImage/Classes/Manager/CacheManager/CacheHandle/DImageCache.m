//
//  DImageCache.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DImageCache.h"
#import "EGOCache.h"
#import "DPlistManager.h"
#import "NSDate+DDate.h"

#define IMAGEFORNORMAL   @"Image"
#define IMAGEFORUSERICON @"ImageForUserIcon"
#define kImgPathManager  @"imgPathManager"

@interface DImageCache ()

@property (nonatomic, copy) NSString *todayFullPath;
@property (nonatomic, copy) NSString *todayPath;

@property (nonatomic, strong) NSMutableDictionary *dicImage;

@end

@implementation DImageCache

+ (instancetype)globalCache{
    NSString *today = [[NSDate date] formatToString:@"yyyy-MM-dd"];
    static DImageCache *instance;
    
    if (instance == nil || ![instance.todayPath isEqualToString:today]) {
        NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:IMAGEFORNORMAL] copy];
        
        cachesDirectory = [[cachesDirectory stringByAppendingPathComponent:today] copy];
        instance = [[[self class] alloc] initWithCacheDirectory:cachesDirectory];
        instance.todayPath = today;
        instance.todayFullPath = cachesDirectory;
        instance.defaultTimeoutInterval = 7 * 86400;
        instance.dicImage = [NSMutableDictionary new];
        NSLog(@"%@",cachesDirectory);
    }
    return instance;
}

+ (instancetype)globalCacheForUserIcon{
    NSString *today = [[NSDate date] formatToString:@"yyyy-MM-dd"];
    static DImageCache *instance;
    
    if (instance == nil || ![instance.todayPath isEqualToString:today]) {
        NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:IMAGEFORUSERICON] copy];
        cachesDirectory = [[cachesDirectory stringByAppendingPathComponent:today] copy];
        instance = [[[self class] alloc] initWithCacheDirectory:cachesDirectory withTimeoutInterval:30 * 12 * 86400];
        instance.todayPath = today;
        instance.todayFullPath = cachesDirectory;
        NSLog(@"%@",cachesDirectory);
    }
    return instance;
}

- (id)initWithCacheDirectory:(NSString*)cacheDirectory{
    if(self = [super init]){
        self.cache = [[EGOCache alloc] initWithCacheDirectory:cacheDirectory];
    }
    return self;
}

- (void)createImagePathPlistForKey:(NSString *)key type:(NSString *)strType{
    DPlistManager *plistManager = [DPlistManager shareManager];
    NSDictionary *dic;
    NSString *strImgManagerName = [NSString stringWithFormat:@"%@%@",strType,
                                   kImgPathManager];
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

- (EGOCache *)getImagePathForKey:(NSString *)key type:(NSString *)strType{
    DPlistManager *plistManager = [DPlistManager shareManager];
    NSString *strImgManagerName = [NSString stringWithFormat:@"%@%@",strType,
                                   kImgPathManager];
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
 *  根据键值移除缓存图片
 *
 *  @param key 保存图片时所使用的键值
 */
- (void)removeCacheImageByKey:(NSString *)key{
    EGOCache *cache = [self getImagePathForKey:key type:IMAGEFORNORMAL];
    if(cache){
        [cache removeCacheForKey:key];
    }
}

/**
 *  根据键值移除缓存用户头像
 *
 *  @param key 保存图片时所使用的键值
 */
- (void)removeCacheImageForUserIconByKey:(NSString *)key{
    EGOCache *cache = [self getImagePathForKey:key type:IMAGEFORUSERICON];
    if(cache){
        [cache removeCacheForKey:key];
    }
}

/**
 *  根据键值获取缓存图片
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
- (UIImage *)getCacheImageByKey:(NSString *)key{
    EGOCache *cache = [self getImagePathForKey:key type:IMAGEFORNORMAL];
    if([_dicImage objectForKey:key] && [_dicImage objectForKey:key] != kNull){
        return [_dicImage objectForKey:key];
    }
    if(cache){
        UIImage *img = [cache imageForKey:key];
        if(_dicImage.allKeys.count > 30){
            NSMutableArray *arrKey = [NSMutableArray new];
            [arrKey addObjectsFromArray:_dicImage.allKeys];
            for (int i = 0; i < (arrKey.count - 15); i++) {
                [_dicImage removeObjectForKey:[arrKey objectAtIndex:i]];
            }
        }
        if(img){
            [_dicImage setObject:img forKey:key];
        }
        return img;
    }
    return nil;
}

/**
 *  根据键值获取缓存用户头像
 *
 *  @param key 保存图片时所使用的键值
 *
 *  @return 返回缓存图片
 */
- (UIImage *)getCacheImageForUserIconByKey:(NSString *)key{
    EGOCache *cache = [self getImagePathForKey:key type:IMAGEFORUSERICON];
    if(cache){
        return [cache imageForKey:key];
    }
    return nil;
}

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 */
- (void)setCacheImage:(UIImage *)image forKey:(NSString *)key{
    [self createImagePathPlistForKey:key type:IMAGEFORNORMAL];
    [self setImage:image forKey:key];
}

/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 */
- (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key{
    [self createImagePathPlistForKey:key type:IMAGEFORUSERICON];
    [self setImage:image forKey:key];
}

/**
 *  缓存图片
 *
 *  @param image 需要缓存的图片
 *  @param key   获取缓存图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheImage:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self createImagePathPlistForKey:key type:IMAGEFORNORMAL];
    [self setImage:image forKey:key withTimeoutInterval:timeoutInterval];
}


/**
 *  缓存头像图片
 *
 *  @param image 需要缓存的头像图片
 *  @param key   获取缓存头像图片时需要使用的键值
 *  @param timeoutInterval 缓存时长
 */
- (void)setCacheImageForUserIcon:(UIImage *)image forKey:(NSString *)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self createImagePathPlistForKey:key type:IMAGEFORUSERICON];
    [self setImage:image forKey:key withTimeoutInterval:timeoutInterval];
}


@end
