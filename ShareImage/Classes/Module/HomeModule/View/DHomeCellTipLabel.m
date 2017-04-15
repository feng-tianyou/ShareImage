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
        _describeLabel.font = DSystemFontAlert;
        _describeLabel.backgroundColor = [UIColor clearColor];
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
    
    CGSize imgSize  = self.iconView.image.size;
    CGSize descSize = [describe sizeWithFont:self.describeLabel.font maxWidth:MAXFLOAT];
    switch (self.mode) {
        case HomeCellTipLabelLeft:
        {
            self.iconView.sd_layout
            .centerYEqualToView(self)
            .leftEqualToView(self)
            .widthIs(imgSize.width)
            .heightIs(imgSize.height);
            
            self.describeLabel.sd_layout
            .topEqualToView(self)
            .leftSpaceToView(self.iconView, 5)
            .bottomEqualToView(self)
            .rightEqualToView(self);
        }
            break;
        case HomeCellTipLabelCenter:
        {
            self.describeLabel.sd_layout
            .centerXEqualToView(self)
            .topEqualToView(self)
            .bottomEqualToView(self)
            .widthIs(descSize.width);
            
            self.iconView.sd_layout
            .centerYEqualToView(self)
            .rightSpaceToView(self.describeLabel, 5)
            .widthIs(imgSize.width)
            .heightIs(imgSize.height);
        }
            break;
        case HomeCellTipLabelRight:
        {
            self.describeLabel.sd_layout
            .topEqualToView(self)
            .rightEqualToView(self)
            .bottomEqualToView(self)
            .widthIs(descSize.width);
            
            self.iconView.sd_layout
            .centerYEqualToView(self)
            .rightSpaceToView(self.describeLabel, 5)
            .widthIs(imgSize.width)
            .heightIs(imgSize.height);
        }
            break;
            
        default:
            break;
    }
    
}

@end
