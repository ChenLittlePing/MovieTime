//
//  CommentController.m
//  MovieTime
//
//  Created by cxp on 2018/7/13.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "CommentController.h"
#import "../detial/Cell/comment/CommentCell.h"
#import "../../bean/Comment/Comments.h"
#import "../../net/TicketResult.h"

static NSString *COMMENT_CELL_ID;
static NSString *LOADING_CELL_ID;


Comments *comments;
int currentPage = 0;
BOOL isLoading = NO;

@interface CommentController ()

@end

@implementation CommentController

#pragma -mark 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self start];
}

- (void)dealloc {
    comments = nil;
    currentPage = 0;
    isLoading = NO;
}

- (void)start {
    self.request = [[TicketRequest alloc]init];
    [self getComments];
}

#pragma -mark 列表

- (void)initTableView {
    COMMENT_CELL_ID = NSStringFromClass(CommentCell.class);
    LOADING_CELL_ID = NSStringFromClass(UITableViewCell.class);
    [self.tableView registerNib:[UINib nibWithNibName:COMMENT_CELL_ID bundle:nil]  forCellReuseIdentifier:COMMENT_CELL_ID];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:LOADING_CELL_ID];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!comments) {
        return 0;
    } else {
        if ([comments.totalPage integerValue] > currentPage) {
            return comments.list.count + 1;
        } else {
            return comments.list.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == comments.list.count) {
        UITableViewCell *loading = [tableView dequeueReusableCellWithIdentifier:LOADING_CELL_ID forIndexPath:indexPath];
        loading.textLabel.text = @"正在加载...";
        loading.textLabel.textAlignment = NSTextAlignmentCenter;
        
        NSMutableParagraphStyle *descStyle = [[NSMutableParagraphStyle alloc]init];
        CGFloat contentW = SCREEN_WIDTH - 2*10;
        CGRect textRect = [loading.textLabel.text
                           boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSParagraphStyleAttributeName : descStyle}
                           context:nil];
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                              initWithFrame:CGRectMake((SCREEN_WIDTH - textRect.size.width)/2 - 40, 12, 20, 20)];
        indicator.color = [UIColor orangeColor];
        [indicator startAnimating];
        indicator.hidesWhenStopped = YES;
        [loading addSubview:indicator];
        return loading;
    }
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMENT_CELL_ID forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:COMMENT_CELL_ID owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setData: [comments.list objectAtIndex: indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.contentOffset.y + (tableView.frame.size.height) + 100 > tableView.contentSize.height){
        [self getComments];
    }
}

#pragma -mark 获取数据

- (void)getComments {
    if (isLoading) return;
    if (comments && currentPage >= [comments.totalPage integerValue]) return;
    isLoading = YES;
    
    if (currentPage == 0) {
        [self showLoading];
    }
    
    TicketResult *result = [[TicketResult alloc]initResult:Comments.class success:^(id  _Nonnull data) {
        currentPage++;
        if (comments) {
            Comments * c = (Comments *)data;
            comments.list = [comments.list arrayByAddingObjectsFromArray:c.list];
        } else {
            comments = (Comments *)data;
        }
        [self.tableView reloadData];
        [self hideLoading];
        isLoading = NO;
    } fail:^(NSString * _Nonnull msg, NSInteger code) {
        isLoading = NO;
        [self hideLoading];
    }];
    
    [self.request getAllComments:self.movieId inPage:currentPage + 1 result:result];
}

#pragma mark - 加载等待

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
