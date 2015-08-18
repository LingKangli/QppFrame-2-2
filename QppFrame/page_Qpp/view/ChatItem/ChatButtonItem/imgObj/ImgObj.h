//
//  ImgObj.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/14.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GifImageButton.h"
#import "UtilBiaoQingData.h"
#import "Utill.h"

#define UIScreenWidth [[UIScreen mainScreen]bounds].size.width
#define UIScreenHeight [[UIScreen mainScreen]bounds].size.height


#define voiceFrame CGRectMake(UIScreenWidth/2-40,UIScreenHeight/2-40,80,80)

@protocol ImgDelegate

-(void)sucessForPicPath:(NSString*) imgPath;

@end

@interface ImgObj :UIControl{
    NSURL* fileUrl;
}

@property(strong,nonatomic) GifImageButton* recorderBtn;
@property(nonatomic,retain) id<ImgDelegate>delegate;

@property (nonatomic,strong) NSString* imgNormalName;
@property (nonatomic,strong) NSString* imgSelectedName;



@end
