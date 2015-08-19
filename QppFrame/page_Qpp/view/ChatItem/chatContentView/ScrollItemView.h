//
//  ScrollItemView.h
//  TestScrollViewIndex
//
//  Created by Ling Kangli on 15/8/5.
//  Copyright (c) 2015年 fengDu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicScrollView.h"
#import "UtilBiaoQingData.h"
#import "VoiceObj.h"
#import "ImgObj.h"
#import "GifImageButton.h"

typedef enum  {
    biaoQingItemVoiceImg = 0,
    biaoQingItemImg = 1,
}BiaoQingItemType;


@protocol ScrollItemViewDelegate <NSObject>

-(void)sucessRecorder:(NSURL *)filePath andPicPath:(NSString *)imgPath;
-(void)sucessPicPath:(NSString *)imgPath;

@end


@interface ScrollItemView : UIControl<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,VoiceDelegate,UICollectionViewDelegateFlowLayout,ImgDelegate>{
    
    
//    NSArray* pageChildreNum;
    NSMutableArray* biaoQingArray;
    BiaoQingItemType bQItemType;
}

@property (strong,nonatomic)UICollectionView* collectionView;
@property (assign,nonatomic)NSUInteger sumCount;
@property (strong,nonatomic) id <VoiceDelegate> delegate;
@property (strong,nonatomic) id <ImgDelegate> imgDelegate;
@property(strong,nonatomic) id<ScrollItemViewDelegate>myDelegate;
@property (strong,nonatomic)    UIPageControl* pageC ;

-(instancetype)initWithFrame:(CGRect)frame WithHCount:(NSInteger) hCount WithVCount:(NSInteger) vCount WithTypeName:(NSInteger*)biaoQingTypeIndex;

-(instancetype)initWithFrame:(CGRect)frame WithTypesIndex:(NSInteger)biaoQingTypeIndex;

-(void)setbQItemType:(BiaoQingItemType)bQItemType;
-(BiaoQingItemType)getbQItemType;


@end
