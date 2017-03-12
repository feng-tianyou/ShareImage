//
//  DEditProfileMsgController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DEditProfileMsgController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface DEditProfileMsgController ()
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *titleStr;

@end

@implementation DEditProfileMsgController

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    self = [super init];
    if (self) {
        self.title = title;
        self.titleStr = title;
        self.content = content;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightSave;
    self.view.backgroundColor = [UIColor setHexColor:@"#f3f3f3"];
    
    [self.view addSubview:self.textField];
    self.textField.sd_layout
    .topSpaceToView(self.view, 15+self.navBarHeight)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(44);
    
    self.textField.text = self.content;
    
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    if (isLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.contentBlock && self.textField.text.length > 0) {
            self.contentBlock(self.textField.text);
        } else {
            [SVProgressHUD showErrorWithStatus:@"Please Input!"];
            [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        }
    }
}


#pragma mark - getter & setter
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = DSystemFontText;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textColor = [UIColor setHexColor:@"#bbbbbb"];
        _textField.placeholder = [NSString stringWithFormat:@"Input Your %@", self.titleStr];
        _textField.backgroundColor = [UIColor whiteColor];
        [_textField.layer setBorderWidth:0.5];
        [_textField.layer setBorderColor:[UIColor grayColor].CGColor];
        [_textField.layer setCornerRadius:5.0];
        [_textField.layer setMasksToBounds:YES];
    }
    return _textField;
}


@end
