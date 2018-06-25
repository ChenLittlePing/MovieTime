//
//  MovieInfoList.m
//  MovieTime
//
//  Created by cxp on 2018/6/20.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieInfoList.h"

@implementation MovieInfoList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"count": @"count",
             @"movies": @"movies",
             @"totalCinemaCount": @"totalCinemaCount",
             @"totalComingMovie": @"totalComingMovie",
             @"totalHotMovie": @"totalHotMovie"
             };
}

+ (NSValueTransformer *)moviesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:MovieInfo.class];
}

@end
