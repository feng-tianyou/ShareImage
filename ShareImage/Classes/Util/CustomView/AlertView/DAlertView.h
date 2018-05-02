//
//  DAlertView.h
//  DFrame
//
//  Created by DaiSuke on 2016/12/23.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>


#define ALERT_VIEW_CURRENT_HEIGHT [UIScreen mainScreen].bounds.size.height
#define ALERT_VIEW_CURRENT_WIDTH [UIScreen mainScreen].bounds.size.width

#define ALERT_VIEW_TITLE_FONT       [UIFont systemFontOfSize:16.0]
#define ALERT_VIEW_MESSAGE_FONT     [UIFont systemFontOfSize:15.0]
#define ALERT_VIEW_BUTTON_FONT      [UIFont systemFontOfSize:16.0]

#define ALERT_VIEW_TITLE_TEXT_COLOR       DUIColorFromRGB16(0x333333)
#define ALERT_VIEW_MESSAGE_TEXT_COLOR     DUIColorFromRGB16(0x333333)
#define ALERT_VIEW_BUTTON_TITLE_COLOR     DUIColorFromRGB16(0x333333)

#define ALERT_VIEW_DEBUG_LAYOUT 0

#define ALERT_VIEW_MESSAGE_MIN_LINE_COUNT 1
#define ALERT_VIEW_MESSAGE_MAX_LINE_COUNT 20
#define ALERT_VIEW_GAP 10
#define ALERT_VIEW_CANCEL_BUTTON_PADDING_TOP 5
#define ALERT_VIEW_CONTENT_PADDING_LEFT 24
#define ALERT_VIEW_CONTENT_PADDING_TOP 25
#define ALERT_VIEW_CONTENT_PADDING_BOTTOM 0
#define ALERT_VIEW_BUTTON_PADDING_LEFT 0
#define ALERT_VIEW_BUTTON_HEIGHT 44
#define ALERT_VIEW_CONTAINER_WIDTH  (ALERT_VIEW_CURRENT_WIDTH * 0.822)
#define ALERT_VIEW_CONTAINER_HEIGHT (ALERT_VIEW_CURRENT_HEIGHT - 100)

typedef NS_ENUM(NSInteger, CustomAlertViewButtonType) {
    CustomAlertViewButtonTypeDefault = 0,
    CustomAlertViewButtonTypeDestructive,
    CustomAlertViewButtonTypeCancel
};

typedef NS_ENUM(NSInteger, CustomAlertViewBackgroundStyle) {
    CustomAlertViewBackgroundStyleGradient = 0,
    CustomAlertViewBackgroundStyleSolid,
};

typedef NS_ENUM(NSInteger, CustomAlertViewTransitionStyle) {
    CustomAlertViewTransitionStyleSlideFromBottom = 0,
    CustomAlertViewTransitionStyleSlideFromTop,
    CustomAlertViewTransitionStyleBounce,
};

@class DAlertView;
typedef void(^AlertViewHandler)(DAlertView *alertView);

@interface DAlertView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL messageIsAlignLeft;

@property (nonatomic, strong) UIView *customView;


@property (nonatomic, strong) UIColor *viewBackgroundColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *titleColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *messageColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *titleFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *messageFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *buttonFont NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 2.0
@property (nonatomic, assign) CGFloat shadowRadius NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR; // default is 8.0

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message;

- (id)initWithCustomView:(UIView *)view;

- (id)initWithCustomView:(UIView *)view style:(CustomAlertViewTransitionStyle)style;

- (void)addButtonWithTitle:(NSString *)title handler:(AlertViewHandler)handler;

- (void)addButtonWithTitle:(NSString *)title type:(CustomAlertViewButtonType)type handler:(AlertViewHandler)handler;

- (void)show;
- (void)dismissAnimated:(BOOL)animated;

+ (void)showNormalWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel handler:(AlertViewHandler)handler;

+ (void)showNormalWithTitle:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel cancelHandler:(AlertViewHandler)cancelHandler submit:(NSString *)submit submitHandler:(AlertViewHandler)submitHandler;


@end
