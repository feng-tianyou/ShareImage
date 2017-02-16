//
//  NSDate+DDate.m
//  DFrame
//
//  Created by DaiSuke on 16/9/30.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "NSDate+DDate.h"

@implementation NSDate (DDate)

/**
 *  格式化日期
 *
 *  @param dateFormat 日期格式，etg：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 字符串
 */
- (NSString *)formatToString:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *returnString = [formatter stringFromDate:self];
    ARC_RELEASE(dateFormatter);
    return returnString;
}

//获取固定的时间格式的当前时间 @"yyyy-MM-dd'T'HH:mm:ss"
- (NSString *)getNowDate{
    NSString *dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSString *returnString = [formatter stringFromDate:self];
    ARC_RELEASE(dateFormatter);
    return returnString;
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

/**
 根据秒数获取小时与分钟数
 
 @param second 秒数
 
 @return 格式：x小时x分钟
 */
+ (NSString *)getHourAndMinBySecond:(NSInteger)second{
    if(second <= 0){
        return @"";
    }
    NSString *strResult = @"";
    NSInteger hour = second/3600;
    NSInteger min = (second % 3600)/60;
    if(min < 0){
        min = 1;
    }
    if(hour > 0){
        strResult = [NSString stringWithFormat:@"%@小时%@分钟",@(hour),@(min)];
    }
    else{
        strResult = [NSString stringWithFormat:@"%@分钟",@(min)];
    }
    return strResult;
}



@end
