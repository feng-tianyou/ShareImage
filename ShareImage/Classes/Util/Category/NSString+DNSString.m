//
//  NSString+DNSString.m
//  DFrame
//
//  Created by DaiSuke on 16/8/22.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "NSString+DNSString.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *token = @"fashfkdashfjkldashfjkdashfjkdahsfjdasjkvcxnm%^&%^$&^uireqwyi1237281643";

@implementation NSString (DNSString)





- (CGSize)sizeCustomWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize;
    if([self respondsToSelector:@selector(sizeWithAttributes:)]){
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
        resultSize.width = ceilf(rect.size.width);
        resultSize.height = ceilf(rect.size.height);
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    return resultSize;
}


- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size;
}

- (CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxWidth:MAXFLOAT];
}




#pragma mark - 加密字符串
- (NSString *)myMD5
{
    NSString *str = [NSString stringWithFormat:@"%@%@", self, token];
    
    return [str MD5];
}

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (uint32_t)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

- (NSString *)SHA1
{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

#pragma mark - 时间相关
/**
 *  格式化成日期
 *
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 日期
 */
- (NSDate *)formatToDate:(NSString *)dateFormat
{
    NSString *strDate = self;
    if(strDate.length > 23){
        strDate = [strDate substringToIndex:23];
    }
    NSDateFormatter *formatter = KGLOBALINFOMANAGER.formatter;
    [formatter setDateFormat:dateFormat];
    NSDate *returnDate= [formatter dateFromString:strDate];
    if(returnDate == nil){
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        returnDate = [formatter dateFromString:strDate];
    }
    if(returnDate == nil){
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        returnDate = [formatter dateFromString:strDate];
    }
    
    if(returnDate == nil){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        returnDate= [formatter dateFromString:strDate];
    }
    if(returnDate == nil){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnDate= [formatter dateFromString:strDate];
    }
    
    return returnDate;
}

/**
 *  格式化成日期字符串
 *
 *  @param dateFormat 日期格式，例 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 日期字符串2017-02-19T17:48:42-05:00
 */
- (NSString *)formatToDateString:(NSString *)dateFormat
{
    NSString *strDate = self;
    if(strDate.length > 23){
        strDate = [strDate substringToIndex:19];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date= [formatter dateFromString:strDate];
    if(date == nil){
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        date= [formatter dateFromString:strDate];
    }
    if(date == nil){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        date= [formatter dateFromString:strDate];
    }
    if(date == nil){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        date= [formatter dateFromString:strDate];
    }
    if(date == nil){
        [formatter setDateFormat:@"yyyy-MM-dd"];
        date= [formatter dateFromString:strDate];
    }
    [formatter setDateFormat:dateFormat];
    NSString *dateString= [formatter stringFromDate:date];
    if(!dateString){
        dateString = @"";
    }
    return dateString;
}

/**
 *  两个日期相差的天数
 *
 *  @param dateFormat 日期格式，例 @"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 相差的天数
 */
- (int)differDateFormatToDateString:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //结束时间
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *endDate= [formatter dateFromString:self];
    
    //当前的时间
    [formatter setDateFormat:dateFormat];
    NSDate *senderDate=[NSDate date];
    [formatter dateFromString:[formatter stringFromDate:senderDate]];
    
    //相差的秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
    
    int days=((int)time)/(3600*24);
    
    if(days<=0)
    {
        return 0;
    }
    else
    {
        return days;
    }
}

/**
 *  计算指定时间与当前的时间差
 *
 *  @param compareDateString  时间字符串(格式:2013-3-2 8:28:53)
 *
 *  @return (比如，3分钟前，1个小时前，2015年1月10日)
 *
 *  ADD BY ZHANGZH
 */
+ (NSString *)compareCurrentTime:(NSString *)compareDateString{
    if(compareDateString.length > 23){
        compareDateString = [compareDateString substringToIndex:23];
    }
    
    //把时间字符串转化为NSDate
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *compareDate = [formatter dateFromString:compareDateString];
    if(compareDate==nil)
    {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        compareDate= [formatter dateFromString:compareDateString];;
    }
    
    NSTimeInterval timeInterval=[compareDate timeIntervalSinceNow];
    timeInterval=-timeInterval;
    long temp=0;
    NSString *compareResult;
    if(timeInterval<60)
    {
        compareResult=[NSString stringWithFormat:@"1分钟前"];
    }
    else if((temp=timeInterval/60)<60)
    {
        compareResult=[NSString stringWithFormat:@"%i分钟前",(int)temp];
    }
    else if((temp=temp/60)<24)
    {
        compareResult=[NSString stringWithFormat:@"%i小时前",(int)temp];
    }
    //    else if((temp=temp/24)<30)
    //    {
    //        [formatter setDateFormat:@"MM-dd HH:mm"];
    //        compareResult=[formatter stringFromDate:compareDate];
    //    }
    //    else if((temp=temp/30)<12)
    //    {
    //        [formatter setDateFormat:@"MM-dd"];
    //        compareResult=[formatter stringFromDate:compareDate];
    //    }
    else
    {
        //        temp=temp/12;
        //        [formatter setDateFormat:@"yyyy-MM-dd"];
        compareResult = @"一天前";
    }
    return compareResult;
}

#pragma mark - 其他
/**
 *  获取字符串（或汉字）首字母
 *
 *  @param string 字符串
 *
 *  @return 首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingpin = [str capitalizedString];
    return [pingpin substringToIndex:1];
}


/**
 *  将字符串数组按照元素首字母顺序进行排序分组
 *
 *  @param arrary 字符串数组
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryOrderByCharacterWithOriginalArrary:(NSArray *)arrary{
    if (arrary.count == 0) {
        return nil;
    }
    
    for (id obj in arrary) {
        if (![obj isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    
    UILocalizedIndexedCollation *indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    // 创建27个分组数组
    for (int i = 0; i<indexedCollation.sectionTitles.count; i++) {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    
    // 按字母顺序排序进行分组
    NSInteger lastIndex = -1;
    for ( int i = 0; i < arrary.count; i++) {
        NSInteger index = [indexedCollation sectionForObject:arrary[i] collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:arrary[i]];
        lastIndex = index;
    }
    
    // 去掉空数组
    for (int i = 0; i < objects.count; i++) {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0) {
            [objects removeObject:obj];
        }
    }
    
    // 获取索引字母
    for (NSMutableArray *obj in objects) {
        NSString *str = obj[0];
        NSString *key = [self firstCharacterWithString:str];
        [keys addObject:key];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:objects forKey:keys];
    return dic;
}


/**
 *  移除指定位置的字符，可兼容emoji表情的情况（一个emoji表情占1-4个length）
 *  @param index 要删除的位置
 */
- (NSString *)stringByRemoveCharacterAtIndex:(NSUInteger)index {
    NSRange rangeForRemove = [self rangeOfComposedCharacterSequenceAtIndex:index];
    NSString *resultString = [self stringByReplacingCharactersInRange:rangeForRemove withString:@""];
    return resultString;
}
/**
 *  移除最后一个字符，可兼容emoji表情的情况（一个emoji表情占1-4个length）
 *  @see `stringByRemoveCharacterAtIndex:`
 */
- (NSString *)stringByRemoveLastCharacter {
    return [self stringByRemoveCharacterAtIndex:self.length - 1];
}

#pragma mark - 数据转换

/**
 普通字符串成转换为十六进制字符串

 @return 十六进制字符串
 */
- (NSString *)stringTo16String{
    NSAssert(self, @"stringTo16String -> string not be nil");
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[data bytes];
    NSString *str16 = nil;
    for(int i=0;i<[data length];i++)  {
        @autoreleasepool {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];//16进制数
            if([newHexStr length] == 1){
                str16 = [NSString stringWithFormat:@"%@0%@",str16,newHexStr];
            } else{
                str16 = [NSString stringWithFormat:@"%@%@",str16,newHexStr];
            }
        }
    }
    return str16;
}


