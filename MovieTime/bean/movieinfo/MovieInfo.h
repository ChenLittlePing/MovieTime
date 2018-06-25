//
//  MovieInfo.h
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MovieInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *titleCn;
@property (nonatomic, strong) NSString *titleEn;

@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *year;

@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *actor1;
@property (nonatomic, strong) NSString *actor2;
@property (nonatomic, strong) NSString *director;
//@property bool *is3D;
//@property bool *type;
@property (nonatomic, strong) NSNumber *length;
@property (nonatomic, strong) NSNumber *id;

@end
