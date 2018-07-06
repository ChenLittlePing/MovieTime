//
//  MovieActor.m
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "MovieActor.h"

@implementation MovieActor

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"id": @"actorId",
             @"img": @"actorImg",
             @"name": @"actor",
             @"roleName": @"roleName"
             };
}

@end
