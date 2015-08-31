//
//  DeviceDelegateHelper.h
//  QppFrame
//
//  Created by xuannalisha on 15/8/19.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#define KNOTIFICATION_onMesssageChanged    @"KNOTIFICATION_onMesssageChanged"
#define KNOTIFICATION_haveHistoryMessage @"KNOTIFICATION_haveHistoryMessage"
#define KNOTIFICATION_haveHistoryMessage @"KNOTIFICATION_haveHistoryMessage"
#define KNOTIFICATION_SendMessageCompletion       @"KNOTIFICATION_SendMessageCompletion"
#define KNOTIFICATION_DownloadMessageCompletion   @"KNOTIFICATION_DownloadMessageCompletion"

#import <Foundation/Foundation.h>
#import "ECDeviceHeaders.h"
@interface DeviceDelegateHelper : NSObject<ECDeviceDelegate>
@property(nonatomic,strong)NSMutableArray *receiveArray;
@property(nonatomic,strong)NSMutableArray *onReceiveArray;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *fileArray;
+(DeviceDelegateHelper *)sharedInstance;
@end
