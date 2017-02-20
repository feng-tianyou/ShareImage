//
//  DCommonTool.h
//  DFrame
//
//  Created by DaiSuke on 16/8/29.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCommonTool : NSObject

/**
 *  当然线程是否是主线程
 *
 *  @return YES主线程 | NO 子线程
 */
+ (BOOL)cureentThreadIsMain;


/**
 *  NSData类型转Int
 *
 *  @param data NSData 二进制数据
 *
 *  @return int类型数字
 */
+ (int)intNumberFromData:(NSData *)data;

/**
 *  Int类型转NSData
 *
 *  @param aNumber int类型数字
 *
 *  @return NSData 二进制数据
 */
+ (NSData *)dataFromInt:(int)aNumber;



+ (void)needQuake;

+(DeviceType)getDeviceType;


//获取聊天最大长度边距
+ (CGFloat)getChatMaxContentSpace;


+ (NSString *)intToBinary:(int)intValue;



@end
