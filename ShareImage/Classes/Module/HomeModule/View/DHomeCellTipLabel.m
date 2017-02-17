//
//  DHomeCellTipLabel.m
//  ShareImage
//
//  Created by DaiSuke on 2017/2/17.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DHomeCellTipLabel.h"

@interface DHomeCellTipLabel ()

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation DHomeCellTipLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}


- (void)setupSubViews{
    [self addSubview:self.numberLabel];
    [self addSubview:self.describeLabel];
    
    self.numberLabel.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(20);
    
    self.describeLabel.sd_layout
    .topSpaceToView(self.numberLabel, 5)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self);
}


#pragma mark - getter & setter
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.font = DSystemFontTitleBold;
        _numberLabel.backgroundColor = [UIColor clearColor];
    }
    return _numberLabel;
}


- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.textColor = DSystemColorGray;
        _describeLabel.font = DSystemFontContent;
        _describeLabel.backgroundColor = [UIColor clearColor];
    }
    return _describeLabel;
}

- (void)setNumberStr:(NSString *)numberStr{
    _numberStr = [numberStr copy];
    self.numberLabel.text = numberStr;
}

- (void)setDescribeStr:(NSString *)describeStr{
    _describeStr = [describeStr copy];
    self.describeLabel.text = describeStr;
}

@end
