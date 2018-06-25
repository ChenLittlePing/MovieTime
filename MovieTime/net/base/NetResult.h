//
//  NetResult.h
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "../../bean/movieinfo/MovieInfoList.h"

typedef void(^Success)(id data);
typedef void(^Fail)(NSString *msg, NSInteger code);

@interface NetResult : NSObject

@property(nonnull) Class model;
@property Success success;
@property Fail fail;

-(instancetype)initResult:(Class _Nonnull)model success:(Success) success fail: (Fail) fail;

-(void) parseData: (NSDictionary *) dic;

@end
