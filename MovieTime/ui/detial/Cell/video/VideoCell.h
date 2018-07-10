//
//  VideoCell.h
//  MovieTime
//
//  Created by cxp on 2018/7/9.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "../Cell.h"
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerLayer.h>

@interface VideoCell : Cell

@property (nonatomic, strong) IBOutlet UIView *playerView;
@property (nonatomic, strong) IBOutlet UIImageView *play;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playLayer;

@property BOOL ready;
@property BOOL playing;

@end
