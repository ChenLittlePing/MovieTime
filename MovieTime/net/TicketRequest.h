//
//  TickRequest.h
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "base/Net.h"

@interface TicketRequest : Net

-(void)getHotComments:(NSNumber *)movieId result:(NetResult *)result;
-(void)getAllComments:(NSNumber *)movieId inPage:(int)page result:(NetResult *)result;


@end
