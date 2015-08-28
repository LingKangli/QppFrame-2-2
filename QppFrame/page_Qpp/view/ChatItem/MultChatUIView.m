//
//  MultChatUIView.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "MultChatUIView.h"
#import "Utill.h"

#define playerWidth 40

@implementation MultChatUIView

@synthesize backgroundImg;
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{

    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self; 
}

-(void)initial{
    self.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    number = 0;
    [self setViewFrame];
    
}

-(void)setViewFrame{

    self.backgroundColor = [UIColor blackColor];
    
    UIView* titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.1)];
    titleView.backgroundColor = [UIColor redColor];
//    [self addSubview:titleView];
    [self insertSubview:titleView atIndex:1];
    
    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, self.frame.size.width*0.2, self.frame.size.height*0.05)];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backBtn];
    
    UIButton* doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth-UIScreenWidth*0.2-10, 30, UIScreenWidth*0.2, UIScreenHeight*0.05)];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:doneBtn];
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, backBtn.frame.origin.y, UIScreenWidth*0.3, UIScreenHeight*0.05)];
    title.text = @"表情";
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [titleView addSubview:title];
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0,titleView.frame.origin.y+titleView.frame.size.height, self.frame.size.width, UIScreenHeight-2*(titleView.frame.size.height+titleView.frame.origin.y))];
    bgView.backgroundColor = [UIColor greenColor];
    bgView.tag = 2;
    [self insertSubview:bgView belowSubview:titleView];
    
//    chatBGImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleView.frame.origin.y+titleView.frame.size.height, self.frame.size.width, UIScreenHeight-2*(titleView.frame.size.height+titleView.frame.origin.y))];
    
    chatBGImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height)];
    chatBGImg.tag = 1;
    [bgView addSubview:chatBGImg];
    
    voiceImg = [[UIImageView alloc]initWithFrame:voiceFrame];
    [[[UIApplication sharedApplication] keyWindow] addSubview:voiceImg];//将图片添加到当前窗口。

    thisPageData = [[MultChatObj alloc]init];
    thisPageData.voiceArray = [[NSMutableArray alloc]init];

    UIView* bottomBg = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.frame.origin.y+bgView.frame.size.height, UIScreenWidth, 2*(bgView.frame.size.height-titleView.frame.size.height))];
    bottomBg.backgroundColor = [UIColor redColor];
    [self insertSubview:bottomBg aboveSubview:bgView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    /*
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:ChatBGImg];
    
    NSLog(@"%f==%f",touchPoint.x,touchPoint.y);
    int stringFloat = (int)(touchPoint.x);
    int stringFloat1 = (int)(touchPoint.y);
    NSLog(@"%i%i",stringFloat,stringFloat1);
    */
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if([self isContains:touches]){
        flag = YES;
        
        [self setUrl];
        [self setRecorder];
        
        MultChatPlayer* player = [[MultChatPlayer alloc]initWithFrame:CGRectMake(point.x, point.y, playerWidth, playerWidth)];
        player.playerImg = [UIImage imageNamed:@"myVoice.png"];
        player.point = point;
        player.playUrl = currentUrl;//播放声音地址
        player.tag = number++;
        NSLog(@"the tag is %i",player.tag);
        player.delegate = self;
        player.center =CGPointMake(point.x+bgView.frame.origin.x, point.y-bgView.frame.origin.y);
        [bgView addSubview:player];
        [thisPageData.voiceArray addObject:player];
        ;
    }else{
        flag = NO;
        NSLog(@"test ..touch out.");
    }
    
//    if (voiceImg != nil && ![self isContains:touches]) {
//        [self stopRecordVoice];
//        [self stopCountTime];
//        [timer invalidate];
//    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if([self isContains:touches] && flag ){
        [self stopRecordVoice];
        [self stopCountTime];
        [timer invalidate];
    }else{
        NSLog(@"test ..touch out.");
    }
}

-(void)multChatPlayerMove:(CGPoint)centerP OfTag:(NSInteger)tag{

    NSLog(@"delegate tag is %d",tag);
    NSLog(@"delegate this point is %f",centerP.x);
    NSLog(@"delegate this point is %f",centerP.y);

    NSLog(@"moved center point.x :%f  point.y: %f",    ((MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:tag]).center.x,((MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:tag]).center.y);
 }

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch moved.");
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if([self isContains:touches] && flag){
      ((MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:([thisPageData.voiceArray count]-1)]).center = CGPointMake(point.x+bgView.frame.origin.x, point.y-bgView.frame.origin.y);
    }
}

-(void)setUrl{
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
    currentUrl = [NSURL fileURLWithPath:file];
    return ;
}

