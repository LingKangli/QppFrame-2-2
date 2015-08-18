//
//  FriendRoundController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "FriendRoundController.h"
#import "FriendStoryItem.h"


@interface FriendRoundController :BaseUIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray* imageNames;
    NSArray* namesText;
    NSArray* dataArray;
    NSArray* contentArray;
    NSMutableArray* contentImgArray;
    
    NSDictionary* contentImgDic;

    NSMutableArray* typeArray;
    NSMutableArray* storyArray;
    
}

@property (strong,nonatomic)UITableView* tableView;

@end
