//
//  TransitionAnimator.m
//  Presenter
//
//  Created by Mike Meyer on 07/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import "TransitionAnimator.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 10.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // Grab the from and to view controllers from the context
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    float scalePercentage = .6;
    CGRect endFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);

    if (self.presenting) {
        fromViewController.view.userInteractionEnabled = NO;
        
        [transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        
        CGRect startFrame = endFrame;
        startFrame.origin.y += [[UIScreen mainScreen] bounds].size.height + 100;
        
        toViewController.view.alpha = 0;
        toViewController.view.frame = startFrame;
        
        [UIView animateWithDuration:.5f
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            
            fromViewController.view.alpha = 0;
            fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scalePercentage, scalePercentage);

            toViewController.view.alpha = 1;
            toViewController.view.frame = endFrame;
//            toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else {
        toViewController.view.userInteractionEnabled = YES;
        
        [transitionContext.containerView addSubview:toViewController.view];
        [transitionContext.containerView addSubview:fromViewController.view];
        
        endFrame.origin.y -= [[UIScreen mainScreen] bounds].size.height - 100;

        fromViewController.view.alpha = 1;
        
        toViewController.view.alpha = .7;
        toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scalePercentage, scalePercentage);
        
        [UIView animateWithDuration:.4f
                              delay: 0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
                             toViewController.view.alpha = 1.0;
                             toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);

                             fromViewController.view.alpha = 0;
                             fromViewController.view.frame = endFrame;
                         } completion:^(BOOL finished) {
                             [transitionContext completeTransition:YES];
                         }
         ];
    }
}

@end