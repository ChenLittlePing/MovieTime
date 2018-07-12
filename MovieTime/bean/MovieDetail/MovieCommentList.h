//
//  MovieCommentList.h
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "MovieComment.h"

@interface MovieCommentList : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray<MovieComment *> *list;

@end
