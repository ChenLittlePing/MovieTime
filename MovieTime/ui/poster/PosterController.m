//
//  PosterControllerViewController.m
//  MovieTime
//
//  Created by cxp on 2018/7/17.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "PosterController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "../detial/MovieDetailController.h"
#import "MagicMoveInverseTransition.h"

@interface PosterController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation PosterController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = true;
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.url]];
    
    //设置手势监听
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:edgePanGestureRecognizer];
    
    //设置点击监听
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pop:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    //设置代理
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    //注销代理
    self.navigationController.delegate = nil;
}

- (void)pop:(UITapGestureRecognizer *)gesture {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = false;
}

#pragma mark - 过渡动画

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    if ([toVC isKindOfClass:[MovieDetailController class]]) {
        MagicMoveInverseTransition *inverseTransition = [[MagicMoveInverseTransition alloc]init];
        return inverseTransition;
    }else{
        return nil;
    }
}

-(void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        self.navigationController.navigationBarHidden = false;
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        if (progress > 0.02) {
            [self.percentDrivenTransition finishInteractiveTransition];
        } else {
            self.navigationController.navigationBarHidden = true;
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:
                                                (UINavigationController *)navigationController
                                                interactionControllerForAnimationController:
                                                (id <UIViewControllerAnimatedTransitioning>) animationController {
    if ([animationController isKindOfClass:[MagicMoveInverseTransition class]]) {
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
}
@end
