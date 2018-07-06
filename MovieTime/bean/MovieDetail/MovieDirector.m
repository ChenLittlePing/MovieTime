//
//  MovieDirector.m
//  MovieTime
//
//  Created by cxp on 2018/7/2.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieDirector.h"

@implementation MovieDirector

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"id": @"directorId",
             @"img": @"directorImg",
             @"name": @"directorName",
             };
}

@end
