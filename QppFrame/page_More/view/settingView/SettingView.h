//
//  SettingView.h
//  Example
//
//  Created by LingKangLi on 15/6/13.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingView : UIView<UITableViewDelegate,UITableViewDataSource>{

    NSArray* findContent;
}

@property (strong,nonatomic)UITableView* tableView;

@end
