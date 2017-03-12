//
//  DEditProfileMsgController.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"

@interface DEditProfileMsgController : DBaseViewController


@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@property (nonatomic, copy) NSStringBlock contentBlock;

@end
