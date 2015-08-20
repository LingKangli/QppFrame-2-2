//
//  MultChatPlayer.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UUAVAudioPlayer.h"

@interface MultChatPlayer : UIButton<AVAudioRecorderDelegate,AVAudioPlayerDelegate>{
    UIImageView* _playerImg;
    NSURL* _playUrl;
    CGPoint _point;
    
    UUAVAudioPlayer* player;
    
}

@property (nonatomic) UIImage* playerImg;
@property (nonatomic) NSURL* playUrl;
@property (nonatomic) CGPoint point;

@end
