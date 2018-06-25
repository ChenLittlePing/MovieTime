//
//  MovieInfoList.h
//  MovieTime
//
//  Created by cxp on 2018/6/20.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MovieInfo.h"

@interface MovieInfoList : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSArray<MovieInfo *> *movies;
@property (nonatomic, strong) NSNumber *totalCinemaCount;
@property (nonatomic, strong) NSNumber *totalComingMovie;
@property (nonatomic, strong) NSNumber *totalHotMovie;

@end
