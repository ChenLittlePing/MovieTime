//
//  Cell.h
//  MovieTime
//
//  Created by cxp on 2018/6/27.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../bean/MovieDetail/MovieDetail.h"

@interface Cell: UITableViewCell
-(void) setData: (MovieDetail *) data;
@end
