//
//  KeyBoradView.m
//  KeyBorad
//
//  Created by LingKangLi on 15/7/4.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import "KeyBoradView.h"
#import "Utill.h"
//#define ViewHeight 100
#define iconBtnHeight 50
#define iconBtnWidth 50

@implementation KeyBoradView
@synthesize sendMessageField;
@synthesize keyBoradContentDelegate;
@synthesize voiceBtn;
@synthesize faceBtn;
@synthesize picBtn;
@synthesize contentView;
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
       

        return self;
    }
    return nil;
}

-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    self = [super initWithFrame:frame];
//    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        [self initKeyBoradView:frame];
       
        return self;
    }
    return nil;
}

//添加键盘上的元素(初始化)
-(void)initKeyBoradView : (CGRect) frame{

    self.backgroundColor = [UIColor clearColor];

    
    keyBorad = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    keyBorad.backgroundColor = [UIColor blackColor];
    [self addSubview:keyBorad];
//    录音按钮
    voiceBtn = [[MoveButton alloc]initWithFrame:CGRectMake(5, keyImgHeight, iconBtnWidth, iconBtnHeight) setStateImg:@"voice@2x.png"];
    [voiceBtn setImageForStateSelected:@"chat_bottom_keyboard_nor.png"];
    voiceBtn.tag = button_state_voice;
    voiceBtn.isSelected = NO;
    [voiceBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [keyBorad addSubview:voiceBtn];
    
//    表情按钮
//    faceBtn = [[MoveButton alloc]initWithFrame:CGRectMake(280, keyImgHeight, 50, 50) setStateImg:@"face@2x.png" setStateHighImg:@"keyborad@2x.png"];
    faceBtn = [[MoveButton alloc]initWithFrame:CGRectMake(UIScreenWidth-iconBtnWidth*2-5, keyImgHeight, iconBtnWidth, iconBtnHeight) setStateImg:@"face@2x.png" setStateHighImg:@"chat_bottom_smile_press.png"];
    [faceBtn setImageForStateSelected:@"chat_bottom_keyboard_nor.png"];
//    [faceBtn setImageForStateHighted:@"chat_bottom_smile_press.png"];
    faceBtn.tag = button_state_Emoji;
    faceBtn.delegate = self;
    faceBtn.isSelected = NO;
    [faceBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [keyBorad addSubview:faceBtn];
    
//    添加图片按钮
    picBtn = [[MoveButton alloc]initWithFrame:CGRectMake(UIScreenWidth-iconBtnWidth-5, keyImgHeight, iconBtnWidth, iconBtnHeight) setStateImg:@"chat_bottom_up_nor.png"];
    [picBtn setImageForStateSelected:@"chat_bottom_keyboard_press.png"];
    picBtn.tag = button_state_Pic;
    picBtn.isSelected = NO;
    [picBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [keyBorad addSubview:picBtn];
    
//    输入文字模块
    sendMessageField = [[UITextField alloc]initWithFrame:CGRectMake(voiceBtn.frame.origin.x+voiceBtn.frame.size.width, 5,UIScreenWidth-(voiceBtn.frame.origin.x+voiceBtn.frame.size.width)-faceBtn.frame.size.width-picBtn.frame.size.width, 40)];
    sendMessageField.backgroundColor = [UIColor whiteColor];
    sendMessageField.layer.borderColor = [UIColor grayColor].CGColor;
    sendMessageField.layer.borderWidth = 1;
    sendMessageField.layer.cornerRadius = 10;
    sendMessageField.font = [UIFont systemFontOfSize:18];
    sendMessageField.returnKeyType = UIReturnKeySend;
    sendMessageField.delegate =self;
    [keyBorad addSubview:sendMessageField];

    contentView = [[KeyBoradContentView alloc]initWithFrame:CGRectMake(0, 60, UIScreenWidth,keyBoradViewSelectedHeight-60)];
//    contentView.delegate = self;
    [self addSubview:contentView];
//    键盘状态（共四种）
    keyBoradState = button_state_none;
    
//    selectedImg = [[UIImage alloc]init];
    

    
}

//点击键盘上的按钮事件（控制键盘状态）
-(void)click:(id)sender {

    /*
    //    如果当前状态 等于 按钮tag 并且 按钮的isChange为1  ｛当前状态改为：button_state_none｝
    //    如果当前状态 等于 button_state_none   ｛当前状态为按钮状态｝
    //    如果当前状态 等于 按钮状态 并且 按钮的isChange为0 ｛当前状态改为：按钮状态｝
    if(keyBoradState == button_state_none){
        
        keyBoradState = (ButtonState)((MoveButton*)sender).tag ;
    }else if (keyBoradState == (ButtonState)((MoveButton*)sender).tag && ((MoveButton*)sender).isChange==1) {
        
        keyBoradState = (ButtonState)((MoveButton*)sender).tag ;
    }else if (keyBoradState == (ButtonState)((MoveButton*)sender).tag && ((MoveButton*)sender).isChange==0) {
        
        keyBoradState = button_state_none;
    }
    */
//    ((MoveButton*)sender).isSelected  = YES;
    keyBoradState = (ButtonState)((MoveButton*)sender).tag;

    if (((MoveButton*)sender).isSelected ) {
        [self changeImg:keyBoradState];
        NSLog(@"button is change.");
    }
    
    if (keyBoradState == button_state_none) {
        [self.delegate keyBoradState:button_state_none];
    }
//    [self.delegate keyBoradState:keyBoradState];
   
    /*
    NSLog(@"进入keyborad 点击事件。");
    keyBoradState = (ButtonState)((UIButton*)sender).tag;
    if (beforeKeyBoradState != button_state_none &&  (ButtonState)((UIButton*)sender).tag == beforeKeyBoradState) {
        beforeKeyBoradState = keyBoradState;
        NSLog(@" 两次连续点击同一个按钮。");
        return;
    }else{
        [self changeImg:keyBoradState];
        NSLog(@" 状态一样");

    }*/
}

//将状态呈现
-(void)changeImg:(ButtonState)keyBoradStates{

    if (keyBoradStates == button_state_none) {
        [sendMessageField resignFirstResponder];
        [voiceBtn setNormalImage];
        [faceBtn setNormalImage];
        [picBtn setNormalImage];
//        voiceBtn.isSelected = NO;
//        faceBtn.isSelected = NO;
//        picBtn.isSelected = NO;
        self.frame = KeyBoradNormalFrame;
//        [self.delegate keyBoradState:button_state_none];
        
//        [self.delegate keyBoradState:keyBoradStates];
    }else if(keyBoradStates == button_state_voice ){
        
        [voiceBtn setSelectedImage]; //改变声音按钮状态
        [faceBtn reNewBtn];//恢复表情按钮状态
        [picBtn reNewBtn];//恢复表情按钮状态
//        
//        voiceBtn.isSelected = YES;
//        faceBtn.isSelected = NO;
//        picBtn.isSelected = NO;
//        
        self.frame = KeyBoradSelectedFrame;//当前keyBorad高度
        
        [sendMessageField resignFirstResponder];//键盘消失
        [contentView changeToState:KeyBoradContentState_voice];//键盘里的内容是否显示
//        [self.delegate keyBoradState:keyBoradStates];
        
    }else if(keyBoradStates == button_state_Emoji){
        
        [voiceBtn reNewBtn];
        [faceBtn setSelectedImage];
        [picBtn reNewBtn];
        
//        voiceBtn.isSelected = NO;
//        faceBtn.isSelected = YES;
//        picBtn.isSelected = NO;
        
        self.frame = KeyBoradSelectedFrame;
        
        [sendMessageField resignFirstResponder];
        [contentView changeToState:KeyBoradContentState_Emoji];
        
        //test send
//        [self.delegate keyBoradState:keyBoradStates];
    }else if(keyBoradStates == button_state_Pic){
        
        [voiceBtn reNewBtn];
        [faceBtn reNewBtn];
        [picBtn setSelectedImage];
        
//        voiceBtn.isSelected = NO;
//        faceBtn.isSelected = NO;
//        picBtn.isSelected = YES;
        
        self.frame = KeyBoradSelectedFrame;
        
        [sendMessageField resignFirstResponder];
        [contentView changeToState:KeyBoradContentState_Pic];
//        [self.delegate keyBoradState:keyBoradStates];
    }
    [self.delegate keyBoradState:keyBoradStates];
}


//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    NSLog(@"test");
//    return YES;
//}

#pragma keyBorad sendMessageField Set

//键盘中输入文字时调用的方法 （变高）
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"lingkangli.....");
//    keyBorad.frame= KeyBoradSelectedFrame;
   
//    [self.delegate keyBoradState:keyBoradState];
    
    return YES;
}
//键盘还原 （变低）
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.sendMessageField resignFirstResponder];
    
    NSLog(@"键盘消失。。。");
//    keyBorad.frame = KeyBoradNormalFrame;
    
    [self changeImg:button_state_none];
    
//    [self.delegate keyBoradState:button_state_none];
    //    [keyBorad.sendMessageField resignFirstResponder];
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    NSLog(@"send something.");
//    return YES;
//}
-(ButtonState)getKeyBoradState{
    return keyBoradState;
}

//-(void)keyBoradPic:(UIImage *)img{
//
//    selectedImg = img;
////    [self.delegate getImgInfo:img];
//}

@end
