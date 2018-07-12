//
//  MovieComments.h
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MovieCommentList.h"

@interface MovieComments : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) MovieCommentList *mini;
@property (nonatomic, strong) MovieCommentList *plus;

@end
