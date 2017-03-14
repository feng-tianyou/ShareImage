//
//  DEditProfileMsgController.h
//  ShareImage
//
//  Created by DaiSuke on 2017/3/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DBaseViewController.h"
#import "DTextField.h"

@interface DEditProfileMsgController : DBaseViewController


@property (nonatomic, strong) DTextField *textField;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UITextView *textView;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content indexPatch:(NSIndexPath *)indexPatch;


@end
