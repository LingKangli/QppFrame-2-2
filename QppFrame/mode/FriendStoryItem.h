//
//  FriendStoryItem.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/27.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    characterInfo=0,
    characterImgInfo=1,
}ShowType;

@interface FriendStoryItem : NSObject

@property (strong,nonatomic)NSString* name; //名字
@property (strong,nonatomic)NSString* nameImg;
@property (strong,nonatomic)NSString* story; //分享文字内容
@property (strong,nonatomic)NSArray* imgName;//分享图片内容
@property (strong,nonatomic)NSString* dataSend;//分享日期
//@property ShowType type;
@property (strong,nonatomic)NSString* type;//分享日期

@property (strong,nonatomic)NSString* contentImg;

@end
