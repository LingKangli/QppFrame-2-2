//
//  Utill.h
//  Example
//
//  Created by LingKangLi on 15/6/8.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#ifndef Example_Utill_h
#define Example_Utill_h


#pragma height//各种高度
#import "Height.h"

#pragma color //各种颜色
#import "Color.h"

#pragma font
#import "ZiTi.h"//适用的各个字体

#pragma width
#import "Width.h"

#pragma Number
#import "Number.h"

#pragma pic
#import "PictureOpr.h"

//image Type
#define BQPNG @".png"
#define BQGIF @".gif"
//#define BQPNG @".png"

typedef enum {
    DataTypeGifImg=0,
    DataTypeVoice,
    DataTypePngImg,
    DataTypeImg
}DataType;//键盘状态的显示


#endif
