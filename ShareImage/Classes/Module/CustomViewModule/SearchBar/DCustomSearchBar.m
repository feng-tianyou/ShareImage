//
//  DCustomSearchBar.m
//  ywq
//
//  Created by FTY on 2017/8/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "DCustomSearchBar.h"

@interface DCustomSearchBar ()<UITextFieldDelegate>
@property (nonatomic, weak) UIView *searchBarView;
@property (nonatomic, weak) UIImageView *promptIconView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *cancelBtn;
@end

@implementation DCustomSearchBar
@synthesize text = _text;

- (instancetype)init{
    self = [super init];
    if (self) {
        [self proccessData];
        [self proccessViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self proccessData];
        [self proccessViews];
    }
    return self;
}

- (void)proccessData{
    
    _searchBarBackgroundColor = DSystemColorGray999999;
    _promptImage = [UIImage getImageWithName:@"contacts_icon_search"];
    _promptImageSize = _promptImage.size;
    _promptImageEdage = 10.0;
    _searchBarHeight = 30;
    _searchBarLRMargin = 15.0;
    _searchBarCornerRadius = _searchBarHeight/2;
    _placeholder = @"搜索";
    _tintColor = nil;
    _textFont = DSystemFontText;
    _textAlignment = NSTextAlignmentLeft;
    _limit = 0;
    _cancelLeftEdage = 12.5;
    _cancelName = @"取消";
    _cancelColor = DSystemColorBlack333333;
    _cancelFont = DSystemFontText;
    _showCancelButton = NO;
}

