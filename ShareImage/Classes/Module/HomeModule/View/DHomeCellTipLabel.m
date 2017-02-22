//
//  DHomeCellTipLabel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeCellTipLabel.h"

@interface DHomeCellTipLabel ()



@end

@implementation DHomeCellTipLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews{
    [self addSubview:self.iconView];
    [self addSubview:self.describeLabel];
    
    self.iconView.sd_layout
    .centerYEqualToView(self)
    .leftEqualToView(self)
    .widthIs(12)
    .heightIs(10);
    
    self.describeLabel.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self.iconView,3)
    .rightEqualToView(self)
    .bottomEqualToView(self);
}


#pragma mark - getter & setter
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}


- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = DSystemColorGray;
        _describeLabel.font = DSystemFontDate;
        _describeLabel.backgroundColor = [UIColor clearColor];
        _describeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _describeLabel;
}

- (void)setIconName:(NSString *)iconName{
    _iconName = [iconName copy];
    self.iconView.image = [UIImage getImageWithName:iconName];
}

- (void)setDescribe:(NSString *)describe{
    _describe = [describe copy];
    self.describeLabel.text = describe;
}

@end
