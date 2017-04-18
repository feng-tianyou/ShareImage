//
//  DEditProfileMsgController.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/12.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DEditProfileMsgController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "DHomeCellTipLabel.h"

#import "DUserAPIManager.h"
#import "DUserParamModel.h"

#import <MapKit/MapKit.h>

@interface DEditProfileMsgController ()<CLLocationManagerDelegate>
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSIndexPath *indexPatch;
@property (nonatomic, strong) DHomeCellTipLabel *currentAddressLabel;

@property (nonatomic, strong) CLLocationManager * locationManager;

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
    [self.bgView addSubview:self.textView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.currentAddressLabel];
    
    
    [self setupSubViews];
    [self setupData];
    
}


#pragma mark - private
- (void)setupSubViews{
    
    CGFloat bgViewHeight = 44;
    if (self.indexPatch.section == 2 && self.indexPatch.row == 2) {
        bgViewHeight = 100;
        self.textView.hidden = NO;
        self.textField.hidden = YES;
        self.textView.text = self.content;
        [self.textView becomeFirstResponder];
        
    } else {
        self.textView.hidden = YES;
        self.textField.hidden = NO;
        self.textField.text = self.content;
        [self.textField becomeFirstResponder];
    }
    
    self.bgView.sd_layout
    .topSpaceToView(self.view, 15+self.navBarHeight)
    .leftSpaceToView(self.view, -1)
    .rightSpaceToView(self.view, -1)
    .heightIs(bgViewHeight);
    
    self.textField.sd_layout
    .topEqualToView(self.bgView)
    .leftSpaceToView(self.bgView, 15)
    .rightSpaceToView(self.bgView, 15)
    .bottomEqualToView(self.bgView);
    
    self.textView.sd_layout
    .topEqualToView(self.bgView)
    .leftSpaceToView(self.bgView, 15)
    .rightSpaceToView(self.bgView, 15)
    .bottomEqualToView(self.bgView);
    
    self.tipLabel.sd_layout
    .topSpaceToView(self.bgView, 10)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .autoHeightRatio(0);
    
    self.currentAddressLabel.sd_layout
    .topSpaceToView(self.bgView, 10)
    .leftSpaceToView(self.view, 15)
    .rightSpaceToView(self.view, 15)
    .heightIs(20);
}

- (void)setupData{
    
    if (self.indexPatch.section == 1) {
        self.tipLabel.hidden = NO;
        if (self.indexPatch.row == 0) {
            self.tipLabel.text = kLocalizedLanguage(@"edTip0");
        } else {
            self.tipLabel.text = kLocalizedLanguage(@"edTip1");
        }
    } else if (self.indexPatch.section == 2) {
        if (self.indexPatch.row == 1) {
            // 开始定位
            [self.locationManager startUpdatingLocation];
        }
    }
}

- (void)navigationBarDidClickNavigationBtn:(UIButton *)navBtn isLeft:(BOOL)isLeft{
    [self.textField resignFirstResponder];
    if (isLeft) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        if (self.textField.text.length > 0 || self.textView.text.length > 0) {
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
                                [SVProgressHUD showErrorWithStatus:kLocalizedLanguage(@"edInstagramHud")];
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
                        case 2:
                            paramModel.bio = self.textView.text;
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
            [SVProgressHUD showErrorWithStatus:kLocalizedLanguage(@"edPleaseInput!")];
        }
    }
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * newLoaction = locations[0];
    [self.locationManager stopUpdatingLocation];
    //创建地理位置解码编码器对象
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    @weakify(self)
    [geoCoder reverseGeocodeLocation:newLoaction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        @strongify(self)
        CLPlacemark * place = [placemarks firstObject];
        self.currentAddressLabel.hidden = NO;
        self.currentAddressLabel.describe = place.name;
        if (error) {
            self.currentAddressLabel.describeLabel.text = @"Have Not Found!";
        }
    }];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    self.currentAddressLabel.describeLabel.text = @"Have Not Found!";
}

#pragma mark - request
- (void)requestServiceSucceedWithModel:(__kindof DJsonModel *)dataModel userInfo:(NSDictionary *)userInfo{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD showSuccessWithStatus:kLocalizedLanguage(@"edUpdateSuccess!")];
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
        _textField = [[DTextField alloc] init];
        _textField.font = DSystemFontTitle;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textColor = DSystemColorBlack333333;
        _textField.placeholder = [NSString stringWithFormat:@"%@ %@", kLocalizedLanguage(@"edInputYour"), self.titleStr];
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
        _tipLabel.numberOfLines = 0;
    }
    return _tipLabel;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = DSystemFontTitle;
        _textView.textColor = DSystemColorBlack333333;
        _textView.placeholder = [NSString stringWithFormat:@"%@ %@", kLocalizedLanguage(@"edInputYour"), self.titleStr];
        _textView.backgroundColor = [UIColor whiteColor];
    }
    return _textView;
}

- (DHomeCellTipLabel *)currentAddressLabel{
    if (!_currentAddressLabel) {
        _currentAddressLabel = [[DHomeCellTipLabel alloc] init];
        _currentAddressLabel.iconName = @"common_btn_address_hight";
        _currentAddressLabel.describeLabel.textColor = DSystemColorBlack333333;
        _currentAddressLabel.describeLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14.0];
        _currentAddressLabel.mode = HomeCellTipLabelLeft;
        _currentAddressLabel.hidden = YES;
    }
    return _currentAddressLabel;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        //请求定位服务
        if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
            [_locationManager requestWhenInUseAuthorization];
        }
        _locationManager.delegate = self;
    }
    return _locationManager;
}


@end
