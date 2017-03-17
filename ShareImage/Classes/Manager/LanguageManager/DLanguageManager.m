//
//  DLanguageManager.m
//  ShareImage
//
//  Created by FTY on 2017/3/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DLanguageManager.h"

#define kNSLocalizedStringTableName @"Localizable"
#define kUserLanguage @"userLanguage"

@interface DLanguageManager ()

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation DLanguageManager

+ (instancetype)shareInstance{
    static DLanguageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - private

/**
 保存语言

 @param language 语言
 */
- (void)saveLanguage:(NSString *)language{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language forKey:kUserLanguage];
    [defaults synchronize];
}


/**
 改变bundle

 @param language 当前语言
 */
- (void)changeBundle:(NSString *)language{
    // 改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:language] ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}


/**
 初始化语言
 */
- (void)initUserLanguage{
    NSString *currentLanguage = [self currentLanguage];
    if (currentLanguage.length == 0) {
        // 获取系统偏好的语言数组
        NSArray *languages = [NSLocale preferredLanguages];
        // 第一个为当前语言
        currentLanguage = [languages firstObject];
        
        // 设置当前语言
        [self saveLanguage:currentLanguage];
    }
    // 改变budle
    [self changeBundle:currentLanguage];
}


#pragma mark - public

/**
 获取当前语言

 @return 语言
 */
- (NSString *)currentLanguage{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [defaults objectForKey:kUserLanguage];
    return language;
}

/**
 语言和语言对应的.lproj的文件夹前缀不一致时，在这里做处理

 @param language 语言
 @return 语言
 */
- (NSString *)languageFormat:(NSString *)language{
    if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
        return @"zh-Hans";
    } else if ([language rangeOfString:@"zh-Hant"].location != NSNotFound){
        return @"zh-Hant";
    } else {
        // 字符串查找
        if ([language rangeOfString:@"-"].location != NSNotFound) {
            // 除了中文意外的其他语言同意处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *arr = [language componentsSeparatedByString:@"-"];
            if (arr.count > 1) {
                NSString *str = [arr firstObject];
                return str;
            }
        }
    }
    return language;
}


@end
