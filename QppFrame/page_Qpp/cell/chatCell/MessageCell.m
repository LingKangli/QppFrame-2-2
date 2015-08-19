//
//  MessageCell.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "MessageFrame.h"
#import "GifImageButton.h"
#import "UtilBiaoQingData.h"
#import "Utill.h"
#import <AVFoundation/AVFoundation.h>

@interface MessageCell ()
{
    UIButton     *_timeBtn;
    UIImageView *_iconView;
    GifImageButton    *_contentBtn;
    UIButton   *_voiceBtn;
    
}

@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#warning 必须先设置为clearColor，否则tableView的背景会被遮住
        self.backgroundColor = [UIColor clearColor];
        
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        // 2、创建头像
        _iconView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_iconView];
        
        // 3、创建内容
        _contentBtn = [GifImageButton buttonWithType:UIButtonTypeCustom];
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        _contentBtn.layer.cornerRadius = 2.0;
//        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_contentBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_contentBtn];
        
        contentVoiceIsPlaying = NO;

    }
    return self;
}

-(void)click:(id)sender{

    NSLog(@"the test is click.");
}


- (void)setMessageFrame:(MessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    Message *message = _messageFrame.message;
    
    // 1、设置时间
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];

    _timeBtn.frame = _messageFrame.timeF;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:message.icon];
    _iconView.frame = _messageFrame.iconF;
//    UIImage *normal ;//（被赋值，此值为一个蒙板的形状）
    
//    normal = [UIImage imageNamed:@"chatfrom_doctor_icon"];
//    normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5, 5)];    // 3、设置内容
//    [self makeMaskView:_iconView withImage:normal];
    
    switch (message.showType) {
        case MessageShowTypeText:
            [self setTextContent:message];
            break;
        case MessageShowTypeImg:
            [self setImgContent:message];
            break;
        
        case MessageShowTypeImgVoice:
            [self setVoiceImgContent:message];
            break;
        case MessageShowTypeData:
            [self setImgData:message];
            break;
        case MessageShowTypeImgVoiceByUIIMG:
            [self setVoiceImageByUIIMG:message];
        default:
            break;
    }
 
}

