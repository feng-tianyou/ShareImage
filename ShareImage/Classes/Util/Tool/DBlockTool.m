//
//  DBlockTool.m
//  DFrame
//
//  Created by DaiSuke on 16/10/9.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DBlockTool.h"

@implementation DBlockTool

+ (void)executeErrorBlock:(ErrorBlock)errorBlock errorText:(NSString *)errorText{
    ExistActionDo(errorBlock, errorBlock([DError getErrorByAlertText:errorText]);)
}

+ (void)executeErrorBlock:(ErrorBlock)errorBlock error:(DError *)error{
    ExistActionDo(errorBlock, errorBlock(error);)
}

+ (void)executeVoidBlock:(VoidBlock)voidBlock{
    ExistActionDo(voidBlock, voidBlock());
}

+ (void)executeLongLongBlock:(LongLongBlock)longLongBlock result:(long long)result{
    ExistActionDo(longLongBlock, longLongBlock(result));
}

+ (void)executeBoolBlock:(BoolBlock)boolBlock result:(BOOL)result{
    ExistActionDo(boolBlock, boolBlock(result));
}

+ (void)executeNSIntegerBlock:(NSIntegerBlock)integerBlock result:(NSInteger)result{
    ExistActionDo(integerBlock, integerBlock(result));
}

+ (void)executeStrBlock:(NSStringBlock)strBlock result:(NSString *)result{
    ExistActionDo(strBlock, strBlock(result));
}

+ (void)executeArrBlock:(NSArrayBlock)arrBlock arrResult:(NSArray *)arrResult{
    ExistActionDo(arrBlock, arrBlock(arrResult));
}

+ (void)executeModelBlock:(JsonModelBlock)modelBlock model:(DJsonModel *)model{
    ExistActionDo(modelBlock, modelBlock(model));
}


@end
