//
//  BiaoQingController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"

@interface BiaoQingController :BaseUIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray* perImgNameArray;//头像图片数组
    NSArray* nameLabArray;//名字数组
    NSArray* contentLabArray;//聊天信息数组
    NSArray* isDownImgNameArray;//下载按钮图片数组
}

@property (strong,nonatomic)UITableView* tableView;

@end
