//
//  UIViewController+DLottieAnimated.h
//  DFrame
//
//  Created by DaiSuke on 2017/2/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIViewController (DLottieAnimated)

- (void)lottiePresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);

- (void)lottieDismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);

NS_ASSUME_NONNULL_END
@end
