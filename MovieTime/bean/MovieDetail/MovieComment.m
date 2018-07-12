//
//  MovieComment.m
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieComment.h"

@implementation MovieComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"date": @"date",
             @"comment": @"content",
             @"header": @"headImg",
             @"name": @"nickname"};
}

@end
