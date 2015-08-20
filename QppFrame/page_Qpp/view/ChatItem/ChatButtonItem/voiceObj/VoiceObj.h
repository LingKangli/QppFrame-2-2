//
//  VoiceObj.h
//  VoiceObj
//
//  Created by Ling Kangli on 15/7/22.
//  Copyright (c) 2015年 kangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "GifImageButton.h"
//@class GifImageButton;
#define UIScreenWidth [[UIScreen mainScreen]bounds].size.width
#define UIScreenHeight [[UIScreen mainScreen]bounds].size.height


#define voiceFrame CGRectMake(UIScreenWidth/2-40,UIScreenHeight/2-40,80,80)


@protocol VoiceDelegate

-(void)sucessRecorder:(NSURL*)filePath andPicPath:(NSString*) imgPath;
-(void)sucessRecorder:(NSURL*)filePath andPic:(UIImage*) img;

@end

@interface VoiceObj : UIControl<AVAudioRecorderDelegate,AVAudioPlayerDelegate>{

    NSTimer* timer;    
//    UIImageView* imgView ;
    
    double cTime;
    NSURL* _fileUrl;
}

@property(strong,nonatomic)  AVAudioRecorder *recorder;
@property(strong,nonatomic) GifImageButton* recorderBtn;
@property(nonatomic,retain) id<VoiceDelegate>delegate;
@property(nonatomic,strong)UIImageView* imgView;
//@property(nonatomic,strong)NSURL* url;

@property (nonatomic,strong) NSString* imgNormalName;
@property (nonatomic,strong) NSString* imgSelectedName;

@property (nonatomic,strong)UIImage* imgNormal;

@property(nonatomic)CGPoint point;
@property(nonatomic)NSURL* fileUrl;

@end
