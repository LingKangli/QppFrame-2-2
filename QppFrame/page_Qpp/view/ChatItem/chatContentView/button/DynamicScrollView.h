//
//  DynamicScrollView.h
//  MeltaDemo
//
//  Created by hejiangshan on 14-8-27.
//  Copyright (c) 2014年 hejiangshan. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
//#import "Command.h"

@protocol DynamicScrollViewCilckDelegate <NSObject>

-(void)clickDymamic:(id)sender;

@end


@interface DynamicScrollView : UIView{

    CGPoint startPoint;
    CGPoint originPoint;
    
    float singleWidth;//单个显示图片的宽度
    BOOL isContain;
    BOOL isDeleting;//是否删除
    
}

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)NSMutableArray *images;
@property(nonatomic,retain)NSMutableArray *imageViews;
@property(nonatomic,assign)BOOL isDeleting;
@property(strong,nonatomic)id<DynamicScrollViewCilckDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withImages:(NSMutableArray *)images;
//添加一个新图片
- (void)addImageView:(NSString *)imageName;



@end
