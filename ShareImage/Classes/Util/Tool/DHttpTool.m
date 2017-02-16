//
//  DHttpTool.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHttpTool.h"

@implementation DHttpTool
/// 获取文本内容是否含有链接
+ (NSArray *)getUrlWithStrContent:(NSString *)strContent{
    NSMutableArray *arrUrl = [NSMutableArray array];
    if(strContent && strContent.length > 0)
    {
        NSString *regulaStr = @"((http[s]{0,1}|ftp|ywq)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                               options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *arrayOfAllMatches = [regex matchesInString:strContent
                                                    options:0
                                                      range:NSMakeRange(0, [strContent length])];
        
        for (NSTextCheckingResult *match in arrayOfAllMatches)
        {
            NSString* substringForMatch = [strContent substringWithRange:match.range];
            [arrUrl addObject:substringForMatch];
        }
    }
    return arrUrl;
}

@end
