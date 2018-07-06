//
//  MovieVideo.h
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MovieVideo : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *title;

@end
