//
//  MovieCommentList.m
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieCommentList.h"

@implementation MovieCommentList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"list": @"list"};
}


+ (NSValueTransformer *)listJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: MovieComment.class];
}

@end
