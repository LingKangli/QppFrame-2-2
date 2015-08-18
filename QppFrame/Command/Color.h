//
//  Color.h
//  Example
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#ifndef Example_Color_h
#define Example_Color_h

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//#define BackColor [UIColor colorWithRed:0.68 green:0.27 blue:0.27 alpha:1.0]
//#define BackColor [UIColor colorWithRed:0.8 green:0.2 blue:0.1 alpha:1.0]
#define BackColor COLOR(238, 61, 53, 1)

#endif
