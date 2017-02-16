//
//  DUserModel.m
//  DFrame
//
//  Created by DaiSuke on 16/10/10.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import "DUserModel.h"

@implementation DUserModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"n"]){
        _name = value;
    }
    else if([key isEqualToString:@"c"]){
        _company = value;
    }
    else if([key isEqualToString:@"m"]){
        _mobile = value;
    }
    else{
        DLog(@"TGUserModel Undefined Key: %@", key);
    }
}

@end
