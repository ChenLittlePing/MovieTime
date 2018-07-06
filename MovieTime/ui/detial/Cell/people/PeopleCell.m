//
//  演员信息
//
//  Created by cxp on 2018/7/4.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "PeopleCell.h"
#import "../../../../bean/MovieDetail/MovieActor.h"
#import "IconCell.h"

static NSString * ICON_CELL_ID = @"ICON_CELL";
MovieDetail *detail;

@implementation PeopleCell

- (void)awakeFromNib {
    if (!self.inited) {
        [self initList];
    }
    [super awakeFromNib];
}

- (void)initList {
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    self.tableview.transform = CGAffineTransformMakeRotation(-M_PI_2); // 逆时针旋转90度
    self.tableview.showsVerticalScrollIndicator = NO;
    [self.tableview registerClass:[IconCell class] forCellReuseIdentifier:ICON_CELL_ID];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.inited = YES;
}

- (void)drawRect:(CGRect)rect {
    // 重新设置tableview宽高
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_WIDTH / 5;
    self.tableview.frame = CGRectMake(0,
                                      35,
                                      width - 24,
                                      height);
}

- (void)setFrame:(CGRect)frame {
    // 重新设置cell宽高
    frame.size.height = SCREEN_WIDTH / 5 + 50;
    frame.size.width = SCREEN_WIDTH;
    [super setFrame:frame];
}

- (void)dealloc {
    detail = nil;
}

- (void)setData:(MovieDetail *)data {
    detail = data;
    if (detail == nil) {
        return;
    }
    self.title.text = @"演员";
    [self.tableview reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    IconCell *cell = (IconCell *)[tableView dequeueReusableCellWithIdentifier:ICON_CELL_ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[IconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ICON_CELL_ID];
    }
    
    [cell setData: detail.actors[indexPath.row].img];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH / 5 + 8;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (detail == nil) {
        return 0;
    }
    return detail.actors.count;
}

@end