- (void)proccessViews{
    
    self.backgroundColor = DSystemColorWhite;
    
    UIView *searchBarView = [UIView new];
    searchBarView.backgroundColor = _searchBarBackgroundColor;
    [searchBarView.layer setCornerRadius:_searchBarCornerRadius];
    [searchBarView.layer setMasksToBounds:YES];
    [self addSubview:searchBarView];
    _searchBarView = searchBarView;
    
    UIImageView *promptIconView = [[UIImageView alloc] init];
    promptIconView.image = _promptImage;
    [_searchBarView addSubview:promptIconView];
    _promptIconView = promptIconView;
    
    UITextField *txtField = [[UITextField alloc] init];
    [txtField setFont:_textFont];
    [txtField setPlaceholder:_placeholder];
    [txtField setTextAlignment:_textAlignment];
    [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtField setKeyboardType:UIKeyboardTypeDefault];
    [txtField setReturnKeyType:UIReturnKeySearch];
    [txtField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    txtField.tintColor = _tintColor;
    txtField.backgroundColor = [UIColor clearColor];
    txtField.delegate = self;
    _textField = txtField;
    [_searchBarView addSubview:txtField];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:_cancelName forState:UIControlStateNormal];
    [cancelBtn setTitle:_cancelName forState:UIControlStateHighlighted];
    [cancelBtn setTitleColor:_cancelColor forState:UIControlStateNormal];
    [cancelBtn setTitleColor:_cancelColor forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = _cancelFont;
    [cancelBtn addTarget:self action:@selector(pressToCancel) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.hidden = _showCancelButton;
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat searchBarWidth = self.width - self.searchBarLRMargin*2;
    if (_showCancelButton) {
        CGSize cancelSize = [_cancelBtn.titleLabel.text sizeWithFont:_cancelBtn.titleLabel.font maxWidth:searchBarWidth/2];
        searchBarWidth -= (cancelSize.width + _cancelLeftEdage);
        [_cancelBtn setFrame:self.width - self.searchBarLRMargin - cancelSize.width y:0 w:cancelSize.width h:self.height];
    }
    [_searchBarView setFrame:self.searchBarLRMargin y:(self.height - _searchBarHeight)/2 w:searchBarWidth h:_searchBarHeight];
    
    [_promptIconView setFrame:12 y:(_searchBarHeight - _promptImageSize.height)/2 w:_promptImageSize.width h:_promptImageSize.height];
    
    CGFloat textFieldWidth = searchBarWidth - 16;
    if (_promptImageSize.width > 0) {
         textFieldWidth -= (_promptImageSize.width + _promptImageEdage);
    }
    [_textField setFrame:_promptIconView.right+_promptImageEdage y:0 w:textFieldWidth h:_searchBarHeight];
}

#pragma mark - private

- (void)textFieldDidChange:(UITextField *)textField{
    if (self.chinese == YES) {
        NSString *toBeString = [textField.text filterCharactorWithRegex:@"[^\u4e00-\u9fa5]"];
        // 键盘输入模式
        NSString *lang = textField.textInputMode.primaryLanguage;
        if ([lang isEqualToString:@"zh-Hans"]) {
            // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!selectedRange) {
                if (toBeString.length < self.limit) {
                    return;
                }
                textField.text = [toBeString substringToIndex:self.limit];
                DelegateHasMethorAndDo(self.delegate, customSearchBar:textFieldForLimit:, [self.delegate customSearchBar:self textFieldForLimit:textField];);
                return;
            }
        }
    } else {
        UITextRange *selectedRange = [textField markedTextRange];
        if (!selectedRange) {
            if (textField.text.length > self.limit && self.limit > 0) {
                textField.text = [textField.text substringToIndex:self.limit];
                DelegateHasMethorAndDo(self.delegate, customSearchBar:textFieldForLimit:, [self.delegate customSearchBar:self textFieldForLimit:textField];);
                return;
            }
        }
    }
    
    DelegateHasMethorAndDo(self.delegate, customSearchBar:textFieldDidChange:, [self.delegate customSearchBar:self textFieldDidChange:textField];);
}

- (void)pressToCancel{
    [_textField resignFirstResponder];
    DelegateHasMethorAndDo(self.delegate, customSearchBarDidClickCancelBtn:, [self.delegate customSearchBarDidClickCancelBtn:self];);
}

#pragma mark - public
- (void)becomeFirstResponder{
    if (!_textField.isFirstResponder) {
        [_textField becomeFirstResponder];
    }
}

- (void)resignFirstResponder{
    [_textField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSearchBarDidClickSearchBtn:text:)]) {
        return [self.delegate customSearchBarDidClickSearchBtn:self text:textField.text];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSearchBar:textFieldShouldBeginEditing:)]) {
        return [self.delegate customSearchBar:self textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSearchBar:textFieldShouldClear:)]) {
        return [self.delegate customSearchBar:self textFieldShouldClear:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    DelegateHasMethorAndDo(self.delegate, customSearchBar:textFieldDidBeginEditing:, [self.delegate customSearchBar:self textFieldDidBeginEditing:textField];)
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(customSearchBar:textFieldShouldEndEditing:)]) {
        return [self.delegate customSearchBar:self textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    DelegateHasMethorAndDo(self.delegate, customSearchBar:textFieldDidEndEditing:, [self.delegate customSearchBar:self textFieldDidEndEditing:textField];)
}


#pragma mark - setter
- (void)setSearBarEnabled:(BOOL)searBarEnabled{
    _searBarEnabled = searBarEnabled;
    _textField.enabled = searBarEnabled;
}

- (void)setSearchBarCornerRadius:(CGFloat)searchBarCornerRadius{
    _searchBarCornerRadius = searchBarCornerRadius;
    [_searchBarView.layer setCornerRadius:searchBarCornerRadius];
}

- (void)setSearchBarBackgroundColor:(UIColor *)searchBarBackgroundColor{
    _searchBarBackgroundColor = searchBarBackgroundColor;
    _searchBarView.backgroundColor = searchBarBackgroundColor;
}

- (void)setSearchBarHeight:(CGFloat)searchBarHeight{
    _searchBarHeight = searchBarHeight;
    _searchBarView.height = searchBarHeight;
    _searchBarCornerRadius = searchBarHeight/2.f;
    [_searchBarView.layer setCornerRadius:_searchBarCornerRadius];
}

- (void)setPromptImage:(UIImage *)promptImage{
    _promptImage = promptImage;
    _promptIconView.image = promptImage;
    _promptImageSize = promptImage.size;
}

- (void)setPromptImageSize:(CGSize)promptImageSize{
    _promptImageSize = promptImageSize;
    _promptIconView.size = promptImageSize;
}

- (void)setPromptImageEdage:(CGFloat)promptImageEdage{
    _promptImageEdage = promptImageEdage;
    [self setNeedsLayout];
}


- (void)setText:(NSString *)text{
    _text = [text copy];
    [_textField setText:text];
}

- (NSString *)text{
    return _textField.text;
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    _textField.placeholder = placeholder;
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    _textField.tintColor = tintColor;
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    _textField.font = textFont;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    _textField.textAlignment = textAlignment;
}


- (void)setCancelLeftEdage:(CGFloat)cancelLeftEdage{
    _cancelLeftEdage = cancelLeftEdage;
    [self setNeedsLayout];
}

- (void)setCancelName:(NSString *)cancelName{
    _cancelName = [cancelName copy];
    [_cancelBtn setTitle:cancelName forState:UIControlStateNormal];
    [_cancelBtn setTitle:cancelName forState:UIControlStateHighlighted];
}

- (void)setCancelColor:(UIColor *)cancelColor{
    _cancelColor = cancelColor;
    [_cancelBtn setTitleColor:cancelColor forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:cancelColor forState:UIControlStateHighlighted];
}

- (void)setCancelFont:(UIFont *)cancelFont{
    _cancelFont = cancelFont;
    _cancelBtn.titleLabel.font = cancelFont;
}

- (void)setShowCancelButton:(BOOL)showCancelButton{
    _showCancelButton = showCancelButton;
    [self setNeedsLayout];
}

@end
