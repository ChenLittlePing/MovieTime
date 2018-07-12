//
//  MovieDetail.h
//  MovieTime
//
//  Created by cxp on 2018/6/26.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../net/TimeRequest.h"
#import "../../net/TicketRequest.h"

@interface MovieDetailController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) NSNumber *movieId;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) TimeRequest *movieReq;
@property (strong, nonatomic) TicketRequest *ticketReq;

@property (strong, nonatomic) UIActivityIndicatorView *indicator;

@end
