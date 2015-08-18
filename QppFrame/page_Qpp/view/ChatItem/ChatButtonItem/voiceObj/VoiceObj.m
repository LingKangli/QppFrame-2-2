//
//  VoiceObj.m
//  VoiceObj
//
//  Created by Ling Kangli on 15/7/22.
//  Copyright (c) 2015年 kangli. All rights reserved.
//

#import "VoiceObj.h"
#import "UtilBiaoQingData.h"
#import "Utill.h"
@implementation VoiceObj

@synthesize recorderBtn = _recorderBtn;
@synthesize recorder = _recorder;
@synthesize delegate = _delegate;
@synthesize imgView = _imgView;
//@synthesize url = _url;

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self != nil) {
        [self initial:frame];
    }
    return self;
}

-(void)initial:(CGRect)frame{
    _recorderBtn = [[GifImageButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _recorderBtn.layer.borderWidth = 1.0;
    _recorderBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    _recorderBtn.backgroundColor = [UIColor brownColor];
//    [_recorderBtn setTitle:@"recorder" forState:UIControlStateNormal];
   
    [_recorderBtn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
    [_recorderBtn addTarget:self action:@selector(btnUp:) forControlEvents:UIControlEventTouchUpInside];
    [_recorderBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchDragOutside];
    [_recorderBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchCancel];
    [_recorderBtn addTarget:self action:@selector(btnDragUp:) forControlEvents:UIControlEventTouchUpOutside];

    [self addSubview:_recorderBtn];

    [self setRecorder];
    
//    timer = [NSTimer  timerWithTimeInterval:0 target:self selector:@selector(detectionVoice)userInfo:nil repeats:YES];

    _imgView = [[UIImageView alloc]initWithFrame:voiceFrame];

    
//
}


-(void)setRecorder{
    //录音
    
    static int seedNum = 0;
    if(seedNum >= 1000)
        seedNum = 0;
    seedNum++;
    
    //
    NSError* error ;
    //    路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    
//    NSArray*paths = NSTemporaryDirectory();
    NSString *tmpDir = [paths objectAtIndex:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *file = [NSString stringWithFormat:@"%@tmp%@%03d.aac",tmpDir, currentDateStr, seedNum];
    
    NSLog(@"the file in : %@",file);
    NSURL* url = [NSURL fileURLWithPath:file];
    
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init] ;
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    
    _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    
    //开启音量检测
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
}

//-(void)playSoundEffect:(NSString *)name{
//    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:nil];
//    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
//    //1.获得系统声音ID
//    SystemSoundID soundID=0;
//    /**
//     * inFileUrl:音频文件url
//     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
//     */
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
//    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
//    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
//    //2.播放音频
//    AudioServicesPlaySystemSound(soundID);//播放音效
//    //    AudioServicesPlayAlertSound(soundID);//播放音效并震动
//}

//- (NSString *)filePathWithName:(NSString *)filename
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    return [documentsDirectory stringByAppendingPathComponent:filename];
//}

-(void)btnDown:(id)sender{
   
    if ([_recorder prepareToRecord]) {
        //开始
        [_recorder record];
    }
    NSLog(@"the test is down");
    [[[UIApplication sharedApplication] keyWindow] addSubview:_imgView];//将图片添加到当前窗口。

    timer = [NSTimer  timerWithTimeInterval:0 target:self selector:@selector(detectionVoice)userInfo:nil repeats:YES];
    
    [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    

//    [self beginCountTime];
//    [self beginRecordVoice];
    /*
    [self audio];

    NSLog(@"btnDown.");
    //创建录音文件，准备录音
    if ([_recorder prepareToRecord]) {
        //开始
        [_recorder record];
    }
    //设置定时检测
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
//    /开启定时器
//    [timer setFireDate:[NSDate distantPast]];
     */
}

//btnUp btnDragUp
-(void)btnUp:(id)sender{//xxv录音完毕

    NSLog(@"test. the timer is %f",_recorder.currentTime);
    
//    [timer invalidate];
//    [_recorder stop];
    
    //    NSLog(@"the test is up");
    [self stopRecordVoice];
    [self stopCountTime];
[timer invalidate];
  /*
    NSLog(@"btnUp.");
    double theTime = _recorder.currentTime;
    if (theTime > 0.2) {//如果录制时间>2 发送
        NSLog(@"发出去");
//        [self.delegate sucessRecorder:_recorder.url];
        [self.delegate sucessRecorder:_recorder.url andPicPath:_imgNormalName];
//        -(void)sucessRecorder:(NSURL*)filePath andPicPath:(NSURL*) imgPath;

    }else {
        //删除记录的文件
        [_recorder deleteRecording];
        //删除存储的
    }
    
//    [self cancelRecordVoice];
 
    [_recorder stop];
    [timer invalidate];
    [_imgView removeFromSuperview];
*/
    
}


-(void)btnDragUp:(id)sender{
    
    NSLog(@"the test is dragUp");

//++++++取消此次录音+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    [self cancelRecordVoice];
    [self stopCountTime];

//[timer invalidate];
    /*
    NSLog(@"btnDragUp.");
    //删除录制文件
    [_recorder deleteRecording];
    [_recorder stop];
    [timer invalidate];
    _imgView.image = nil;

    NSLog(@"取消发送");
     */
}

-(void) beginRecordVoice{

//+++开始录音+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if ([_recorder prepareToRecord]) {
        //开始
        [_recorder record];
    }

}
-(void) cancelRecordVoice{
    [_recorder stop];
    [_recorder deleteRecording];
//    [timer invalidate];
 
    NSLog(@"取消发送");
}
-(void) stopRecordVoice{
    double theTime = _recorder.currentTime;

    if (theTime> 0.2) {//如果录制时间>2 发送
        NSLog(@"发出去");
        //        [self.delegate sucessRecorder:_recorder.url];
        //        -(void)sucessRecorder:(NSURL*)filePath andPicPath:(NSURL*) imgPath;
        
        if (_imgNormal) {
            NSLog(@"imageNormal.");
//            -(void)sucessRecorder:(NSURL*)filePath andPic:(UIImage*) img;
            [self.delegate sucessRecorder:_recorder.url andPic:_imgNormal];
        }else{
            [self.delegate sucessRecorder:_recorder.url andPicPath:_imgNormalName];

            NSLog(@"the test .");
        }
        
        
        
    }else {
        //删除记录的文件
        [_recorder deleteRecording];
        //删除存储的
    }
    [_recorder stop];
//    [timer setFireDate:[NSDate distantFuture]];
//    [timer invalidate];
}

-(void)beginCountTime{
    [[[UIApplication sharedApplication] keyWindow] addSubview:_imgView];//将图片添加到当前窗口。
    timer = [NSTimer  timerWithTimeInterval:0 target:self selector:@selector(detectionVoice)userInfo:nil repeats:YES];

     [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //    /开启定时器
//        [timer setFireDate:[NSDate distantPast]];

}
-(void)stopCountTime{
//    [timer setFireDate:[NSDate distantFuture]];
//    [_recorder stop];
    [timer invalidate];
//    _imgView.image = nil;
    [_imgView removeFromSuperview];
    
}

-(void)detectionVoice{//按下时音量图标变化

    NSLog(@"test. the timer is %f",_recorder.currentTime);
    
    [ _recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [_recorder peakPowerForChannel:0]));
    NSLog(@"lowPassResult:%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.02) {
        _imgView.image = [UIImage imageNamed:@"record_animate_01.png"];
    }else if (0.02<lowPassResults<=0.04) {
        _imgView.image = [UIImage imageNamed:@"record_animate_01.png"];
    }else if (0.04<lowPassResults<=0.06) {
        _imgView.image = [UIImage imageNamed:@"record_animate_02.png"];
    }else if (0.06<lowPassResults<=0.08) {
        _imgView.image = [UIImage imageNamed:@"record_animate_03.png"];
    }else if (0.08<lowPassResults<=0.10) {
        _imgView.image = [UIImage imageNamed:@"record_animate_04.png"];
    }
}
/*
-(void)cancelRecordVoice{ //取消录音

    [timer setFireDate:[NSDate distantFuture]];
    [timer invalidate];
    timer = nil;
    _imgView.image = nil;
    [_recorder stop];

}
*/
-(void)setImgNormalName:(NSString *)imgNormalName{
    
    _imgNormalName = imgNormalName;
    
    if ([[[UtilBiaoQingData shareUtil] getBiaoQingType:imgNormalName] isEqualToString:BQPNG]) {
        [_recorderBtn setImage:[UIImage imageNamed:imgNormalName] forState:UIControlStateNormal];
    }
    else if ([[[UtilBiaoQingData shareUtil] getBiaoQingType:imgNormalName] isEqualToString:BQGIF]) {
       [_recorderBtn setImageForPath:[[NSBundle mainBundle]pathForResource:[imgNormalName stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif" ]];

        
    }
}

-(void)setImgNormal:(UIImage *)imgNormal{
    _imgNormal = imgNormal;
    [_recorderBtn setImage:imgNormal forState:UIControlStateNormal];
}

//-(void)setImgSelectedName:(NSString *)imgSelectedName{
//    _imgSelectedName = imgSelectedName;
////    [_recorderBtn setImage:[UIImage imageNamed:imgSelectedName] forState:UIControlStateHighlighted];
////    [_recorderBtn setImageForPath:imgSelectedName];
//    
//    [_recorderBtn setImageForPath:[[NSBundle mainBundle]pathForResource:@"20088129321985" ofType:@"gif" ]];
//
//}


//- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
//
////    if (flag) {
////        cTime = _recorder.currentTime;
////    }
//    if (flag) {
//        NSLog(@"btnUp.");
//        double cTime = _recorder.currentTime;
//        if (cTime > 0.2) {//如果录制时间>2 发送
//            NSLog(@"发出去");
//            //        [self.delegate sucessRecorder:_recorder.url];
//            [self.delegate sucessRecorder:_recorder.url andPicPath:_imgNormalName];
//            //        -(void)sucessRecorder:(NSURL*)filePath andPicPath:(NSURL*) imgPath;
//            
//        }else {
//            //删除记录的文件
//            [_recorder deleteRecording];
//            //删除存储的
//        }
//        [_recorder stop];
//        [timer invalidate];
//        NSLog(@"sucessful.");
//    }
//}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{

    NSLog(@"test////");
}

@end
