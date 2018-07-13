//
//  Comments.m
//  MovieTime
//
//  Created by cxp on 2018/7/13.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "Comments.h"

@implementation Comments

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"list": @"cts",
             @"totalPage": @"tpc"
             };
}

+ (NSValueTransformer *)listJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: Comment.class];
}
@end
