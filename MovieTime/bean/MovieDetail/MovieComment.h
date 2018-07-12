//
//  MovieComment.h
//  MovieTime
//
//  Created by cxp on 2018/7/12.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface MovieComment : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;

@end
