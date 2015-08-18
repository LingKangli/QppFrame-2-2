//
//  KLAlterPicker.h
//  QppFrame
//
//  Created by 孙兴国 on 15/8/15.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLAlterPicker;
typedef enum {//根据不同需求，使自己显示在屏幕的位置
    directionTypeLeft=0,
    directionTypeRight=1,
    directionTypeTop=2,
    directionTypeBottom=3,
    directionTypeMid=4,
}DirectionType;

typedef enum {//根据不同需求，使自己显示在屏幕的位置
    AlterStlyDefult=0,
    AlterStlyCool = 1
}AlterStly;


@protocol KLAlertPickerDelegate <NSObject>
-(void)clickTheBtn:(UIButton*)btn;//每个按钮被点击后调用的方法
@end

@interface KLAlterPicker : UIView

@property(nonatomic,strong)id<KLAlertPickerDelegate>delegate;

-(instancetype)initWithDirection:(DirectionType)dirType WithButtonNum:(NSInteger)num WithStly:(AlterStly)alertStyle;


@end
