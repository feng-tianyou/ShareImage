//
//  UIViewController+DLottieAnimated.m
//  DFrame
//
//  Created by DaiSuke on 2017/2/10.
//  Copyright © 2017年 DaiSuke. All rights reserved.
//

#import "UIViewController+DLottieAnimated.h"
#import "Lottie.h"

@interface UIViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation UIViewController (DLottieAnimated)

- (void)lottiePresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0){
    viewControllerToPresent.transitioningDelegate = self;
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)lottieDismissViewControllerAnimated: (BOOL)flag completion: (void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0){
    [self.presentingViewController dismissViewControllerAnimated:flag completion:completion];
}

#pragma mark -- View Controller Transitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition1" fromLayerNamed:@"outLayer" toLayerNamed:@"inLayer"];
    return animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LOTAnimationTransitionController *animationController = [[LOTAnimationTransitionController alloc] initWithAnimationNamed:@"vcTransition2" fromLayerNamed:@"outLayer" toLayerNamed:@"inLayer"];
    return animationController;
}





@end
