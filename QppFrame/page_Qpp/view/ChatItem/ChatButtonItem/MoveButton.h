//
//  LifeButton.h
//  KeyBorad
//
//  Created by LingKangLi on 15/7/3.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol testDelegate <NSObject>

-(void)moveButtonState:(NSString*)state;

@end


@interface MoveButton : UIControl{

    NSString* stateNormalImg;
    NSString* stateSeletedImg;
    NSString* stateHightImg;
}

@property (strong,nonatomic)UIButton* forDisplayButton;
@property(nonatomic)BOOL isSelected;//按钮状态的确定

@property (nonatomic,strong)id<testDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame setStateImg:(NSString*)imgName;//设置按钮的大小
- (instancetype)initWithFrame:(CGRect)frame setStateImg:(NSString*)imgName setStateHighImg:(NSString*)imgHighName;//设置按钮的大小

//faceBtn = [[MoveButton alloc]initWithFrame:CGRectMake(280, keyImgHeight, 50, 50) setStateImg:@"face@2x.png" setStateHighImg:@"keyborad@2x.png"];



-(void)setImageForStateNormal:(NSString*)imageNormal;//设置正常状态下按钮图片
-(void)setImageForStateSelected:(NSString *)imageSelected;//设置选中后按钮图片
-(void)setImageForStateHighted:(NSString *)imageHighted;//设置选中后按钮图片

-(void)setNormalImage;
-(void)setSelectedImage;

-(void)reNewBtn; //外界调用此方法，可以还原按钮状态。

@end
