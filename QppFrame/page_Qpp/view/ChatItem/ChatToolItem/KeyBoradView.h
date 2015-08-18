//
//  KeyBoradView.h
//  KeyBorad
//
//  Created by LingKangLi on 15/7/4.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoveButton.h"
#import "KeyBoradContentView.h"



typedef enum {
    button_state_none=0,
    button_state_Emoji,
    button_state_Pic,
    button_state_voice
}ButtonState;//键盘状态的显示

@protocol keyBoradDelegate <NSObject>
-(void)keyBoradState:(ButtonState)state;

@end


@interface KeyBoradView : UIView<UITextViewDelegate,UITextFieldDelegate,testDelegate,KeyBoradContentDelegate>{

    UIView* keyBorad;
  
    
    ButtonState keyBoradState;
    
    CGRect keyboradNorFrame;
    CGRect keyboradSelected;
    
    UIImage* selectedImg;
}
@property(strong,nonatomic)  KeyBoradContentView* contentView;
@property (strong,nonatomic)  UITextField* sendMessageField;
@property (weak,nonatomic) id<keyBoradDelegate> delegate;
@property(weak,nonatomic)id<KeyBoradContentDelegate>keyBoradContentDelegate;
@property(strong,nonatomic) MoveButton* voiceBtn;
@property(strong,nonatomic) MoveButton* faceBtn;
@property(strong,nonatomic) MoveButton* picBtn;

-(void)initKeyBoradView : (CGRect) frame;
-(void)changeImg:(ButtonState)keyBoradState;
-(ButtonState)getKeyBoradState;

@end
