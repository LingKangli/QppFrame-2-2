//
//  SendMessageView.m
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import "SendMessageView.h"
#import "Utill.h"

@implementation SendMessageView

//输入语音
@synthesize voiceBtn;
@synthesize voiceSaidBtn;
//输入信息
@synthesize writeBtn;
@synthesize sendMessageField;
//表情及图片
@synthesize expressionBtn;
@synthesize picBtn;

@synthesize isShowKey;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/*
 enum SendFrameType sendType;
 //输入语音
 UIButton* voiceBtn;
 UIButton* voiceSaidBtn;
 //输入信息
 UIButton* writeBtn;
 UITextField* sendMessageField;
 //表情及图片
 UIButton* expressionBtn;
 UIButton* picBtn;
 */
-(void)viewDidLoad{

    
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.8)];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
        
        voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 3, 50, 50)];
        [voiceBtn setImage:[UIImage imageNamed:@"voice@2x.png"] forState:UIControlStateNormal];
        [voiceBtn setImage:[UIImage imageNamed:@"keyborad.png"] forState:UIControlStateHighlighted];
        [voiceBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:voiceBtn];
        
        
        sendMessageField = [[UITextView alloc]initWithFrame:CGRectMake(voiceBtn.frame.origin.x+voiceBtn.frame.size.width, 5, UIScreenWidth*0.6, 40)];
        sendMessageField.delegate = self;
        sendMessageField.backgroundColor = [UIColor whiteColor];
        sendMessageField.layer.borderColor = [UIColor grayColor].CGColor;
        sendMessageField.layer.borderWidth = 1;
        sendMessageField.layer.cornerRadius = 10;
        sendMessageField.font = [UIFont systemFontOfSize:18];
        sendMessageField.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [self addSubview:sendMessageField];
        
        
        expressionBtn = [[UIButton alloc]initWithFrame:CGRectMake(sendMessageField.frame.size.width+sendMessageField.frame.origin.x, 3, 50, 50)];
        [expressionBtn setImage:[UIImage imageNamed:@"face.png"] forState:UIControlStateNormal];
        [expressionBtn addTarget:self action:@selector(textFieldBeWriten:) forControlEvents:UIControlEventTouchUpInside];
        expressionBtn.tag = 10;

        [self addSubview:expressionBtn];
        
        picBtn = [[UIButton alloc]initWithFrame:CGRectMake(expressionBtn.frame.size.width+expressionBtn.frame.origin.x-15, 3, 50, 50)];
        [picBtn setImage:[UIImage imageNamed:@"multiMedia@2x.png"] forState:UIControlStateNormal];
        [picBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:picBtn];
        
        return self;
    }
    return nil;
}

-(void)textFieldBeWriten:(id)sender{
    expressionBtn.tag = 20;
    
    [expressionBtn setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor.png"] forState:UIControlStateNormal];
    isShowKey = YES;
    [sendMessageField becomeFirstResponder];
//    NSLog(@"键盘存在。%i",expressionBtn.tag);
}

-(void)click{
    if (isShowKey ) {
        NSLog(@"键盘是消失状态 %i",isShowKey);
    }else{
        NSLog(@"键盘是存在状态 %i",isShowKey);
    }
    NSLog(@"aaaa1");
}

//判断键盘是否消失


/*
- (void)textViewDidEndEditing:(UITextView *)textView{

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

}

- (void)textViewDidChangeSelection:(UITextView *)textView{

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){

}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){

}
*/


//
//#pragma textFiled
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView:(UITextField *)textField{
////    sendView.frame= CGRectMake(0, UIScreenHeight*0.48, UIScreenWidth, UIScreenHeight*0.7);
//    NSLog(@"sholdBeginEditing....");
//    return YES;
//}        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing....");
    
}         // became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing....");
    return YES;
    
}          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing....");
    
    
}             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
/*
//键盘关闭
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    sendView.frame = CGRectMake(0, cRV.frame.size.height+cRV.frame.origin.y, UIScreenWidth, UIScreenHeight*0.3);
    isShowKey = NO;
    
    //当textField不再是第一监听者时键盘关闭
    
//    [self.sendMessageField resignFirstResponder];
    NSLog(@"键盘消失。。。");

}
*/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"eeeeee");
    return YES;
}   // return NO to not change text


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"textFieldShouldClear");
    return YES;
}               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn");
//    sendView.frame = CGRectMake(0, cRV.frame.size.height+cRV.frame.origin.y, UIScreenWidth, UIScreenHeight*0.3);
//    [self.sendMessageField resignFirstResponder];
//    isShowKey = NO;
    return YES;
}              // called when 'return' key pressed. return NO to ignore.

//#pragma textField end




//+(void) drawTheView :(SendMessageView*) theType{
//    
//    UIButton* voiceAndWriteChangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
//    [voiceAndWriteChangeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    [self addSubview:voiceAndWriteChangeBtn];
//    
//}




@end
