//
//  PeopleCell.h
//  MovieTime
//
//  Created by cxp on 2018/7/4.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Cell.h"

@interface PeopleCell : Cell<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property Boolean inited;

@end
