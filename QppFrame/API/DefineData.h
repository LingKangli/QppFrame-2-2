//
//  DefineData.h
//  QppFrame
//
//  Created by Ling Kangli on 15/7/16.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefineData.h"

@interface DefineData : NSObject
+ (DefineData *)sharedManager;

+(NSArray*)getEmojyArray;

@end
