//
//  DefineData.m
//  QppFrame
//
//  Created by Ling Kangli on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "DefineData.h"

@implementation DefineData

static DefineData *shareData = nil;
+ (DefineData *)sharedManager{
    @synchronized (self){//为了确保多线程情况下，仍然确保实体的唯一性
        if (!shareData) {
            shareData = [[self alloc] init];//非ARC模式下,该方法会调用 allocWithZone
        }
        return shareData;
    }
}


@end
