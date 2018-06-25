//
//  Net.h
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NetResult.h"

@interface Net : NSObject

-(NSString *) getBaseUrl;
-(void) customerConfig: (AFHTTPSessionManager *) manager;

-(NSString *) getUrl: (NSString *)endpoint;

-(void) get:(NSString *)endPoint
        widthParams:(NSDictionary *)params
        result:(NetResult *) result;

-(void) post: (NSString *) endPoint
        widthParams:(NSDictionary *)params
        result:(NetResult *) result;

@end
