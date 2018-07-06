//
//  MovieDetail.m
//  MovieTime
//
//  Created by cxp on 2018/6/26.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieDetailController.h"
#import "Cell/Cell.h"
#import "Cell/header/HeaderCell.h"
#import "../../net/TimeResult.h"
#import "../../bean/MovieDetail/MovieDetail.h"
#import "Cell/people/PeopleCell.h"

@interface MovieDetailController ()

@end

static NSString *HEADER_CELL_ID;
static NSString *ACTOR_CELL_ID;

MovieDetail *movieDetail;
int count = 1;

@implementation MovieDetailController

-(void)viewDidLoad {
    [self initCellID];
    [self initList];
    [self start];
}

- (void)dealloc {
    movieDetail = nil;
}

- (void)initCellID {
    HEADER_CELL_ID = NSStringFromClass([HeaderCell class]);
    ACTOR_CELL_ID = NSStringFromClass([PeopleCell class]);
}

- (void)initList {
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    [self.tableview registerNib:[UINib nibWithNibName:ACTOR_CELL_ID bundle:nil] forCellReuseIdentifier:ACTOR_CELL_ID];
    [self.tableview registerNib:[UINib nibWithNibName:HEADER_CELL_ID bundle:nil] forCellReuseIdentifier:HEADER_CELL_ID];
    [self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)start {
    self.request = [[TimeRequest alloc] init];
    [self getData];
    [self showLoading];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *id;
    if (indexPath.row == 0) {
        id = HEADER_CELL_ID;
    } else if (indexPath.row == 1) {
        id = ACTOR_CELL_ID;
    } else {
        id = @"cell";
    }
    
    Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:id forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:id owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    [cell setData:movieDetail];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)getData {
    TimeResult *result = [[TimeResult alloc]initResult:MovieDetail.class success:^(id data) {
        [self hideLoading];
        movieDetail = (MovieDetail *) data;
        count = 2;
        [self.tableview reloadData];
    } fail:^(NSString *msg, NSInteger code) {
        [self hideLoading];
    }];
    [self.request getMovieDetail:self.movieId result:result];
}

- (void)showLoading {
    if (!self.indicator) {
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.center = CGPointMake(self.view.center.x, self.view.center.y);
        [self.view addSubview:self.indicator];
        self.indicator.color = [UIColor orangeColor];
    }
    
    [self.indicator setHidden:NO];
    [self.indicator startAnimating];
}

- (void)hideLoading {
    if (self.indicator) {
        [self.indicator setHidden:YES];
        [self.indicator stopAnimating];
    }
}


@end
