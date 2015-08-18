//
//  Height.h
//  Example
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#ifndef Example_Height_h
#define Example_Height_h

//应用高度
#define UIScreenWidth [[UIScreen mainScreen]bounds].size.width
#define UIScreenHeight [[UIScreen mainScreen]bounds].size.height

//tabbar
#define tabBarY UIScreenHeight*0.93

#define tabBarHeight 150

//应用标题高度
//#define TitleBGHeight 70
#define titleY 15
#define titleHeight 60

#pragma Qpp   =============================

//Ｑpp页面
#define searchHeight 40
#define contentHeight UIScreenHeight-titleY-titleHeight-searchHeight

//keyBorad高度
#define keyBoradViewNormalHeight 60
#define keyBoradViewTextSelectedHeight 310
#define keyBoradViewSelectedHeight 250

//keyBorad   frame 高度
#define KeyBoradNormalFrame CGRectMake(0, UIScreenHeight-keyBoradViewNormalHeight, UIScreenWidth, keyBoradViewNormalHeight)
#define KeyBoradSelectedFrame CGRectMake(0, UIScreenHeight-keyBoradViewSelectedHeight, UIScreenWidth, keyBoradViewSelectedHeight)
#define KeyBoradTextSelectedFrame CGRectMake(0, UIScreenHeight-keyBoradViewTextSelectedHeight, UIScreenWidth, keyBoradViewTextSelectedHeight)
//keyBorad imgHeight
#define keyImgHeight 0


#define contentViewNormalFrame  CGRectMake(0, titleY+titleHeight, UIScreenWidth, UIScreenHeight-titleHeight-keyBoradViewNormalHeight-titleY)
#define contentViewTextSelectFrame  CGRectMake(0, titleY+titleHeight, UIScreenWidth, UIScreenHeight-titleHeight-keyBoradViewTextSelectedHeight-titleY)
#define contentViewSelectFrame  CGRectMake(0, titleY+titleHeight, UIScreenWidth, UIScreenHeight-titleHeight-keyBoradViewSelectedHeight-titleY)


#pragma find  ============================

//find page
#define contentTheHeight contentHeight+searchHeight-5

//sendInfo page
#define sendInfoY UIScreenHeight*0.12
#define sendInfoHeight UIScreenHeight*0.5

//-(CGSize) getTLabStringSize:(NSString*) text;

//BiaoQing view
#define contentionCellSize   CGSizeMake(68, 68)
#define contentionCellEdgeSize   CGSizeMake(5, 5)

#endif
