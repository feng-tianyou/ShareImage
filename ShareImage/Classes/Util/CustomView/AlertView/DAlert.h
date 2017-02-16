//
//  DAlert.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAlert : NSObject
+(void)show:(NSString *)str;

+(void)show:(NSString *)str hasSuccessIcon:(BOOL)hasSuccessIcon AndShowInView:(UIView *)parentView;

@end
