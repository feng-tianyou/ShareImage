//
//  DEditProfileMsgController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DEditProfileMsgController.h"
#import <SVProgressHUD/SVProgressHUD.h>

#import "DUserAPIManager.h"
#import "DUserParamModel.h"

@interface DEditProfileMsgController ()
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSIndexPath *indexPatch;

@end

@implementation DEditProfileMsgController

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content indexPatch:(NSIndexPath *)indexPatch{
    self = [super init];
    if (self) {
        self.title = title;
        self.titleStr = title;
        self.content = content;
        self.indexPatch = indexPatch;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navLeftItemType = DNavigationItemTypeBack;
    self.navRighItemType = DNavigationItemTypeRightSave;
    self.view.backgroundColor = DSystemColorGrayF3F3F3;
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.textField];
    [self.view addSubview:self.tipLabel];
    
    
    [self setupSubViews];
    [self setupData];
    
}


#pragma mark - private
- (void)setupSubViews{
    self.bgView.sd_layout
    .topSpaceToView(self.view, 15+self.navBarHeight)
    .leftSpaceToView(self.view, -1)
    .rightSpaceToView(self.view, -1)
    .heightIs(44);
    
    self.textField.sd_layout
    .topEqualToView(self.bgView)
    .leftSpaceToView(self.bgView, 15)
    .rightSpaceToView(self.bgView, 15)
    .bottomEqualToView(self.bgView);
    
    self.tipLabel.sd_layout
    .topSpaceToView(self.bgView, 10)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(20);
}

- (void)setupData{
    self.textField.text = self.content;
    [self.textField becomeFirstResponder];
    
    if (self.indexPatch.section == 1) {
        self.tipLabel.hidden = NO;
        if (self.indexPatch.row == 0) {
            self.tipLabel.text = @"The Format Of The Mailbox Must Be Correct";
        } else {
            self.tipLabel.text = @"By the English、Number、 _ Composition";
        }
    }
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.textField resignFirstResponder];
    if (isLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.textField.text.length > 0) {
            DUserAPIManager *manager = [DUserAPIManager getHTTPManagerByDelegate:self info:self.networkUserInfo];
            DUserParamModel *paramModel = [[DUserParamModel alloc] init];
            switch (self.indexPatch.section) {
                case 0:
                {
                    switch (self.indexPatch.row) {
                        case 0:
                            paramModel.username = self.textField.text;
                            break;
                        case 1:
                            paramModel.first_name = self.textField.text;
                            break;
                        case 2:
                            paramModel.last_name = self.textField.text;
                            break;
                            
                        default:
                            break;
                    }
                }
                    break;
                case 1:
                {
                    switch (self.indexPatch.row) {
                        case 0:
                            paramModel.email = self.textField.text;
                            break;
                        case 1:
                            if ([self.textField.text isContainsChinese]) {
                                [SVProgressHUD setMinimumDismissTimeInterval:1.5];
                                [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
                                [SVProgressHUD showErrorWithStatus:@"Instagram Username Is Contains Chinese!"];
                                return;
                            }
                            paramModel.instagram_username = self.textField.text;
                            break;
                            
                        default:
                            break;
                    }
                }
                    break;
                case 2:
                {
                    switch (self.indexPatch.row) {
                        case 0:
                            paramModel.url = self.textField.text;
                            break;
                        case 1:
                            paramModel.location = self.textField.text;
                            break;
                            
                        default:
                            break;
                    }
                }
                    break;
                    
                default:
                    break;
            }
            [manager updateAccountByParamModel:paramModel];
            
        } else {
            [SVProgressHUD setMinimumDismissTimeInterval:1.5];
            [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
            [SVProgressHUD showErrorWithStatus:@"Please Input!"];
        }
    }
}

#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showSuccessWithStatus:@"Update Success!"];
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.5];
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
    
}


#pragma mark - getter & setter
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = DSystemFontTitle;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textColor = DSystemColorBlack333333;
        _textField.placeholder = [NSString stringWithFormat:@"Input Your %@", self.titleStr];
        _textField.backgroundColor = [UIColor whiteColor];
    }
    return _textField;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setBorderWidth:0.5];
        [_bgView.layer setBorderColor:DSystemColorGrayE0E0E0.CGColor];
    }
    return _bgView;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = DSystemFontAlert;
        _tipLabel.textColor = DSystemColorBlackBBBBBB;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}


@end
