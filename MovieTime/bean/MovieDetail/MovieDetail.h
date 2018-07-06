//
//  MovieDetail.h
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MovieActor.h"
#import "MovieDirector.h"
#import "MovieVideo.h"
#import "MovieRelease.h"

@interface MovieDetail : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray<MovieActor *> *actors;
@property (nonatomic, strong) MovieDirector *director;
@property (nonatomic, strong) NSArray<MovieVideo *> *videos;
@property (nonatomic, strong) NSString *titleCn;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSNumber *> *type;
@property (nonatomic, strong) NSNumber *is3D;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *runTime;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) MovieRelease *show;

@end
