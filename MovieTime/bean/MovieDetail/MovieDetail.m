//
//  MovieDetail.m
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieDetail.h"

@implementation MovieDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"actors": @"actorList",
             @"director": @"director",
             @"videos": @"videos",
             @"titleCn": @"titleCn",
             @"image": @"image",
             @"content": @"content",
             @"type": @"type",
             @"is3D": @"is3D",
             @"rating": @"rating",
             @"runTime": @"runTime",
             @"year": @"year",
             @"show": @"release"
             };
}

+ (NSValueTransformer *)actorsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: MovieActor.class];
}

+ (NSValueTransformer *)videosJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass: MovieVideo.class];
}

@end
