//
//  NetResult.h
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "../../bean/movieinfo/MovieInfoList.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^Success)(id data);
typedef void(^Fail)(NSString *msg, NSInteger code);

@interface NetResult : NSObject
@property(nonnull) Class model;
@property Success success;
@property Fail fail;

/**
 * 初始化方法
 */
-(instancetype)initResult:(Class _Nonnull)model success:(Success) success fail: (Fail) fail;

/**
 * 解析数据方法
 */
-(void) parseData:(NSDictionary *) dic;

/**
 * 数据处理方法回调接口，用于自定义数据处理方法
 *
 * @return YES：由用户自己处理数据；NO：由默认方法处理数据
 */
-(BOOL) dispose:(NSDictionary *) dic;

NS_ASSUME_NONNULL_END
@end
