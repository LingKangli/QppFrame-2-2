//
//  FriendsInfoesView.h
//  Example
//
//  Created by LingKangLi on 15/6/11.
//  Copyright (c) 2015年 Goles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsInfoesView : UIView<UITableViewDataSource,UITableViewDelegate>{

    NSArray* imageNames;
    NSArray* namesText;
    NSArray* dataArray;
    NSArray* contentArray;

}

@property (strong,nonatomic)UITableView* tableView;

@end
