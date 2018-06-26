//
//  TimeResult.m
//  MovieTime
//
//  Created by cxp on 2018/6/26.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "TimeResult.h"


@implementation TimeResult

- (BOOL)dispose:(NSDictionary *) dic {
    if ([dic[@"code"] isEqual: [NSNumber numberWithInt:1]]) {
        self.fail(dic[@"msg"], 200);
        return YES;
    }
    return NO;
}

@end
