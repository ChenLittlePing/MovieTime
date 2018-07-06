//
//  MovieRelease.h
//  MovieTime
//
//  Created by cxp on 2018/7/4.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MovieRelease : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *location;

@end
