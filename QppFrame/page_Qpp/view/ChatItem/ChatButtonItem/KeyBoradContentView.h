//
//  KeyBoradContentView.h
//  KeyBorad
//
//  Created by LingKangLi on 15/7/7.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceObj.h"
#import "DynamicScrollView.h"
#import "UtilBiaoQingData.h"
#import "ScrollItemView.h"
#import "KLAlterPicker.h"



typedef enum {
    KeyBoradContentState_none=0,
    KeyBoradContentState_Emoji,
    KeyBoradContentState_Pic,
    KeyBoradContentState_voice
}KeyBoradContentState;//键盘状态的显示

typedef enum {
    PhotoByPhoto = 0,
    PhotoByPVoice= 1,
    PhotoByManyPVoice
}PhotoType;

@protocol KeyBoradContentDelegate <NSObject>
-(void)keyBoradPicForData:(NSData*)data ForType:(DataType)dataType;
-(void)keyBoradPicWithImg:(UIImage*)image andVoicePath:(NSURL*)filePath2;
-(void)keyBoradPic:(NSString*)filePath;
//- (void)addMessageWithImg:(NSString *)content andVoice:(NSURL*)voicePath time:(NSString *)time{
-(void)keyBoradPic:(NSString *)filePath andVoicePath:(NSURL*) voicePath;
@end

@interface KeyBoradContentView : UIView<UIImagePickerControllerDelegate,UINavigationBarDelegate,VoiceDelegate,DynamicScrollViewCilckDelegate,UIScrollViewDelegate,KeyBoradContentDelegate,KLAlertPickerDelegate>{

    CGRect showViewFrame;//
    
    UIView* frameView;//表情显示的画面框架
    NSArray* imgNames;
    
    BOOL isCreateVoice;
    BOOL isCreateEmj;
    BOOL isCreatePic;
    
    BOOL isVoicePicker;
    BOOL isManyVoicePicker;
    
    PhotoType photoUseType;
//    UIImageView* testImg;
    
    
//    biaoQIng begin
    UIPageControl* pageC ;
    
    NSMutableArray* biaoQingArray; //表情系列索引数组
    DynamicScrollView* dynamicScrollView;//显示点击表情系列索按钮视图
    
    UIScrollView* scrollView ; //显示表情系列下的所有表情视图
    NSMutableArray* scrollViewArray;//存储Ｎ组表情视图
    
    //图片2进制路径
    NSString* filePath;
    //    set btn scrollView
//    float width;//屏幕的宽
//    float height;//屏幕的高

    
//    biaoQing end
    
}

@property(nonatomic)KeyBoradContentState keyBoradState;
@property(nonatomic,strong) id<KeyBoradContentDelegate> delegate;


-(void)clearKLAlterPickerFromWindow;
-(void)changeToState:(KeyBoradContentState)keyBoradState;
-(void)saveGifToDocumentForData:(NSData *)data ;
@end
