//
//  DEditProfileCell.m
//  ShareImage
//
//  Created by DaiSuke on 2017/3/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DEditProfileCell.h"


static NSString *const cellID = @"homeCell";

@implementation DEditProfileCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    DEditProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DEditProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}


#pragma mark - 私有方法
- (void)setupSubViews{
    [self.contentView addSubview:self.leftTitleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.arrowView];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // layout
    CGSize titleSize = [_leftTitleLabel.text sizeWithFont:_leftTitleLabel.font maxWidth:self.width/2];
    self.leftTitleLabel.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 15)
    .bottomEqualToView(self.contentView)
    .widthIs(titleSize.width);
    
    CGSize imgSize = self.arrowView.image.size;
    self.arrowView.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15)
    .widthIs(imgSize.width)
    .heightIs(imgSize.height);
    
    self.contentLabel.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.leftTitleLabel, 15)
    .rightSpaceToView(self.arrowView, 15)
    .bottomEqualToView(self.contentView);
}



#pragma mark - getter & setter
- (UILabel *)leftTitleLabel{
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc] init];
        _leftTitleLabel.textColor = DSystemColorBlack333333;
        _leftTitleLabel.font = DSystemFontTitle;
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftTitleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = DSystemColorBlackBBBBBB;
        _contentLabel.font = DSystemFontTitle;
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = [UIImage getImageWithName:@"cell_detail"];
    }
    return _arrowView;
}


@end
