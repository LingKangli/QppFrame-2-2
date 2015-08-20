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

@interface ChatViewController : BaseUIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,KeyBoradContentDelegate,testDelegate,keyBoradDelegate,VoiceDelegate,AVAudioPlayerDelegate,playerDelegate>{

    BOOL isShowKey;
    
    
    UITableView* chatTableView;
    KeyBoradView* keyBorad;
    
     NSMutableArray  *_allMessagesFrame;
    NSString* filePath;
    
    AVAudioPlayer* player;
//    =  [[AVAudioPlayer alloc]initWithContentsOfURL:_messageFrame.message.voicePath error:nil];
//     player.delegate = self;
//    player.delegate = self;

}

@property (strong,nonatomic)UIButton* backBtn;
@end
