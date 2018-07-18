//
//  MagicMoveInverseTransition.m
//  MovieTime
//
//  Created by cxp on 2018/7/18.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MagicMoveInverseTransition.h"
#import "PosterController.h"
#import "../detial/MovieDetailController.h"
#import "../detial/Cell/header/HeaderCell.h"

@implementation MagicMoveInverseTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6f;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    MovieDetailController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    PosterController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *snapshot = [fromVC.image snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = [containerView convertRect:snapshot.frame fromView:fromVC.image.superview];
    fromVC.image.hidden = YES;
    
    HeaderCell *header = [toVC.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapshot];
    
    //发生动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.alpha = 0.0f;
        snapshot.frame = [containerView convertRect:header.image.frame fromView:header.image.superview];
    } completion:^(BOOL finished) {
        [snapshot removeFromSuperview];
        fromVC.image.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
