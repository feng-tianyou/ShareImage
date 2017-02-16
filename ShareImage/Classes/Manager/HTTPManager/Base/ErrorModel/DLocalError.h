//
//  DLocalError.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLocalError : NSObject

//提示类型，yes：弹自定义提示控件 no：弹提示对话框
@property (nonatomic,assign) BOOL isAlertFor2Second;
//显示提示标题（标题不存在时不显示）
@property (nonatomic,copy)  NSString *titleText;
//显示提示内容
@property (nonatomic,copy)  NSString *alertText;
//错误码
@property (nonatomic,assign)  NSInteger errCode;

- (id)initWithAlertFor2Second:(BOOL)isAlertFor2Second
                    titleText:(NSString *)titleText
                    alertText:(NSString *)alertText;

@end
