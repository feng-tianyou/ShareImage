//
//  DHttpTool.h
//  DFrame
//
//  Created by DaiSuke on 2017/1/16.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHttpTool : NSObject
/// 获取文本内容是否含有链接
+ (NSArray *)getUrlWithStrContent:(NSString *)content;

@end
