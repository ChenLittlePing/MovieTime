//
//  VideoCell.m
//  MovieTime
//
//  Created by cxp on 2018/7/9.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "VideoCell.h"
#import <AVFoundation/AVPlayerItem.h>

@implementation VideoCell

-(void)setData:(MovieDetail *)data {
    if (data == nil || self.playing) {
        return;
    }
    //根据URL创建播放曲目
    NSURL *url = [NSURL URLWithString:data.videos[0].url];
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:item];
}

- (void)clickPlay:(UITapGestureRecognizer *)gesture {
    if (!self.playing) {
        [self.player play];
        self.playing = YES;
        self.play.image = [UIImage imageNamed:@"Pause"];
        [UIView animateWithDuration:1 animations:^{
            if (self.play.alpha == 1) {
                self.play.alpha = 0;
            }
        }];
    } else {
        [self.player pause];
        self.playing = NO;
        self.play.image = [UIImage imageNamed:@"Play"];
    }
}

- (void)clickPlayContainer:(UITapGestureRecognizer *)gesture {
    [UIView animateWithDuration:1 animations:^{
        if (self.play.alpha == 1) {
            self.play.alpha = 0;
        } else {
            self.play.alpha = 1;
        }
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //初始化播放器
    self.player = [[AVPlayer alloc]init];
    //创建一个视频播放图层
    self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //将视频播放图层添加到父控件图层
    [self.playerView.layer addSublayer:self.playLayer];
    
    self.play.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPlay:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.play addGestureRecognizer:tapGesture];
    
    
    self.playerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *playGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPlayContainer:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.playerView addGestureRecognizer:playGesture];
}

- (void)layoutSubviews {
    //设置视频播放图层的frame(宽高比最好是16：9)
    self.playLayer.frame = CGRectMake(0, 0, self.playerView.frame.size.width, self.playerView.frame.size.height);
}

- (void)dealloc {
    [self.playLayer removeFromSuperlayer];
    self.playLayer = nil;
    self.player = nil;
    self.playing = NO;
}

@end
