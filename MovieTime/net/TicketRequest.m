//
//  TickRequest.m
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "TicketRequest.h"

@implementation TicketRequest

- (NSString *)getBaseUrl {
    return @"https://ticket-api-m.mtime.cn/";
}

-(void)getHotComments:(NSNumber *)movieId result:(NetResult *)result {
    NSDictionary *dic = @{@"movieId": movieId};
    
    [self get: @"movie/hotComment.api" widthParams:dic result:result];
}

@end
