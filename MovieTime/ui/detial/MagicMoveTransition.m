//
//  MagicMoveTransition.m
//  MovieTime
//
//  Created by cxp on 2018/7/17.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MagicMoveTransition.h"
#import "MovieDetailController.h"
#import "../poster/PosterController.h"
#import "HeaderCell.h"

@implementation MagicMoveTransition

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    MovieDetailController *fromVC = (MovieDetailController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PosterController *toVC = (PosterController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    HeaderCell *header = [fromVC.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIView *snapshot = [header.image snapshotViewAfterScreenUpdates:NO];
    snapshot.frame = [containerView convertRect:header.image.frame fromView:header.image.superview];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.image.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapshot];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        [containerView layoutIfNeeded];
        toVC.view.alpha = 1.0;
        snapshot.frame = [containerView convertRect:toVC.image.frame fromView:toVC.image.superview];
    } completion:^(BOOL finished) {
        //为了让回来的时候，cell上的图片显示，必须要让cell上的图片显示出来
        toVC.image.hidden = NO;
        [snapshot removeFromSuperview];
        //告诉系统动画结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
