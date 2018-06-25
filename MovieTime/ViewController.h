//
//  ViewController.h
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "net/TimeRequest.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UINavigationItem *naviItem;

@property (strong, nonatomic) TimeRequest * request;

@end

