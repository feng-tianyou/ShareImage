//
//  DBaseCache.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBaseCache.h"
#import "EGOCache.h"

@implementation DBaseCache

// Global cache for easy use
+ (id)globalCache{
    static DBaseCache *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DBaseCache alloc] init];
        //        instance.dicCache = [[NSMutableDictionary alloc] init];
    });
    return instance;
}

// Opitionally create a different EGOCache instance with it's own cache directory
- (id)initWithCacheDirectory:(NSString*)cacheDirectory withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    if(self = [super init]){
        //        _cacheDir = cacheDirectory;
        _cache = [[EGOCache alloc] initWithCacheDirectory:cacheDirectory];
        [_cache setDefaultTimeoutInterval:timeoutInterval];
    }
    return self;
}

- (EGOCache *)cache{
    if(_cache == nil){
        _cache = [EGOCache globalCache];
    }
    return _cache;
}

- (void)clearCache{
    [self.cache clearCache];
}

- (void)removeCacheForKey:(NSString*)key{
    [self.cache removeCacheForKey:key];
}

- (BOOL)hasCacheForKey:(NSString*)key{
    return [self.cache hasCacheForKey:key];
}

- (NSData*)dataForKey:(NSString*)key{
    return [self.cache dataForKey:key];
}

- (void)setData:(NSData*)data forKey:(NSString*)key{
    if(data == nil){
        data = [NSData new];
    }
    [self.cache setData:data forKey:key];
}

- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    if(data == nil){
        data = [NSData new];
    }
    [self.cache setData:data forKey:key withTimeoutInterval:timeoutInterval];
}

- (NSString*)stringForKey:(NSString*)key{
    return [self.cache stringForKey:key];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key{
    [self.cache setString:aString forKey:key];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self.cache setString:aString forKey:key withTimeoutInterval:timeoutInterval];
}

- (NSDate*)dateForKey:(NSString*)key{
    return [self.cache dateForKey:key];
}

- (NSArray*)allKeys{
    return [self.cache allKeys];
}


- (UIImage*)imageForKey:(NSString*)key{
    return [self.cache imageForKey:key];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key{
    [self.cache setImage:anImage forKey:key];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self.cache setImage:anImage forKey:key withTimeoutInterval:timeoutInterval];
}

- (NSData*)plistForKey:(NSString*)key{
    return [self.cache plistForKey:key];
}

- (void)setPlist:(id)plistObject forKey:(NSString*)key{
    [self.cache setPlist:plistObject forKey:key];
}

- (void)setPlist:(id)plistObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self.cache setPlist:plistObject forKey:key withTimeoutInterval:timeoutInterval];
}

- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key{
    [self.cache copyFilePath:filePath asKey:key];
}

- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self.cache copyFilePath:filePath asKey:key withTimeoutInterval:timeoutInterval];
}

- (id<NSCoding>)objectForKey:(NSString*)key{
    return [self.cache objectForKey:key];
}

- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key{
    [self.cache setObject:anObject forKey:key];
}

- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self.cache setObject:anObject forKey:key withTimeoutInterval:timeoutInterval];
}


@end
