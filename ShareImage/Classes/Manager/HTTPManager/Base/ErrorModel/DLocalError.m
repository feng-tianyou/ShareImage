//
//  DLocalError.m
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DLocalError.h"

@implementation DLocalError

- (id)initWithAlertFor2Second:(BOOL)isAlertFor2Second
                    titleText:(NSString *)titleText
                    alertText:(NSString *)alertText{
    if(self = [super init]){
        _isAlertFor2Second = isAlertFor2Second;
        _titleText = titleText;
        _alertText = alertText;
    }
    return self;
}


@end
