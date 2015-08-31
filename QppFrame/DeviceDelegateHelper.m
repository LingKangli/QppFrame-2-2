//
//  DeviceDelegateHelper.m
//  QppFrame
//
//  Created by xuannalisha on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "DeviceDelegateHelper.h"
#import "ChatViewController.h"
#import "DeviceChatHelper.h"
@interface DeviceDelegateHelper()
@property(atomic, assign) NSUInteger offlineCount;

@end

@implementation DeviceDelegateHelper


+(DeviceDelegateHelper*)sharedInstance
{
    static DeviceDelegateHelper *devicedelegatehelper;
    static dispatch_once_t devicedelegatehelperonce;
    dispatch_once(&devicedelegatehelperonce, ^{
        devicedelegatehelper = [[DeviceDelegateHelper alloc] init];
    });
    return devicedelegatehelper;
}

/**
 @brief 连接状态接口
 @discussion 监听与服务器的连接状态 V5.0版本接口
 @param state 连接的状态
 @param error 错误原因值
 */
-(void)onConnectState:(ECConnectState)state  failed:(ECError*)error
{
    switch (state) {
        case State_ConnectSuccess:
            //连接成功
            break;
        case State_Connecting:
            //连接中;
            break;
        case State_ConnectFailed:
            //与服务器断开连接
            break;
        default:
            break;
    }
}
/**
 @brief 接收即时消息代理函数
 @param message 接收的消息
 */
-(void)onReceiveMessage:(ECMessage*)message
{

NSLog:(@"收到%@的消息,属于%@会话", message.from, message.sessionId);
    switch(message.messageBody.messageBodyType){
        case MessageBodyType_Text:{
            ECTextMessageBody *msgBody = (ECTextMessageBody *)message.messageBody;
            NSLog(@"lazi%@,xiaoxi %@",message.from,msgBody.text);
            if (_onReceiveArray== nil) {
                _onReceiveArray= [NSMutableArray array];
            }
            [_onReceiveArray addObject:msgBody.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:_onReceiveArray];
            break;
        }
        case MessageBodyType_Voice:{
            ECVoiceMessageBody *msgBody = (ECVoiceMessageBody *)message.messageBody;
            NSLog(@"音频文件remote路径------%@",msgBody. remotePath);
            break;
        }
            
        case MessageBodyType_Video:{
            ECVideoMessageBody *msgBody = (ECVideoMessageBody *)message.messageBody;
            NSLog(@"视频文件remote路径------%@",msgBody. remotePath);
            break;
        }
            
        case MessageBodyType_Image:{
            ECImageMessageBody *msgBody = (ECImageMessageBody *)message.messageBody;
            NSLog(@"图片文件remote路径------%@",msgBody. remotePath);
            NSLog(@"缩略图片文件remote路径------%@",msgBody. thumbnailRemotePath);
           
                ECFileMessageBody *body = (ECFileMessageBody*)message.messageBody;
                body.displayName = body.remotePath.lastPathComponent;
            if (_imageArray== nil) {
                _imageArray= [NSMutableArray array];
            }
            [_imageArray addObject:body.remotePath];
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_DownloadMessageCompletion object:_imageArray];
            
            break;
        }
            
        case MessageBodyType_File:{
            ECFileMessageBody *body = (ECFileMessageBody*)message.messageBody;
            body.displayName = body.remotePath.lastPathComponent;
            
            [[DeviceChatHelper sharedInstance] downloadMediaMessage:message andCompletion:nil];           
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_DownloadFileCompletion object:_fileArray];
            break;
        }
        default:
            break;
    }
}
/**
 @brief 离线消息数
 @param count 消息数
 */
-(void)onOfflineMessageCount:(NSUInteger)count{
    NSLog(@"onOfflineMessageCount=%lu",(unsigned long)count);
    self.offlineCount = count;
    
}

/**
 @brief 需要获取的消息数
 @return 消息数 -1:全部获取 0:不获取
 */
-(NSInteger)onGetOfflineMessage{
    NSInteger retCount = -1;
    if (self.offlineCount!=0) {
        /*
         if (self.offlineCount>100) {
         retCount = 100;
         }
         */
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_haveHistoryMessage object:nil];
        });
    }
    return retCount;
}
/**
 @该通知回调接口在代理类里面
 @brief 接收离线消息代理函数
 @param message 接收的消息
 */
-(void)onReceiveOfflineMessage:(ECMessage*)message{
    if (message.from.length==0) {
        return;
    }
    
    if (message.messageBody.messageBodyType == MessageBodyType_Text) {
        ECTextMessageBody * textmsg = (ECTextMessageBody *)message.messageBody;
        NSLog(@"%@------%@",textmsg.text,textmsg.serverTime);
        if (_receiveArray == nil) {
            _receiveArray = [NSMutableArray array];
        }
        [_receiveArray addObject:textmsg.text];
        
    }
    
#warning 时间全部转换成本地时间
    if (!message.timestamp) {
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval tmp =[date timeIntervalSince1970]*1000;
        message.timestamp = [NSString stringWithFormat:@"%lld", (long long)tmp];
    }
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_onMesssageChanged object:message];

        
      
       
 }
    

@end
