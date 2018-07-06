//
//  ViewController.m
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "ViewController.h"
#import "MovieInfoCell.h"
#import "bean/movieinfo/MovieInfo.h"
#import "bean/movieinfo/MovieInfoList.h"
#import "net/TimeResult.h"
#import "ui/detial/MovieDetailController.h"

@interface ViewController ()

@end

@implementation ViewController

NSMutableArray<MovieInfo *> *items;
NSString *cellName = @"MovieInfoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initList];
    [self start];
}

- (void) initList {
    items = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableview registerNib:[UINib nibWithNibName:cellName bundle:nil]
         forCellReuseIdentifier:cellName];
    
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
}

- (void)start {
    self.request = [[TimeRequest alloc] init];
    [self getData];
    [self showLoading];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieInfoCell *cell = (MovieInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    MovieInfo *info = items[indexPath.row];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:info.cover];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.cover.image = image;
        });
    });
    
    cell.name.text = info.titleCn;
    cell.intro.text = [@"简介：" stringByAppendingString: [info.desc isEqualToString:@""]? @"无":info.desc];
    cell.type.text = [@"类型：" stringByAppendingString:info.type];
    cell.actors.text = [@"演员：" stringByAppendingFormat:@"%@，%@",info.actor1, info.actor2];
    cell.showtime.text = [@"首映：" stringByAppendingFormat:@"%@年%@月%@日", info.year.stringValue, info.month.stringValue, info.day.stringValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MovieDetailController" bundle:nil];
    MovieDetailController *controller = [storyboard instantiateViewControllerWithIdentifier:@"MovieDetailController"];
    controller.movieId = items[indexPath.row].id;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)getData {
    TimeResult *result = [[TimeResult alloc] initResult:[MovieInfoList class] success:^(id data) {
        MovieInfoList *list = (MovieInfoList *) data;
        [items addObjectsFromArray: list.movies];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoading];
            [self.tableview reloadData];
        });
    } fail:^(NSString *msg, NSInteger code) {
        [self hideLoading];
    }];
    [self.request getSells:result];
}

@end
