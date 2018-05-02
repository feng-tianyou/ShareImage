//
//  NSString+DNSString.h
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DNSString)
/**
 *  计算字符串的范围
 *
 *  @param font     字体大小
 *  @param maxWidth 最大宽度
 *
 *  @return size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeCustomWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

#pragma mark - 加密相关

- (NSString *)myMD5;

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1;

#pragma mark - 时间相关
/**
 *  格式化成日期
 *
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 日期
 */
- (NSDate *)formatToDate:(NSString *)dateFormat;

/**
 *  格式化成日期字符串
 *
 *  @param dateFormat 日期格式，例 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 日期字符串
 */
- (NSString *)formatToDateString:(NSString *)dateFormat;

/**
 *  两个日期相差的天数
 *
 *  @param dateFormat 日期格式，例 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 相差的天数
 */
- (int)differDateFormatToDateString:(NSString *)dateFormat;

/**
 *  计算指定时间与当前的时间差
 *
 *  @param compareDateString  时间字符串(格式:2013-3-2 8:28:53)
 *
 *  @return (比如，3分钟前，1个小时前，2015年1月10日)
 *
 *  ADD BY ZHANGZH
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDateString;

#pragma mark - 其他相关

/**
 *  获取字符串（或汉字）首字母
 *
 *  @param string 字符串
 *
 *  @return 首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *)string;

/**
 *  将字符串数组按照元素首字母顺序进行排序分组
 *
 *  @param arrary 字符串数组
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArrary:(NSArray *)arrary;

/**
 *  移除指定位置的字符，可兼容emoji表情的情况（一个emoji表情占1-4个length）
 *  @param index 要删除的位置
 */
- (NSString *)stringByRemoveCharacterAtIndex:(NSUInteger)index;
/**
 *  移除最后一个字符，可兼容emoji表情的情况（一个emoji表情占1-4个length）
 *  @see `stringByRemoveCharacterAtIndex:`
 */
- (NSString *)stringByRemoveLastCharacter;

#pragma mark - 正则验证
/// 验证邮箱是否合法
- (BOOL)isEmailAddress;


#pragma mark - 数据转换
/**
 普通字符串成转换为十六进制字符串
 
 @return 十六进制字符串
 */
- (NSString *)stringTo16String;

/**
 十六进制字符串转换为数值
 
 @return 对于的数值
 */
- (unsigned long)longNumberFromHexString;

/**
 格式话小数 四舍五入类型 “0.000”
 
 @param format “0.000”
 @param numberValue 需要转的值
 @return 字符串
 */
+ (NSString *)decimalwithFormat:(NSString *)format numberValue:(NSNumber *)numberValue;

#pragma mark - 字符串判断相关
/**
 *  判断字符串中是否含有空格
 *
 *  @return 是否含有
 */
- (BOOL)isContainsSpace;

/**
 *  判断字符串中是否含有某个字符串
 *
 *  @param string 字符串1
 *
 *  @return 是否含有
 */
- (BOOL)isContainsString:(NSString *)string;


/**
 *  判断是否只包含字母和数字,并且是6-20位数
 *
 *
 *  @return NO代表不符合条件，YES代表符合条件
 */
- (BOOL)isOnlyContainsNumAndChar;

/**
 判断是否否含汉字
 
 @return NO代表字符串包含不是汉字的字符，YES代表全部为汉字
 */
- (BOOL)isContainsChinese;

/**
 判断是否否含汉字
 
 @return NO代表字符串包含不是汉字的字符，YES代表全部为汉字
 */
- (BOOL)isAllChinese;

/**
 *  判断字符串是否全部为数字
 *
 *  @return 是否
 */
- (BOOL)isAllNum;


/**
 判断是否含有数字
 
 @return bool
 */
- (BOOL)isContainsNumber;

/**
 是否包含表情字符
 
 @return bool
 */
- (BOOL)isContainsEmoji;

/**
 文本内容是否含有电话号码
 
 @return 电话号码
 */
- (NSArray *)isContainsMobile;

#pragma mark - 数据对象类型转换
/**
 json字符串转字典
 
 @return 字典
 */
- (NSDictionary *)stringJsonChangeDictionary;

/**
 json转数组
 
 @return 数组
 */
- (NSArray *)stringJsonChangeArray;

/**
 字典转json字符串
 
 @param dictionary 字典
 @return json字符串
 */
+ (NSString *)stringJsonWithDictionary:(NSDictionary *)dictionary;

/**
 数组转json字符串
 
 @param array 数组
 @return json字符串
 */
+ (NSString *)stringJsonWithArray:(NSArray *)array;

@end
