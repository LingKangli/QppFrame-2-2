//
//  SendMessageView.h
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

enum SendFrameType{
    voiceType = 0,
    writeType
};


@interface SendMessageView : UIView<UITextFieldDelegate,UITextViewDelegate>{

//    enum SendFrameType sendType;
   
}

//输入语音
@property (nonatomic,strong) UIButton* voiceBtn;
@property (nonatomic,strong) UIButton* voiceSaidBtn;
//输入信息
@property (nonatomic,strong)UIButton* writeBtn;
@property (nonatomic,strong)UITextView* sendMessageField;

//表情及图片
@property (nonatomic,strong)UIButton* expressionBtn;
@property (nonatomic,strong)UIButton* picBtn;

@property BOOL isShowKey;
//+(void) drawTheView :(enum SendMessageView) theType;

@end
