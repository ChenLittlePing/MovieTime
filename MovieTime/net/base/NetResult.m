//
//  NetResult.m
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "NetResult.h"
#import <Mantle/Mantle.h>

@implementation NetResult

-(instancetype)initResult: (Class _Nonnull) model success:(Success)success fail:(Fail)fail {
    self = [super init];
    if (self != nil) {
        self.model = model;
        self.success = success;
        self.fail = fail;
    }
    return self;
}

- (void)parseData:(NSDictionary *)dic {
    if (self.model == nil) {
        @throw [NSException exceptionWithName:@"ArgmentError" reason:@"model should not be nil, call [NetResult initResult] first" userInfo:nil];
    }
    id list = [MTLJSONAdapter modelOfClass:self.model fromJSONDictionary:dic error:nil];
    self.success(list);
}

@end
