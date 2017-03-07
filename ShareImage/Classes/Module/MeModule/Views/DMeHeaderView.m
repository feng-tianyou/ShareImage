//
//  DMeHeaderView.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/7.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DMeHeaderView.h"
#import "DHomeCellTipLabel.h"
#import "DMeHeaderFunctionView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DMeHeaderView ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) DHomeCellTipLabel *addressLabel;
@property (nonatomic, strong) DHomeCellTipLabel *emailLabel;
@property (nonatomic, strong) UILabel *bioLabel;
@property (nonatomic, strong) DMeHeaderFunctionView *functionView;

@end

@implementation DMeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgImbageView];
        [self.bgImbageView addSubview:self.nameLabel];
        [self.bgImbageView addSubview:self.addressLabel];
        [self.bgImbageView addSubview:self.bioLabel];
        [self.bgImbageView addSubview:self.emailLabel];
        [self addSubview:self.functionView];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.bgImbageView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(300);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.bgImbageView, 100)
    .leftSpaceToView(self.bgImbageView , 15)
    .rightSpaceToView(self.bgImbageView , 15)
    .heightIs(25);
    
    self.addressLabel.sd_layout
    .topSpaceToView(self.nameLabel, 10)
    .leftSpaceToView(self.bgImbageView , 15)
    .rightSpaceToView(self.bgImbageView , 15)
    .heightIs(25);
    
    self.emailLabel.sd_layout
    .topSpaceToView(self.addressLabel, 10)
    .leftSpaceToView(self.bgImbageView , 15)
    .rightSpaceToView(self.bgImbageView , 15)
    .heightIs(25);
    
    self.bioLabel.sd_layout
    .topSpaceToView(self.emailLabel, 10)
    .leftSpaceToView(self.bgImbageView , 15)
    .rightSpaceToView(self.bgImbageView , 15)
    .autoHeightRatio(0);
    
    self.functionView.sd_layout
    .topSpaceToView(self.bgImbageView, 0)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(50);
    
}

- (void)reloadData{
    [self.bgImbageView sd_setImageWithURL:[NSURL URLWithString:KGLOBALINFOMANAGER.accountInfo.profile_image.large]];
    self.nameLabel.text = KGLOBALINFOMANAGER.accountInfo.name;
    self.addressLabel.describe = KGLOBALINFOMANAGER.accountInfo.location;
    self.emailLabel.describe = KGLOBALINFOMANAGER.accountInfo.email;
    self.bioLabel.text = KGLOBALINFOMANAGER.accountInfo.bio;
    
    [self.functionView reloadData];
}

#pragma mark - setter & getter
#warning lazy

@end
