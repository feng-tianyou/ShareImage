//
//  DCommonTool.m
//  DFrame
//
//  Created by DaiSuke on 16/8/29.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DCommonTool.h"
#import "DCacheManager.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation DCommonTool

/**
 *  当然线程是否是主线程
 *
 *  @return YES主线程 | NO 子线程
 */
+ (BOOL)cureentThreadIsMain
{
    return [[NSThread currentThread] isMainThread];
}


//data 转int
+ (int)intNumberFromData:(NSData *)data
{
    NSAssert(data, @"intNumberFromData -> data not be nil");
    int i = -1;
    [data getBytes:&i length:sizeof(i)];
    return i;
}

//int 转data
+ (NSData *)dataFromInt:(int)aNumber
{
    return [NSData dataWithBytes:&aNumber length:sizeof(aNumber)];
}


#define D_TOOLS_QUAKE_KEY       @"quake_key"
#define KVIEW_KEY_DATE          @"error_date"
#define kVIEW_ERROR_SAVE_TIME   86400
+ (void)needQuake{
    NSDictionary *dicError = (NSDictionary *)[DCacheManager getCacheObjectForKey:D_TOOLS_QUAKE_KEY];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if(dicError){
        NSDate *date = [NSDate date];
        NSDate *lastDate = [dicError objectForKey:KVIEW_KEY_DATE];
        DLog(@"%@",@([date timeIntervalSinceDate:lastDate]));
        if(lastDate && [date timeIntervalSinceDate:lastDate] < 10){
            return;
        }
        
    }
    [dic setObject:[NSDate date] forKey:KVIEW_KEY_DATE];
    [DCacheManager setCacheObjectByData:dic forKey:D_TOOLS_QUAKE_KEY withTimeoutInterval:kVIEW_ERROR_SAVE_TIME];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    DLog(@"Quake");
}

+(DeviceType)getDeviceType

{
    DeviceType type;
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat height=bounds.size.height;
    CGFloat scale=[UIScreen mainScreen].scale;
    
    if(height < 667){
        type = DeviceTypeFor5SAndAbove;
    }
    else if(scale < 2.9){
        type = DeviceTypeFor6;
    }
    else{
        type = DeviceTypeFor6p;
    }
    return type;
}

//获取聊天最大长度边距
+ (CGFloat)getChatMaxContentSpace{
    CGFloat space = 0;
    DeviceType type = [DCommonTool getDeviceType];
    switch (type) {
        case DeviceTypeFor5SAndAbove:{
            
            break;
        }
        case DeviceTypeFor6:{
            space = 20;
            break;
        }
        case DeviceTypeFor6p:{
            space = 30;
            break;
        }
        default:
            break;
    }
    return space;
}

//获取
+ (CGFloat)getSubViewWidth:(CGFloat)width{
    CGFloat newWidth = width;
    DeviceType type = [DCommonTool getDeviceType];
    switch (type) {
        case DeviceTypeFor5SAndAbove:{
            
            break;
        }
        case DeviceTypeFor6:{
            
            break;
        }
        case DeviceTypeFor6p:{
            newWidth *= 0.84;
            break;
        }
        default:
            break;
    }
    return newWidth;
}

+ (CGFloat)getSubViewHeight:(CGFloat)height{
    CGFloat newHeight = height;
    DeviceType type = [DCommonTool getDeviceType];
    switch (type) {
        case DeviceTypeFor5SAndAbove:{
            
            break;
        }
        case DeviceTypeFor6:{
            
            break;
        }
        case DeviceTypeFor6p:{
            newHeight *= 0.84;
            break;
        }
        default:
            break;
    }
    return newHeight;
}


+ (NSString *)intToBinary:(int)intValue{
    int byteBlock = 8,    // 每个字节8位
    totalBits = sizeof(int) * byteBlock, // 总位数（不写死，可以适应变化）
    binaryDigit = 1;  // 当前掩（masked）位
    NSMutableString *binaryStr = [[NSMutableString alloc] init];   // 二进制字串
    do
    {
        // 检出下一位，然后向左移位，附加 0 或 1
        [binaryStr insertString:((intValue & binaryDigit) ? @"1" : @"0" ) atIndex:0];
        // 若还有待处理的位（目的是为避免在最后加上分界符），且正处于字节边界，则加入分界符|
        if (--totalBits && !(totalBits % byteBlock))
            [binaryStr insertString:@"|" atIndex:0];
        // 移到下一位
        binaryDigit <<= 1;
    } while (totalBits);
    // 返回二进制字串
    return binaryStr;
}

@end
