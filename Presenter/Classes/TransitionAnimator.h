//
//  TransitionAnimator.h
//  Presenter
//
//  Created by Mike Meyer on 07/11/2013.
//  Copyright (c) 2013 Mike Meyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isPresenting) BOOL presenting;

@end
