//
//  Comments.h
//  MovieTime
//
//  Created by cxp on 2018/7/13.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "Comment.h"

@interface Comments : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray<Comment *> *list;
@property (nonatomic, strong) NSNumber *totalPage;

@end
