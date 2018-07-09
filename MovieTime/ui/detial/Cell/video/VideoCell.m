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

- (void)clickView:(UITapGestureRecognizer *)gesture {
    if (!self.playing) {
        [self.player play];
        self.playing = YES;
    } else {
        [self.player pause];
        self.playing = NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //初始化播放器
    self.player = [[AVPlayer alloc]init];
    //创建一个视频播放图层
    self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //将视频播放图层添加到父控件图层
    [self.playerView.layer addSublayer:self.playLayer];
    
    self.playerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickView:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.playerView addGestureRecognizer:tapGesture];
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