-(void)setTextContent:(Message*) message{

    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBtn.frame = _messageFrame.contentF;
    
    if (message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
    UIImage *normal , *focused;
    if (message.type == MessageTypeMe) {
        
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        
//        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(2, 100, 2, 100)];
        
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        [_contentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }else{
        
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
//        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
           // UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];

}

-(void)setImgContent:(Message*) message{
    
//    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    
//    [_contentBtn setImage:[UIImage imageWithContentsOfFile:message.content] forState:UIControlStateNormal];
//    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBtn.frame = _messageFrame.contentF;
    
    if (message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
    NSLog(@"message.content is %@ is",message.content);
    
    if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQPNG]) {
        [_contentBtn setImage:[UIImage imageNamed:message.content] forState:UIControlStateNormal];
    }else if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQGIF]) {
        [_contentBtn setImageForPath:[[NSBundle mainBundle]pathForResource:[message.content stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif" ]];
        
    }else{
        [_contentBtn setImage:[UIImage imageNamed:message.content] forState:UIControlStateNormal];
    
    }
    /*
    UIImage *normal , *focused;
    if (message.type == MessageTypeMe) {
        
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
    */
}

-(void)setImgData:(Message*)message{
    
    //    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _voiceBtn = [[UIButton alloc]init];
    _voiceBtn.frame = _messageFrame.voiceF;
    [_voiceBtn setImage:[UIImage imageNamed:@"voice@2x.png"] forState:UIControlStateNormal];
    [_voiceBtn addTarget:self action:@selector(voiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    player = [[UUAVAudioPlayer alloc]initWithContentsOfURL:_messageFrame.message.voicePath error:nil];
    //    player.delegate = self;
    
    [self.contentView addSubview:_voiceBtn];
    
    //    lingkangli begin
    //    if(!contentVoiceIsPlaying){
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"VoicePlayHasInterrupt" object:nil];
    contentVoiceIsPlaying = YES;
    audio = [UUAVAudioPlayer sharedInstance];
    //        audio.delegate = self;
    //        [audio playSongWithUrl:voiceURL];
    //        [audio playSongWithUrl: message.voicePath];
    //    }else{
    //        [self UUAVAudioPlayerDidFinishPlay];
    //    }
    //    lingkangli end
    
     [_contentBtn setImage:[UIImage imageWithData:[message.imageData copy]] forState:UIControlStateNormal];
    
//    if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQPNG]) {
//        [_contentBtn setImage:[UIImage imageNamed:message.content] forState:UIControlStateNormal];
//    }else if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQGIF]) {
//        [_contentBtn setImageForPath:[[NSBundle mainBundle]pathForResource:[message.content stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif" ]];
//        
//    }
    
    
    NSLog(@"mes content:%@",message.content);
    _contentBtn.frame = _messageFrame.contentF;
    //  _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    
    if (message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
    
    /*
     UIImage *normal , *focused;
     if (message.type == MessageTypeMe) {
     
     normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
     normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
     focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
     focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
     }else{
     
     normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
     normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
     focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
     focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
     
     }
     [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
     [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
     */
    NSLog(@"message:%@",message);
}

//[self setVoiceImageByUIIMG:message];

-(void)setVoiceImageByUIIMG:(Message*)message{
    //    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _voiceBtn = [[UIButton alloc]init];
    _voiceBtn.frame = _messageFrame.voiceF;
    [_voiceBtn setImage:[UIImage imageNamed:@"voice@2x.png"] forState:UIControlStateNormal];
    [_voiceBtn addTarget:self action:@selector(voiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_voiceBtn];
    contentVoiceIsPlaying = YES;
    audio = [UUAVAudioPlayer sharedInstance];

//    if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQPNG]) {
//        [_contentBtn setImage:[UIImage imageNamed:message.content] forState:UIControlStateNormal];
//    }else if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQGIF]) {
//        [_contentBtn setImageForPath:[[NSBundle mainBundle]pathForResource:[message.content stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif" ]];
//        
//    }
    [_contentBtn setImage:message.image forState:UIControlStateNormal];
    
//    NSLog(@"mes content:%@",message.content);
    _contentBtn.frame = _messageFrame.contentF;
    if (message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
}

-(void)setVoiceImgContent:(Message*)message{
    
    //    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _voiceBtn = [[UIButton alloc]init];
    _voiceBtn.frame = _messageFrame.voiceF;
    [_voiceBtn setImage:[UIImage imageNamed:@"voice@2x.png"] forState:UIControlStateNormal];
    [_voiceBtn addTarget:self action:@selector(voiceBtn:) forControlEvents:UIControlEventTouchUpInside];
//    player = [[UUAVAudioPlayer alloc]initWithContentsOfURL:_messageFrame.message.voicePath error:nil];
//    player.delegate = self;
    
    [self.contentView addSubview:_voiceBtn];
    
//    lingkangli begin
//    if(!contentVoiceIsPlaying){
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"VoicePlayHasInterrupt" object:nil];
        contentVoiceIsPlaying = YES;
        audio = [UUAVAudioPlayer sharedInstance];
//        audio.delegate = self;
        //        [audio playSongWithUrl:voiceURL];
//        [audio playSongWithUrl: message.voicePath];
//    }else{
//        [self UUAVAudioPlayerDidFinishPlay];
//    }
//    lingkangli end
    
    if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQPNG]) {
        [_contentBtn setImage:[UIImage imageNamed:message.content] forState:UIControlStateNormal];
    }else if ([[[UtilBiaoQingData shareUtil]getBiaoQingType:message.content]  isEqualToString:BQGIF]) {
        [_contentBtn setImageForPath:[[NSBundle mainBundle]pathForResource:[message.content stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif" ]];

    }

   
    NSLog(@"mes content:%@",message.content);
    _contentBtn.frame = _messageFrame.contentF;
//  _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);

    if (message.type == MessageTypeMe) {
                _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
    
    /*
    UIImage *normal , *focused;
    if (message.type == MessageTypeMe) {
        
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
*/
    NSLog(@"message:%@",message);
}

-(void)voiceBtn:(id)sender{

        [audio playSongWithUrl:_messageFrame.message.voicePath];
}

//- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
//    
//    NSLog(@"test////");
//}

- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image
{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}


@end
