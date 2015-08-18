//
//  TitleView.h
//  QppFrame
//
//  Created by LingKangLi on 15/6/24.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleViewDelegate <NSObject>
- (void)leftBtn:(id)sender;
- (void)rightBtn:(id)sender;
@end

@interface TitleView : UIView

@property(nonatomic,strong) UIButton* leftBtn;
@property(nonatomic,strong) UILabel* titleLab;
@property(nonatomic,strong) UIButton* rightBtn;
@property(nonatomic,strong) UIButton* returnBtn;


@end
