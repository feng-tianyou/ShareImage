//
//  DControlDefine.h
//  DFrame
//
//  Created by DaiSuke on 16/9/27.
//  Copyright © 2016年 DaiSuke. All rights reserved.
//

#ifndef DControlDefine_h
#define DControlDefine_h
#import <objc/runtime.h>

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

#define ScreenScale ([[UIScreen mainScreen] scale])

// 获取一个像素
#define PixelOne 1/ScreenScale
/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE float
flatfSpecificScale(float floatValue, float scale) {
    scale = scale == 0 ? ScreenScale : scale;
    CGFloat flattedValue = ceilf(floatValue * scale) / scale;
    return flattedValue;
}
/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flatf() 函数。
 */
CG_INLINE float
flatf(float floatValue) {
    return flatfSpecificScale(floatValue, 0);
}


/// 传入size，返回一个x/y为0的CGRect
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size) {
    return CGRectMake(0, 0, size.width, size.height);
}


CG_INLINE CGRect
CGRectSetXY(CGRect rect, CGFloat x, CGFloat y) {
    rect.origin.x = flatf(x);
    rect.origin.y = flatf(y);
    return rect;
}

#pragma mark - CGSize

/// 判断一个size是否为空（宽或高为0）
CG_INLINE BOOL
CGSizeIsEmpty(CGSize size) {
    return size.width <= 0 || size.height <= 0;
}

/// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
CG_INLINE CGFloat
CGRectGetMinYVerticallyCenterInParentRect(CGRect parentRect, CGRect childRect) {
    return flatf((CGRectGetHeight(parentRect) - CGRectGetHeight(childRect)) / 2.0);
}

/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持垂直居中时，layoutingRect的originY
CG_INLINE CGFloat
CGRectGetMinYVerticallyCenter(CGRect referenceRect, CGRect layoutingRect) {
    return CGRectGetMinY(referenceRect) + CGRectGetMinYVerticallyCenterInParentRect(referenceRect, layoutingRect);
}

/// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
CG_INLINE CGFloat
CGRectGetMinXHorizontallyCenterInParentRect(CGRect parentRect, CGRect childRect) {
    return flatf((CGRectGetWidth(parentRect) - CGRectGetWidth(childRect)) / 2.0);
}

/// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
CG_INLINE CGFloat
CGRectGetMinXHorizontallyCenter(CGRect referenceRect, CGRect layoutingRect) {
    return CGRectGetMinX(referenceRect) + CGRectGetMinXHorizontallyCenterInParentRect(referenceRect, layoutingRect);
}


#pragma mark - UIEdgeInsets

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

/// 为给定的rect往内部缩小insets的大小
CG_INLINE CGRect
CGRectInsetEdges(CGRect rect, UIEdgeInsets insets) {
    rect.origin.x += insets.left;
    rect.origin.y += insets.top;
    rect.size.width -= UIEdgeInsetsGetHorizontalValue(insets);
    rect.size.height -= UIEdgeInsetsGetVerticalValue(insets);
    return rect;
}

// arc
#define ARC_PROP_RETAIN strong
#define ARC_RETAIN(x) (x)
#define ARC_RELEASE(x)
#define ARC_AUTORELEASE(x) (x)
#define ARC_BLOCK_COPY(x) (x)
#define ARC_BLOCK_RELEASE(x)
#define ARC_SUPER_DEALLOC()
#define ARC_AUTORELEASE_POOL_START() @autoreleasepool {
#define ARC_AUTORELEASE_POOL_END() }

// if do else do
#define HasMessageAndAlert(dic,doSomeThing) if(dic && [dic objectForKey:kMessage] != kNull){doSomeThing}

#define DicHasKeyAndDo(dic,hasKey,doSomeThing) if([dic objectForKey:hasKey] && [dic objectForKey:hasKey] != kNull){doSomeThing}

#define IfIsTrueAndDo(isTrue,doSomeThing) if((isTrue)){doSomeThing}


//单例
#define SYNTHESIZE_SINGLETON_FOR_CLASS(className)   + (className *)share { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className;\
}



// 弱引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


//打印
#ifdef  DEBUG   //DeBug版本宏

#define DLog(fmt, ...)                  NSLog((@"[Method:%s]-[Line %d]->" fmt),__PRETTY_FUNCTION__, __LINE__,##__VA_ARGS__)
#define DLogSize(_size)                 DLog(@"CGSize:%@", NSStringFromCGSize(_size))
#define DLogRect(_rect)                 DLog(@"NSRect:%@",NSStringFromCGRect(_rect))
#define DLogPoint(_point)               DLog(@"NSPoint:%@",NSStringFromCGPoint(_point))
#define DLogEdgeInsets(_edgeInsets)     DLog(@"UIEdgeInsets:%@",NSStringFromUIEdgeInsets(_edgeInsets))
#define DLogOffset(_Offset)             DLog(@"UIOffset:%@",NSStringFromUIOffset(_Offset))
#define DLogTransform(_Transform)       DLog(@"CGAffineTransform:%@",NSStringFromCGAffineTransform(_Transform))
#define DLogSelector                    DLog(@"Selector:%@",NSStringFromSelector(_cmd))
#define DLogClass(_ClassObject)         DLog(@"Class:%@",NSStringFromClass([_ClassObject class]))


#else           //Release版本宏（发布版本）

#define DLog(fmt, ...)
#define DLogSize(_size)
#define DLogRect(_rect)
#define DLogPoint(_point)
#define DLogEdgeInsets(_edgeInsets)
#define DLogOffset(_Offset)
#define DLogTransform(_Transform)
#define DLogSelector
#define DLogClass(_ClassObject)
#endif


#define DelegateHasMethorAndDo(delegate,methor,callMethor) if(delegate && [delegate respondsToSelector:@selector(methor)]){ callMethor }

#define DelegateHasMethorAndDoOrLog(delegate,methor,callMethor) if(delegate && [delegate respondsToSelector:@selector(methor)]){ callMethor }else{DLog(@"未实现%@代理方法",NSStringFromSelector(@selector(methor)));}


#define kSuccessHttp        @"0x00000000"
#define kAccountCancel      @"0x00000001"
#define HTTPSTATECODESUCCESS [[dic objectForKey:kStateCode] isEqualToString:kSuccessHttp]
#define RESPONSESUCCESS [dic objectForKey:kParamData] && [dic objectForKey:kParamData] != kNull

#define ExistActionDo(a,b) if((a)){b;}
#define ExistStringGet(str) (str).length > 0?(str):@""



#endif /* DControlDefine_h */
