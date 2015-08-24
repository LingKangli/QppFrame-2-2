//
//  MultChatUIView.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultChatObj.h"
#import "VoiceObj.h"
#import "UUAVAudioPlayer.h"
#import "MultChatPlayer.h"

@protocol MultChatViewDelegate <NSObject>

@optional
-(void)backFontPageImg:(UIImage*)img WithMultObj:(MultChatObj*)multChO ;

@end

@interface MultChatUIView : UIControl
<VoiceDelegate>{

//    MultChatObj* chatObj;//存放需要传到前一页面的数据《图片，Ｎ个ＵＲＬ，Ｎ个坐标》
//
    UIImageView* chatBGImg;//背景图片
    UIImageView* voiceImg;
    NSURL* currentUrl ;//长按后录音路径
    NSTimer* timer;
    AVAudioRecorder* _recorder;
   
    MultChatObj* thisPageData;
    NSArray* multArray;
}

@property(nonatomic)UIImage* backgroundImg;
@property(nonatomic)id<MultChatViewDelegate>delegate;

-(void)setMultChatObjToView:(MultChatObj*)multChatObj;
@end
