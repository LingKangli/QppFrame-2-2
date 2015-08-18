//
//  AddressBookViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "popView.h"

@interface AddressBookViewController : BaseUIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    NSArray* headerTitles;
    NSArray* contentTitles;
    BOOL isAdd;
    PopView* popView;
    
}

@property (strong,nonatomic)UITableView* tableView;

@end
