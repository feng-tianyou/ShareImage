//
//  DTestTableViewCell.m
//  DFrame
//
//  Created by DaiSuke on 2017/1/11.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DTestTableViewCell.h"



@implementation testModel



@end

@interface DTestTableViewCell ()
{
    
    UIImageView *_iconView;
    UILabel *_nameLabel;
    UILabel *_projectLabel;
    UILabel *_dateLabel;
    UILabel *_contentLabel;
    
}
@end

@implementation DTestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupviews];
    }
    return self;
}

- (void)setupviews{
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc] init];
        [view.layer setCornerRadius:22.5];
        [view.layer setMasksToBounds:YES];
        view;
    });
    [self.contentView addSubview:_iconView];
    
    _nameLabel = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl sizeToFit];
        lbl;
    });
    [self.contentView addSubview:_nameLabel];
    
    _nameLabel = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl sizeToFit];
        lbl;
    });
    [self.contentView addSubview:_nameLabel];
    
    _projectLabel = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        lbl.hidden = YES;
        [lbl sizeToFit];
        lbl;
    });
    [self.contentView addSubview:_projectLabel];
    
    _dateLabel = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl sizeToFit];
        lbl;
    });
    [self.contentView addSubview:_dateLabel];
    
    _contentLabel = ({
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl sizeToFit];
        lbl.numberOfLines = 0;
        lbl;
    });
    [self.contentView addSubview:_contentLabel];
    
    UIView *view = self.contentView;
    CGFloat margin = 10;
    // 布局
    _iconView.sd_layout
    .topSpaceToView(view, margin)
    .leftSpaceToView(view, 15)
    .widthIs(45)
    .heightIs(45);
    
    _nameLabel.sd_layout
    .topEqualToView(_iconView)
    .leftSpaceToView(_iconView, margin)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _projectLabel.sd_layout
    .leftSpaceToView(_nameLabel, 5)
    .bottomEqualToView(_nameLabel)
    .heightIs(15);
    [_projectLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _dateLabel.sd_layout
    .rightSpaceToView(view, margin+5)
    .bottomEqualToView(_projectLabel)
    .heightIs(15);
    [_dateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _contentLabel.sd_layout
    .topSpaceToView(_nameLabel, margin)
    .leftEqualToView(_nameLabel)
    .rightSpaceToView(view, margin)
    .autoHeightRatio(0);
    
    
}


- (void)setModel:(testModel *)model{
    _model = model;
    [_iconView setImageURL:[NSURL URLWithString:model.icon]];
    _nameLabel.text = model.name;
    _projectLabel.text = model.project;
    _dateLabel.text = model.date;
    _contentLabel.text = model.content;
    
    [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:15];
}













@end
