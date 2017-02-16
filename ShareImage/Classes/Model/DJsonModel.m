//
//  DJsonModel.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DJsonModel.h"

@implementation DJsonModel


-(id)initWithDictionary:(NSDictionary *)jsonObject
{
    self = [super init];
    if(self)
    {
        if(!jsonObject || ![[jsonObject class]isSubclassOfClass:[NSDictionary class]]){
            return self;
        }
        NSMutableDictionary *dicObject = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
        dicObject = [self proccessToDeleteNullValue:dicObject];
        [self setValuesForKeysWithDictionary:dicObject];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    DLog(@"%@ unknown-key:%@",NSStringFromClass([self class]),key);
}

#pragma mark 过滤空值字段
-(NSMutableDictionary *)proccessToDeleteNullValue:(NSMutableDictionary *)dicParam
{
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    if(dicParam)
    {
        
        for (NSString *strKey in dicParam.keyEnumerator) {
            @autoreleasepool {
                if([dicParam objectForKey:strKey] != kNull && [dicParam objectForKey:strKey]){
                    id value = [dicParam objectForKey:strKey];
                    if([value isKindOfClass:[NSArray class]]){
                        NSArray *arrValue = (NSArray *)value;
                        if(arrValue.count > 0 && [arrValue objectAtIndex:0] != kNull){
                            [dicResult setObject:value forKey:strKey];
                        }
                    }
                    else{
                        [dicResult setObject:value forKey:strKey];
                    }
                }
            }
        }
    }
    return dicResult;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    return self;
    
}

//-(BOOL)allowsKeyedCoding
//{
//	return YES;
//}

-(id)copyWithZone:(NSZone *)zone
{
    DJsonModel *newModel = [[DJsonModel allocWithZone:zone] init];
    return newModel;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    DJsonModel *newModel = [[DJsonModel allocWithZone:zone] init];
    return newModel;
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    // subclass implementation should set the correct key value mappings for custom keys
//    //    NSLog(@"Undefined Key: %@", key);
//}


-(NSArray *)proccessArrData:(NSArray *)arr
{
    if(arr && arr.count > 0)
    {
        return arr;
    }
    return @[];
}

+ (id)getModelByDic:(NSDictionary *)dic{
    if(!dic){
        return nil;
    }
    DJsonModel *model = [[self alloc] initWithDictionary:dic];
    return model;
}

+ (NSMutableArray *)getArrModelByArrDic:(NSArray *)arrDic{
    NSMutableArray *arrModel = [NSMutableArray new];
    for (NSDictionary *dicProject in arrDic.objectEnumerator) {
        @autoreleasepool {
            [arrModel addObject:[self getModelByDic:dicProject]];
        }
    }
    return arrModel;
}


@end
