//
//  CommentCell.m
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "CommentCell.h"
#import "../../../../bean/MovieDetail/MovieComment.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CommentCell

#pragma mark - 初始化

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    self.header.layer.masksToBounds = YES;
    self.header.layer.cornerRadius= self.header.bounds.size.width / 2;
}

#pragma mark - 设置数据

- (void)setData:(NSObject *)d {
    MovieComment *data = (MovieComment *) d;
    if (data.header) {
        [self.header sd_setImageWithURL:[NSURL URLWithString:data.header]];
    }
    self.name.text = data.name;
    self.comment.text = data.comment;
}

@end
