//
//  演员照片
//
//  Created by cxp on 2018/7/4.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "IconCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation IconCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.iv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 5, SCREEN_WIDTH / 5)];
    self.iv.layer.cornerRadius= SCREEN_WIDTH / 10;
    self.iv.layer.masksToBounds= YES;
    self.iv.contentMode = UIViewContentModeScaleAspectFill;
    self.iv.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    [self.contentView addSubview: self.iv];
    return self;
}

-(void) setData:(NSString *)img {
    [self.iv sd_setImageWithURL: [NSURL URLWithString:img]];
}

@end
