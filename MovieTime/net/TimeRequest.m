//
//  TimeRequest.m
//  MovieTime
//
//  Created by cxp on 2018/6/20.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "TimeRequest.h"

@implementation TimeRequest


-(NSString *)getBaseUrl {
    return @"https://api-m.mtime.cn/";
}

-(void)getSells: (NetResult *) result {
    NSDictionary *dic = @{@"locationId": @"290"};
    [self get:@"PageSubArea/HotPlayMovies.api" widthParams:dic result: result];
}

@end
