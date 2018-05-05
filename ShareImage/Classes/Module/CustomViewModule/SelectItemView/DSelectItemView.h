//
//  DSelectItemView.h
//  InformationProject
//
//  Created by FTY on 2017/9/27.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LineType){
    LineTypeForFit,
    LineTypeForFull
};

@interface DSelectItemView : UIView
- (instancetype)initWithTitles:(NSArray *)titles;
- (instancetype)initWithTitles:(NSArray *)titles lineType:(LineType)lineType;
- (instancetype)initWithTitles:(NSArray *)titles lineType:(LineType)lineType selectIndex:(NSInteger)selectIndex;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic, strong) UIColor *itemNormalColor;
@property (nonatomic, strong) UIColor *itemHighLightColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *moveLineColor;
@property (nonatomic, assign) BOOL hideBottomLine;
@property (nonatomic, copy) NSIntegerBlock clickItemBlock;

@end
