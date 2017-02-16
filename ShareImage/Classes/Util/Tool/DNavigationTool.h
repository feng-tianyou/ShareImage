//
//  DNavigationTool.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNavigationTool : NSObject

+ (UIImage *)getNavigationBarRightImgByType:(DNavigationItemType)type;
+ (NSString *)getNavigationBarRightTitleByType:(DNavigationItemType)type;

@end
