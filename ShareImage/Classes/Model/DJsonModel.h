//
//  DJsonModel.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJsonModel : NSObject<NSCoding,NSCopying,NSMutableCopying>

-(id)initWithDictionary:(NSDictionary *)jsonObject;

#pragma mark 过滤空值字段
-(NSMutableDictionary *)proccessToDeleteNullValue:(NSMutableDictionary *)dicParam;

-(NSArray *)proccessArrData:(NSArray *)arr;

+ (id)getModelByDic:(NSDictionary *)dic;

+ (NSMutableArray *)getArrModelByArrDic:(NSArray *)arrDic;

@end
