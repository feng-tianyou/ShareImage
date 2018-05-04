//
//  DCustomSearchBar.h
//  ywq
//
//  Created by FTY on 2017/8/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCustomSearchBar;
@protocol TGCustomSearchBarDelegate <NSObject>

@optional
/// 超出范围时
- (void)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldForLimit:(UITextField *)textField;
/// 输入框文本文字改变时调用
- (void)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldDidChange:(UITextField *)textField;
/// 输入框将要编辑时
- (BOOL)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldShouldBeginEditing:(UITextField *)textField;
/// 输入框清除文本时
- (BOOL)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldShouldClear:(UITextField *)textField;

- (void)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldDidBeginEditing:(UITextField *)textField;           // became first responder

- (BOOL)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

- (void)customSearchBar:(DCustomSearchBar *)customSearchBar textFieldDidEndEditing:(UITextField *)textField;

/// 点击键盘搜索时
- (BOOL)customSearchBarDidClickSearchBtn:(DCustomSearchBar *)customSearchBar text:(NSString *)text;


/// 点击取消按钮时
- (void)customSearchBarDidClickCancelBtn:(DCustomSearchBar *)customSearchBar;

@end

@interface DCustomSearchBar : UIView

- (void)becomeFirstResponder;
- (void)resignFirstResponder;

@property (nonatomic, weak) id<TGCustomSearchBarDelegate> delegate;
@property (nonatomic, assign) BOOL searBarEnabled;

/// 搜索框背景圆角，默认：searchBarHeight/2
@property (nonatomic, assign) CGFloat searchBarCornerRadius;
/// 搜索框背景颜色
@property (nonatomic, strong) UIColor *searchBarBackgroundColor;
/// 搜索框高度，默认：30
@property (nonatomic, assign) CGFloat searchBarHeight;
/// 搜索框左右间距，默认：15
@property (nonatomic, assign) CGFloat searchBarLRMargin;

/// 搜索框指示图片
@property (nonatomic, strong) UIImage *promptImage;
/// 搜索框指示图片大小
@property (nonatomic, assign) CGSize promptImageSize;
/// 搜索框指示图片右边间距，默认：10.0
@property (nonatomic, assign) CGFloat promptImageEdage;

/// 输入框文本
@property (nonatomic, copy) NSString *text;
/// 输入框提示语
@property (nonatomic, copy) NSString *placeholder;
/// 输入框光标颜色
@property (nonatomic, strong) UIColor *tintColor;
/// 输入框文本字体
@property (nonatomic, strong) UIFont *textFont;
/// 输入框对其方式，默认：NSTextAlignmentLeft
@property (nonatomic, assign) NSTextAlignment textAlignment;
/// 输入框限制字数，默认：0（不限制）
@property (nonatomic, assign) NSInteger limit;
/// 输入框限制是否是中文
@property (nonatomic, assign, getter=isChinese) BOOL chinese;

/// 取消按钮左边间距，默认：12.5
@property (nonatomic, assign) CGFloat cancelLeftEdage;
/// 取消按钮文字
@property (nonatomic, copy) NSString *cancelName;
/// 取消按钮文字颜色
@property (nonatomic, strong) UIColor *cancelColor;
/// 取消按钮文字字体
@property (nonatomic, strong) UIFont *cancelFont;
/// 是否显示取消按钮，默认：NO
@property (nonatomic, assign) BOOL showCancelButton;

@end
