//
//  TicketResult.m
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "TicketResult.h"

@implementation TicketResult

- (BOOL)dispose:(NSDictionary *) dic {
    if ([dic[@"code"] isEqualToString:@"1"]) {
        dic = dic[@"data"];
        id data = [MTLJSONAdapter modelOfClass:self.model fromJSONDictionary:dic error:nil];
        self.success(data);
        return YES;
    } else {
        self.fail(dic[@"msg"], [dic[@"code"] integerValue]);
        return YES;
    }
}

@end