-(void)setRecorder{
    //录音
    NSError* error;
    
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
    
    
    _recorder = [[AVAudioRecorder alloc]initWithURL:currentUrl settings:recordSetting error:&error];
    //开启音量检测
    _recorder.meteringEnabled = YES;
    _recorder.delegate = self;
    
    if ([_recorder prepareToRecord]) {
        //开始
        [_recorder record];
    }
    NSLog(@"the test is down");
    [[[UIApplication sharedApplication] keyWindow] addSubview:voiceImg];//将图片添加到当前窗口。
    
    timer = [NSTimer  timerWithTimeInterval:0 target:self selector:@selector(detectionVoice)userInfo:nil repeats:YES];
    
    [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
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
        voiceImg.image = [UIImage imageNamed:@"record_animate_01.png"];
    }else if (0.02<lowPassResults<=0.04) {
        voiceImg.image = [UIImage imageNamed:@"record_animate_01.png"];
    }else if (0.04<lowPassResults<=0.06) {
        voiceImg.image = [UIImage imageNamed:@"record_animate_02.png"];
    }else if (0.06<lowPassResults<=0.08) {
        voiceImg.image = [UIImage imageNamed:@"record_animate_03.png"];
    }else if (0.08<lowPassResults<=0.10) {
        voiceImg.image = [UIImage imageNamed:@"record_animate_04.png"];
    }
}



-(BOOL)isContains:(NSSet *)touches {
    
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    CGRect rect = bgView.frame;
   
    if (CGRectContainsPoint(rect, point)) {
        return YES;
    }else{
        return NO;
    }
}

-(void) stopRecordVoice{
    double theTime = _recorder.currentTime;
    [_recorder stop];

    if (theTime> 0.2) {//如果录制时间>2 发送
        NSLog(@"发出去");
        //        [self.delegate sucessRecorder:_recorder.url];
        //        -(void)sucessRecorder:(NSURL*)filePath andPicPath:(NSURL*) imgPath;
//        ((MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:([thisPageData.voiceArray count]-1)]).center =;

        if (voiceImg) {
            
            NSLog(@"imageNormal.");
            //            -(void)sucessRecorder:(NSURL*)filePath andPic:(UIImage*) img;
//            [self.delegate sucessRecorder:_recorder.url andPic:_imgNormal];
        }else{
//            [self.delegate sucessRecorder:_recorder.url andPicPath:_imgNormalName];
            
            NSLog(@"the test .");
        }
        
        
        
    }else {
        //删除记录的文件
        [_recorder deleteRecording];
        [(MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:([thisPageData.voiceArray count]-1)] removeFromSuperview];
        [thisPageData.voiceArray removeObjectAtIndex:([thisPageData.voiceArray count]-1)] ;
        
        //删除存储的
    }
}
-(void)stopCountTime{
    //    [timer setFireDate:[NSDate distantFuture]];
    //    [_recorder stop];
    [timer invalidate];
    //    _imgView.image = nil;
    [voiceImg removeFromSuperview];
    
}
//VoiceOBj Delegate
//-(void)sucessRecorder:(NSURL*)filePath andPic:(UIImage*) img{
//
//    NSLog(@"filePath:%@",filePath);
//    
//}

-(void)setMultChatObjToView:(MultChatObj*)multChatObj{

    chatBGImg.image = multChatObj.chatBgImg;
    thisPageData.chatBgImg = chatBGImg.image;
    thisPageData.voiceArray = [[NSMutableArray alloc]init];
    NSLog(@"回来了 center point.x :%f  point.y: %f",    ((MultChatPlayer*)[multChatObj.voiceArray objectAtIndex:1]).center.x,((MultChatPlayer*)[multChatObj.voiceArray objectAtIndex:1]).center.y);

    for (int i = 0; i < [multChatObj.voiceArray count]; i++) {
        MultChatPlayer* player = (MultChatPlayer*)[multChatObj.voiceArray objectAtIndex:i];
        player.center = ((MultChatPlayer*)[multChatObj.voiceArray objectAtIndex:i]).center;
        player.frame = ((MultChatPlayer*)[multChatObj.voiceArray objectAtIndex:i]).frame;
        [player setImage:((MultChatPlayer*)[multChatObj.voiceArray objectAtIndex:i]).playerImg forState:UIControlStateNormal];
        
        NSLog(@"回来了for center point.x :%f  point.y: %f", player.center.x,player.center.y);

        
//        [self addSubview:player];
        [bgView insertSubview:player atIndex:20];

        [thisPageData.voiceArray addObject:player];
    }
//    for (MultChatPlayer* player in multChatObj.voiceArray) {
//        player = [multChatObj.voiceArra];
//        player.playerImg = [UIImage imageNamed:@"myVoice.png"];
//        player.point = point;
//        player.center = point;
//        player.playUrl = currentUrl;//播放声音地址
//        [self addSubview:player];
//    }
}

-(void)clickLeftBtn{ //back
    NSLog(@"clickLeftBtn");
//    -(void)backFontPage:(MultChatObj*)multChO;
//    [self.delegate backFontPage:thisPageData];
    [self removeFromSuperview];
}

-(void)clickRightBtn{
    
    NSLog(@"完了 center point.x :%f  point.y: %f",    ((MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:1]).center.x,((MultChatPlayer*)[thisPageData.voiceArray objectAtIndex:1]).center.y);
    [self.delegate backFontPageImg:chatBGImg.image WithMultObj:thisPageData];
    [self removeFromSuperview];
}
-(void)setBackgroundImg:(UIImage *)backgroundImage{//设置背景图片

    chatBGImg.image = backgroundImage;
    thisPageData.chatBgImg = backgroundImage;
}



@end
