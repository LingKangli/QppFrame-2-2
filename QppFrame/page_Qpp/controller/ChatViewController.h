//
//  ChatViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "SendMessageView.h"
#import "ChatRecordView.h"

#import "KeyBoradView.h"

#import "VoiceObj.h"

#import "Message.h"
#import "MessageFrame.h"
#import "MessageCell.h"

#import "MultChatUIView.h"

#import "AppDelegate.h"
#import "TitleView.h"

@interface ChatViewController : BaseUIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,KeyBoradContentDelegate,testDelegate,keyBoradDelegate,VoiceDelegate,AVAudioPlayerDelegate,playerDelegate,MultChatViewDelegate>{

    BOOL isShowKey;
    
    
    UITableView* chatTableView;
    
    
    NSMutableArray  *_allMessagesFrame;
    NSString* filePath;
    
    AVAudioPlayer* player;
//    =  [[AVAudioPlayer alloc]initWithContentsOfURL:_messageFrame.message.voicePath error:nil];
//     player.delegate = self;
//    player.delegate = self;

    AppDelegate* aDelegate;
    TitleView* titleView;
}

@property (strong,nonatomic)UIButton* backBtn;
@property(strong,nonatomic)NSString* titleValue;
@property(strong,nonatomic)KeyBoradView* keyBorad;
//接收的图片和声音的路径
@property (strong,nonatomic)NSMutableDictionary *dataDict;
//图片路径
@property(strong,nonatomic)NSString *filePath;
+(ChatViewController *)sharedInstance;
//传值 begin
//SecondViewController.h
//typedef void (^ablock)(NSString *str);
////SecondViewController.h
//@property (nonatomic, copy) ablock block;
//传值 end

@end
