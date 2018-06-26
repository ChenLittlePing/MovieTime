//
//  MovieInfo.m
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieInfo.h"

@implementation MovieInfo

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"titleCn": @"titleCn",
       @"day": @"rDay",
       @"month": @"rMonth",
       @"year": @"rYear",
       @"cover": @"img",
       @"desc": @"commonSpecial",
       @"actor1": @"actorName1",
       @"actor2": @"actorName2",
       @"director": @"directorName",
       @"is3D": @"is3D",
       @"type": @"type",
       @"length": @"length",
       @"id": @"movieId"};
}

+ (NSValueTransformer *)is3DJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

@end
