//
//  KeyBoradBQContentFrame.h
//  QppFrame
//
//  Created by Ling Kangli on 15/8/12.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicScrollView.h"

@interface KeyBoradBQContentFrame : NSObject{

    UIPageControl* pageC ;
    
    NSMutableArray* biaoQingArray; //表情系列索引数组
    DynamicScrollView* dynamicScrollView;//显示点击表情系列索按钮视图
    
    UIScrollView* scrollView ; //显示表情系列下的所有表情视图
    NSMutableArray* scrollViewArray;//存储Ｎ组表情视图
    
}

@end
