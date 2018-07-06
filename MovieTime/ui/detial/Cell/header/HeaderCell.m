//
//  ImageCell.m
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "HeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HeaderCell

- (void)setData:(MovieDetail *)data {
    if (data == nil) {
        return;
    }
    [self.image sd_setImageWithURL: [NSURL URLWithString:data.image]];

    NSString *type = @"类型：";

    for (NSString *t in data.type) {
        type = [type stringByAppendingFormat:@"%@ / ",t];
    }
    
    if (data.type != nil && data.type.count > 0) {
        type = [type substringToIndex: [type length] - 2];
    } else {
        type = [type stringByAppendingString:@"暂无"];
    }
    
//    NSTimeInterval interval = [data.showDay doubleValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateString = [formatter stringFromDate: date];


    self.type.text = type;
    self.title.text = [@"影片：" stringByAppendingString:data.titleCn];
    self.time.text = [@"时长：" stringByAppendingString:data.runTime];
    self.show.text = [@"上映：" stringByAppendingString:data.show.date];
    self.rating.text = [@"评分：" stringByAppendingString: [data.rating intValue] < 0? @"暂无" : data.rating];
}

@end