/**
 十六进制字符串转换为数值

 @return 对于的数值
 */
- (unsigned long)longNumberFromHexString{
    NSAssert(self, @"longNumberFromHexString -> hexString not be nil");
    //   strtoul(const char *nptr,char **endptr,int base);会将参数nptr字符串根据参数base来转换成无符号的长整型数。
    return strtoul([self UTF8String],0,0);
}

/**
 格式话小数 四舍五入类型 “0.000”

 @param format “0.000”
 @param numberValue 需要转的值
 @return 字符串
 
 */
+ (NSString *)decimalwithFormat:(NSString *)format numberValue:(NSNumber *)numberValue{
    float value = [numberValue floatValue];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:value]];
}

/**
 *  获取带****的手机号码
 *
 *  @param mobile 原手机号码
 *
 *  @return 带****的手机号码
 */
+ (NSString *)getSubMobile:(NSString *)mobile{
    NSMutableString *strMobile = [NSMutableString new];
    [strMobile appendString:[mobile substringToIndex:3]];
    [strMobile appendString:@"****"];
    [strMobile appendString:[mobile substringFromIndex:7]];
    return strMobile;
}

#pragma mark - 字符串判断相关
/**
 *  判断字符串中是否含有空格
 *
 *  @return 是否含有
 */
