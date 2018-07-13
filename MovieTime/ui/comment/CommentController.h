//
//  CommentController.h
//  MovieTime
//
//  Created by cxp on 2018/7/13.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../net/TicketRequest.h"

@interface CommentController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TicketRequest *request;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@property (nonatomic, weak) NSNumber *movieId;

@end
