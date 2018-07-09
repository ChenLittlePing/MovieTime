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
#import "Cell/video/VideoCell.h"

@interface MovieDetailController ()

@end

static NSString *HEADER_CELL_ID;
static NSString *ACTOR_CELL_ID;
static NSString *VIDEO_CELL_ID;
static NSString *SIMPLE_CELL_ID;


MovieDetail *movieDetail;
int count = 1;
BOOL isOpening;

@implementation MovieDetailController

-(void)viewDidLoad {
    [self initCellID];
    [self initList];
    [self start];
}

- (void)dealloc {
    movieDetail = nil;
    isOpening = false;
}

- (void)initCellID {
    HEADER_CELL_ID = NSStringFromClass([HeaderCell class]);
    ACTOR_CELL_ID = NSStringFromClass([PeopleCell class]);
    VIDEO_CELL_ID = NSStringFromClass([VideoCell class]);
    SIMPLE_CELL_ID = NSStringFromClass([UITableViewCell class]);
}

- (void)initList {
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:SIMPLE_CELL_ID];
    [self.tableview registerNib:[UINib nibWithNibName:HEADER_CELL_ID bundle:nil] forCellReuseIdentifier:HEADER_CELL_ID];
    [self.tableview registerNib:[UINib nibWithNibName:ACTOR_CELL_ID bundle:nil] forCellReuseIdentifier:ACTOR_CELL_ID];
    [self.tableview registerNib:[UINib nibWithNibName:VIDEO_CELL_ID bundle:nil] forCellReuseIdentifier:VIDEO_CELL_ID];
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
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        id = ACTOR_CELL_ID;
    } else if (indexPath.row == 3) {
        id = SIMPLE_CELL_ID;
    } else if (indexPath.row == 4) {
        id = VIDEO_CELL_ID;
    } else {
        id = @"cell";
    }
    
    Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:id forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:id owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    if (indexPath.row == 1) {
        ((PeopleCell *)cell).type = 1;
    } else if (indexPath.row == 2) {
        ((PeopleCell *)cell).type = 0;
    } else if (indexPath.row == 3) {
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.text = movieDetail.content;
        [self adjustContentHeight: cell.textLabel];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setData:movieDetail];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 1 || indexPath.row == 2) {
        return SCREEN_WIDTH / 5 + 64;
    }
    self.tableview.rowHeight = UITableViewAutomaticDimension;
    self.tableview.estimatedRowHeight = 300;
    return self.tableview.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 3) { // 展开或折叠介绍内容
        isOpening = !isOpening;
        [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)getData {
    TimeResult *result = [[TimeResult alloc]initResult:MovieDetail.class success:^(id data) {
        [self hideLoading];
        movieDetail = (MovieDetail *) data;
        count = 5;
        [self.tableview reloadData];
    } fail:^(NSString *msg, NSInteger code) {
        [self hideLoading];
    }];
    [self.request getMovieDetail:self.movieId result:result];
}

- (void)adjustContentHeight: (UILabel *)lable {
    if (movieDetail.content.length > 0) {
        NSMutableAttributedString *img_text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", movieDetail.content]];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
        [img_text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lable.text.length)];
        
        lable.attributedText = img_text;
        lable.font = [UIFont systemFontOfSize:14];
    }
    // 获取文本内容宽度，计算展示全部文本所需高度
    CGFloat contentW = SCREEN_WIDTH - 2*10 ;
    NSString *contentStr = lable.text;
    
    NSMutableParagraphStyle *descStyle = [[NSMutableParagraphStyle alloc]init];
    [descStyle setLineSpacing:3];//行间距
    
    CGRect textRect = [contentStr
                       boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT)
                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f], NSParagraphStyleAttributeName : descStyle}
                       context:nil];
    // 这里的高度80是通过指定显示四行文字时，通过打印得到的一个临界值，根据需要自行修改
    // 超过四行文字，折叠按钮不显示
    if (textRect.size.height > 65) {
        // 修改按钮的折叠打开状态
        if (isOpening) {
            lable.numberOfLines = 0;
        } else{
            lable.numberOfLines = 4;
        }
    } else {
        lable.numberOfLines = 0;
    }
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
