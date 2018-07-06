//
//  MovieRelease.m
//  MovieTime
//
//  Created by cxp on 2018/7/4.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieRelease.h"

@implementation MovieRelease

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"date": @"date",
             @"location": @"location"};
}

@end
