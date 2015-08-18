//
//  DynamicScrollView.m
//  MeltaDemo
//
//  Created by hejiangshan on 14-8-27.
//  Copyright (c) 2014年 hejiangshan. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "DynamicScrollView.h"
#import "Utill.h"


@implementation DynamicScrollView

@synthesize scrollView,imageViews,isDeleting;


- (id)initWithFrame:(CGRect)frame withImages:(NSMutableArray *)imageArrays
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.imageViews = [NSMutableArray arrayWithCapacity:imageArrays.count];
        self.images = imageArrays;
       
//        singleWidth = UIScreenWidth/COUNT;
        singleWidth = self.frame.size.height;
        //创建底部滑动视图
        [self _initScrollView];
        [self _initViews];
    }
    return self;
}

- (void)_initScrollView
{
    if (scrollView == nil) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
    }
}

- (void)_initViews
{
    for (int i = 0; i < self.images.count; i++) {
        NSString *imageName = self.images[i];
        [self createImageViews:i withImageName:imageName];
    }
    self.scrollView.contentSize = CGSizeMake(self.images.count * singleWidth, self.scrollView.frame.size.height);
}

- (void)createImageViews:(int)i withImageName:(NSString *)imageName
{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imgView.frame = CGRectMake(singleWidth*i, 0, singleWidth, self.scrollView.frame.size.height);
    imgView.userInteractionEnabled = YES;
    [self.scrollView addSubview:imgView];
    [imageViews addObject:imgView];
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
//    [imgView addGestureRecognizer:longPress];
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
    [imgView addGestureRecognizer:tapGesture];
    
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setImage:[UIImage imageNamed:@"deletbutton.png"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    if (isDeleting) {
        [deleteButton setHidden:NO];
    } else {
        [deleteButton setHidden:YES];
    }
    deleteButton.frame = CGRectMake(0, 0, 25, 25);
    deleteButton.backgroundColor = [UIColor clearColor];
    imgView.tag = i;
    [imgView addSubview:deleteButton];
    
    
}
//单击方法
-(void)Actiondo:(UITapGestureRecognizer*)tapGesture{

    UIImageView* imageView = (UIImageView*)tapGesture.view;
     if (tapGesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"the gesture state is UIGestureRecognizerStateEnded.");
        [self.delegate clickDymamic:imageView];
        
    }
}

/*
//长按调用的方法
- (void)longAction:(UILongPressGestureRecognizer *)recognizer
{
    UIImageView *imageView = (UIImageView *)recognizer.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {//长按开始
        startPoint = [recognizer locationInView:recognizer.view];
        originPoint = imageView.center;
        isDeleting = !isDeleting;
        [UIView animateWithDuration:0.3 animations:^{//点击后的效果
            imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
        
        for (UIImageView *imageView in imageViews) {
            UIButton *deleteButton = (UIButton *)imageView.subviews[0];
            if (isDeleting) {
                deleteButton.hidden = NO;
            } else {
                deleteButton.hidden = YES;
            }
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {//长按移动
        CGPoint newPoint = [recognizer locationInView:recognizer.view];
        CGFloat deltaX = newPoint.x - startPoint.x;
        CGFloat deltaY = newPoint.y - startPoint.y;
        imageView.center = CGPointMake(imageView.center.x + deltaX, imageView.center.y + deltaY);
        NSInteger index = [self indexOfPoint:imageView.center withView:imageView];//获取当前被拖动图片到了第几个
        NSLog(@"the index is %d",index);
        if (index < 0) {//当前没有碰到任何图片
            isContain = NO;
        } else {//实现拖动图片与碰到的图片交换位置
            [UIView animateWithDuration:0.3 animations:^{
//              1.显示图片的中心坐标进行交换。
                CGPoint temp = CGPointZero;//暂存变量
                UIImageView *currentImagView = imageViews[index];//当前被拖动碰到的图片
                NSInteger idx = [imageViews indexOfObject:imageView];//碰到的图片是第几个。
                NSLog(@"the idx is %d",index);
                temp = currentImagView.center;//暂存碰到图片的中心
                currentImagView.center = originPoint;//碰到图片中心设置为拖动图片中心
                imageView.center = temp;//拖动图片中心设置为碰到图片中心
                
//              2.更换好坐标后标记
                originPoint = imageView.center;//由局部变量存给全局变量
                isContain = YES;//当前碰到图片了（中心点过了碰到图片的最靠近的边缘处）
                
//              3.将数组中的两个图片排序上进行交换。
                [imageViews exchangeObjectAtIndex:idx withObjectAtIndex:index];
                
            } completion:^(BOOL finished) {
            }];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {//长按结束
        [UIView animateWithDuration:0.3 animations:^{
            imageView.transform = CGAffineTransformIdentity;//效果还原
            if (!isContain) {
                imageView.center = originPoint;
            }
        }];
    }
}
*/
//获取view在imageViews中的位置
- (NSInteger)indexOfPoint:(CGPoint)point withView:(UIView *)view
{
    UIImageView *originImageView = (UIImageView *)view;
    for (int i = 0; i < imageViews.count; i++) {
        UIImageView *otherImageView = imageViews[i];
        if (otherImageView != originImageView) {
            if (CGRectContainsPoint(otherImageView.frame, point)) {
                return i;
            }
        }
    }
    return -1;
}

- (void)deleteAction:(UIButton *)button
{
    isDeleting = YES;   //正处于删除状态
    UIImageView *imageView = (UIImageView *)button.superview;
    __block int index = [imageViews indexOfObject:imageView];
    __block CGRect rect = imageView.frame;
    __weak UIScrollView *weakScroll = scrollView;
    [UIView animateWithDuration:0.3 animations:^{
        imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            for (int i = index + 1; i < imageViews.count; i++) {
                UIImageView *otherImageView = imageViews[i];
                CGRect originRect = otherImageView.frame;
                otherImageView.frame = rect;
                rect = originRect;
            }
        } completion:^(BOOL finished) {
            [imageViews removeObject:imageView];
            if (imageViews.count > 4) {
                weakScroll.contentSize = CGSizeMake(singleWidth*imageViews.count, scrollView.frame.size.height);
            }
        }];
    }];
}

//添加一个新图片
- (void)addImageView:(NSString *)imageName
{
    [self createImageViews:imageViews.count withImageName:imageName];
    
    self.scrollView.contentSize = CGSizeMake(singleWidth*imageViews.count, self.scrollView.frame.size.height);
    if (imageViews.count > COUNT) {
        [self.scrollView setContentOffset:CGPointMake((imageViews.count-COUNT)*singleWidth, 0) animated:YES];
    }
}

@end
