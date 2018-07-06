//
//  ImageCell.h
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Cell.h"

@interface HeaderCell : Cell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *show;
@property (weak, nonatomic) IBOutlet UILabel *rating;

@end
