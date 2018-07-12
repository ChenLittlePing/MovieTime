//
//  VideoCell.m
//  MovieTime
//
//  Created by cxp on 2018/7/9.
//  Copyright © 2018年 cxp. All rights reserved.
//

#import "VideoCell.h"
#import <AVFoundation/AVPlayerItem.h>
#import "../../../../bean/MovieDetail/MovieDetail.h"

@implementation VideoCell

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    //初始化播放器
    self.player = [[AVPlayer alloc]init];
    //创建一个视频播放图层
    self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //将视频播放图层添加到父控件图层
    [self.playerView.layer addSublayer:self.playLayer];
    
    //添加播放点击事件
    self.play.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPlay:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.play addGestureRecognizer:tapGesture];
    
    //添加播放控制view显示和隐藏点击事件
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
    //注销播放层
    [self.playLayer removeFromSuperlayer];
    
    //注销状态监听
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.playLayer = nil;
    self.player = nil;
    self.playing = NO;
    self.ready = NO;
}

#pragma mark - 配置视频播放数据
-(void)setData:(NSObject *)d {
    MovieDetail *data = (MovieDetail *) d;
    if (data == nil || self.playing) {
        return;
    }
    //根据URL创建播放曲目
    NSURL *url = [NSURL URLWithString:data.videos[0].url];
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self addStatusObserver: item];
}

#pragma mark - 监听播放状态
- (void)addStatusObserver: (AVPlayerItem *) item {
    // 观察status属性
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil];
    // 监听播放完成事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(playDidEnd)
                                         name:AVPlayerItemDidPlayToEndTimeNotification object:item];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"] && change != nil) {
        AVPlayerItem *item = (AVPlayerItem *)object;
        if (item.status == AVPlayerStatusReadyToPlay) {
            self.ready = YES;
            if (self.playing) {
                [self.player play];
            }
        } else if (item.status == AVPlayerStatusFailed) {
            NSLog(@"视频加载失败！");
        } else {
            NSLog(@"视频加载未知错误！");
        }
    }
}

- (void) playDidEnd {
    //恢复到0秒
    CMTime changedTime = CMTimeMakeWithSeconds(0, 1.0);
    [self.player seekToTime:changedTime];
    
    self.playing = NO;
    [self.player pause];
    self.play.image = [UIImage imageNamed:@"Play"];
    self.play.alpha = 1;
}

#pragma mark - 播放控制
- (void)clickPlay:(UITapGestureRecognizer *)gesture {
    if (!self.playing) {
        if (self.ready) { //准备好才能播放，否则等待准备完成才开始播放
            [self.player play];
        }
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

@end
