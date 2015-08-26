//
//  DeviceDelegateHelper.h
//  QppFrame
//
//  Created by xuannalisha on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#define KNOTIFICATION_onMesssageChanged    @"KNOTIFICATION_onMesssageChanged"
#define KNOTIFICATION_haveHistoryMessage @"KNOTIFICATION_haveHistoryMessage"

#import <Foundation/Foundation.h>
#import "ECDeviceHeaders.h"
@interface DeviceDelegateHelper : NSObject<ECDeviceDelegate>
@property(nonatomic,strong)NSMutableArray *receiveArray;
@property(nonatomic,strong)NSMutableArray *onReceiveArray;
+(DeviceDelegateHelper *)sharedInstance;
@end
