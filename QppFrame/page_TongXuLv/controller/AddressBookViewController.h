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
#import "AsFrindInfo.h"

//@protocol sendValueDelegate <NSObject>
//
//-(void)sendMessage:(AsFrindInfo*)message;
//
//@end

@interface AddressBookViewController : BaseUIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray* headerTitles;
    NSMutableArray* contentTitles;
    BOOL isAdd;
    PopView* popView;
    
}

@property (strong,nonatomic)UITableView* tableView;
//@property (strong,nonatomic)id<sendValueDelegate> delegate;
@end
