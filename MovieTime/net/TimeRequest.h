//
//  TimeRequest.h
//  MovieTime
//
//  Created by cxp on 2018/6/20.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "base/Net.h"

@interface TimeRequest : Net

-(void) getSells: (NetResult *)result;
-(void)getMovieDetail:(NSNumber *)movieId result:(NetResult *)result;

@end