- (BOOL)isContainsSpace{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

/**
 *  判断字符串中是否含有某个字符串
 *
 *  @param string 字符串1
 *
 *  @return 是否含有
 */
- (BOOL)isContainsString:(NSString *)string{
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}



/**
 *  判断是否只包含字母和数字,并且是6-20位数
 *
 *
 *  @return NO代表不符合条件，YES代表符合条件
 */
- (BOOL)isOnlyContainsNumAndChar{
    if(self.length>0)
    {
        NSString *regex=@"[0-9a-zA-Z]{6,20}";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        if([predicate evaluateWithObject:self] == YES) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}



/**
 *  判断字符串中是否含有中文
 *
 *  @return 是否含有
 */
- (BOOL)isContainsChinese{
    for (int i = 0; i < self.length; i++) {
        int a = [self characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}


/**
  判断是否否含汉字

 @return NO代表字符串包含不是汉字的字符，YES代表全部为汉字
 */
- (BOOL)isAllChinese{
    if(self && self.length > 0) {
        for (int index=0; index<self.length; index++) {
            NSRange range=NSMakeRange(index, 1);
            NSString *subString=[self substringWithRange:range];
            const char *cString=[subString UTF8String];
            if(!cString || strlen(cString)==1) {
                return NO;
            }
        }
        return YES;
    }
    else {
        return NO;
    }
}

/**
 *  判断字符串是否全部为数字
 *
 *
 *  @return 是否
 */
- (BOOL)isAllNum{
    unichar c;
    for (int i = 0; i < self.length; i++) {
        c = [self characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}


/**
 判断是否含有数字

 @return bool
 */
- (BOOL)isContainsNumber{
    NSString * regex = @"^[0-9]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}



/**
 是否包含表情字符

 @return bool
 */
- (BOOL)isContainsEmoji{
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     isEomji = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
     }];
    return isEomji;
}


/**
 文本内容是否含有电话号码

 @return 电话号码
 */
- (NSArray *)isContainsMobile{
    NSMutableArray *arrUrl = [NSMutableArray array];
    if(self && self.length > 0)
    {
        NSString *regulaStr = @"\\d{7,23}";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *arrayOfAllMatches = [regex matchesInString:self
                                                    options:0
                                                      range:NSMakeRange(0, [self length])];
        
        for (NSTextCheckingResult *match in arrayOfAllMatches) {
            NSString* substringForMatch = [self substringWithRange:match.range];
            [arrUrl addObject:substringForMatch];
        }
    }
    return [arrUrl copy];
}



#pragma mark - 数据对象类型转换
/**
 json字符串转字典

 @return 字典
 */
- (NSDictionary *)stringJsonChangeDictionary{
    if(self.length == 0){
        return @{};
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dic;
}

/**
 json转数组

 @return 数组
 */
- (NSArray *)stringJsonChangeArray{
    if(self.length == 0){
        return @[];
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return arr;
}


/**
 字典转json字符串

 @param dictionary 字典
 @return json字符串
 */
+ (NSString *)stringJsonWithDictionary:(NSDictionary *)dictionary{
    NSString *strJson = @"";
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:nil];
    if(data.length > 0){
        strJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return strJson;
}

/**
 数组转json字符串
 
 @param array 数组
 @return json字符串
 */
+ (NSString *)stringJsonWithArray:(NSArray *)array{
    NSString *strJson = @"";
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:kNilOptions error:nil];
    if(data.length > 0){
        strJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return strJson;
}













@end
