//
//  DBlockTool.h
//  DFrame
//
//  Created by DaiSuke on 16/10/9.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBlockTool : NSObject

+ (void)executeErrorBlock:(ErrorBlock)errorBlock errorText:(NSString *)errorText;

+ (void)executeErrorBlock:(ErrorBlock)errorBlock error:(DError *)error;

+ (void)executeVoidBlock:(VoidBlock)voidBlock;

+ (void)executeLongLongBlock:(LongLongBlock)longLongBlock result:(long long)result;

+ (void)executeBoolBlock:(BoolBlock)boolBlock result:(BOOL)result;

+ (void)executeNSIntegerBlock:(NSIntegerBlock)integerBlock result:(NSInteger)result;

+ (void)executeStrBlock:(NSStringBlock)strBlock result:(NSString *)result;

+ (void)executeArrBlock:(NSArrayBlock)arrBlock arrResult:(NSArray *)arrResult;

+ (void)executeModelBlock:(JsonModelBlock)modelBlock model:(DJsonModel *)model;

@end
