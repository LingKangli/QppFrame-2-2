//
//  BiaoQingView.h
//  Example
//
//  Created by LingKangLi on 15/6/12.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BiaoQingView : UIView<UITableViewDelegate,UITableViewDataSource>{

    NSArray* perImgNameArray;//头像图片数组
    NSArray* nameLabArray;//名字数组
    NSArray* contentLabArray;//聊天信息数组
    NSArray* isDownImgNameArray;//下载按钮图片数组
}

@property (strong,nonatomic)UITableView* tableView;

@end
