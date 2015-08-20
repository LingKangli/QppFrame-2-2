//
//  MultChatPlayer.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "MultChatPlayer.h"

@implementation MultChatPlayer

@synthesize playerImg;
@synthesize playUrl = _playUrl;
@synthesize point = _point;

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        _playerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_playerImg];
        
        [self addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setPlayerImg:(UIImage *)playerImg{

    _playerImg.image = playerImg;
}
-(void)clickBtn{

    player = [UUAVAudioPlayer sharedInstance];
    [player playSongWithUrl:_playUrl];

    NSLog(@"clickBtn is ok%@",self.playUrl);
}

@end
