//
//  IconCell.h
//  MovieTime
//
//  Created by cxp on 2018/7/4.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "../Cell.h"

@interface IconCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iv;

-(void) setData:(NSString *)img;

@end
