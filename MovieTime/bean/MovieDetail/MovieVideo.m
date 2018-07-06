//
//  MovieVideo.m
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieVideo.h"

@implementation MovieVideo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"url": @"url",
             @"title": @"title"};
}

@end
