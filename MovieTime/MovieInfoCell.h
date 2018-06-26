//
//  MovieInfoCell.h
//  MovieTime
//
//  Created by cxp on 2018/6/19.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *intro;
@property (weak, nonatomic) IBOutlet UILabel *showtime;
@property (weak, nonatomic) IBOutlet UILabel *actors;
@property (weak, nonatomic) IBOutlet UILabel *type;

@end
