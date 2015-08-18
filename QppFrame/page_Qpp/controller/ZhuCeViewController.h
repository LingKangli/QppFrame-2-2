//
//  ZhuCeViewController.h
//  QppFrame
//
//  Created by LingKangLi on 15/7/11.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuCeViewController : UIViewController<UITextFieldDelegate>{

    UIView* contentView;

    UITextField* userName;
    UITextField* pwdName;
    UITextField* pwdAgainName;
    
//    注册结果弹出框
    NSString* alterTitle;
    NSString* alterContentText ;
    NSString* alterleftButtonTitile ;
    NSString* alterRightButtonTitle ;
    
   }

@end
