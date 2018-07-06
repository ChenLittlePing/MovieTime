//
//  MovieActor.h
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MovieActor : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *roleName;


@end
