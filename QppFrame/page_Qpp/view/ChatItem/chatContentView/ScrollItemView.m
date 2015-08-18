//
//  ScrollItemView.m
//  TestScrollViewIndex
//
//  Created by Ling Kangli on 15/8/5.
//  Copyright (c) 2015年 fengDu. All rights reserved.
//

#import "ScrollItemView.h"
#import "VoiceObj.h"
#import "Utill.h"

#import "GifImageButton.h"

#define CellV 90

#define EdgeInsetTop 5
#define EdgeInsetBottom 5
#define EdgeInsetLeft 5
#define EdgeInsetRight 5

#define CellH [[UIScreen mainScreen]bounds].size.width/4 
#define CellV 200/2

//#define EveryPageShowNum 8
//- EdgeInsetLeft*4-EdgeInsetRight*4


@implementation ScrollItemView
@synthesize collectionView;
//@synthesize vCount;
//@synthesize hCount;
@synthesize sumCount;
@synthesize delegate;
@synthesize pageC;

-(instancetype)initWithFrame:(CGRect)frame WithHCount:(NSInteger) hCount WithVCount:(NSInteger) vCount WithTypeName:(NSInteger*)biaoQingTypeIndex{

    self = [super initWithFrame:frame];
    if (self) {
        [self initinalWithHCout:hCount WithVCount:vCount];
    }
    return self;
}

-(void)initinalWithHCout:(NSInteger)hTCount WithVCount:(NSInteger)vTCount{
//set data
//    pageChildreNum = [NSArray arrayWithObjects:@"2",@"3",@"4",nil];
//    biaoQingArray = [[NSMutableArray alloc]init];
//    NSLog(@"test :%@",[NSString stringWithFormat:@"biaoQing%i.png",1])  ;
//    for (int i = 1; i <= 8; i++) {
//        [biaoQingArray addObject:[NSString stringWithFormat:@"biaoQing%i.png",i]];
//    }

    
// set collectionView   
//    hCount = hTCount;
//    vCount = vTCount;
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.superview.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
//    collectionView.contentSize = CGSizeMake(CellH*hCount*EdgeInsetLeft*EdgeInsetRight, CellV*vCount*EdgeInsetTop*EdgeInsetBottom);
//    collectionView.contentSize = CGSizeMake(300, 200);
//    collectionView.contentSize = CGSizeMake(100, 100);

//    collectionView.backgroundColor = [UIColor greenColor];
    collectionView.delegate = self;
    collectionView.dataSource  = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    collectionView.pagingEnabled = YES;
    [self addSubview:collectionView];
    
//    set pageController
    pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(50, 170, 80, 20)];
    pageC.pageIndicatorTintColor = [UIColor yellowColor];
    pageC.currentPageIndicatorTintColor  = [UIColor greenColor];
    pageC.backgroundColor = [UIColor blackColor];
    
    
//    int i = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    int i = floor(fmod ((CellH+EdgeInsetLeft+EdgeInsetRight)*(CellV+EdgeInsetTop+EdgeInsetBottom)*hCount *vCount , [UIScreen mainScreen].bounds.size.width));
    
//    int i = floor();
//    NSLog(@"log i %i",i);
    
    
//    pageC.numberOfPages = 3;
//    fmod ((CellH+EdgeInsetLeft+EdgeInsetRight)*(CellV+EdgeInsetTop+EdgeInsetBottom)*hCount *vCount , ([UIScreen mainScreen].bounds.size.width * self.frame.size.height));
    NSLog(@"the test is page.numberOfPage %f",collectionView.contentSize.width/collectionView.frame.size.width);
    pageC.currentPage = 0;
    [self addSubview:pageC];
}


-(instancetype)initWithFrame:(CGRect)frame WithTypesIndex:(NSInteger*)biaoQingTypeIndex{

    self = [super initWithFrame:frame];
    if (self) {
       
        NSLog(@"sumCount is %i ",sumCount);

        biaoQingArray = [[UtilBiaoQingData shareUtil]getBiaoQingIndex:biaoQingTypeIndex];
        NSLog(@"biaoQing is %@",biaoQingArray);
        
        sumCount = [ biaoQingArray count];

        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, BiaoQingFrameWidth, self.frame.size.height) collectionViewLayout:flowLayout];
        //    collectionView.contentSize = CGSizeMake(CellH*hCount*EdgeInsetLeft*EdgeInsetRight, CellV*vCount*EdgeInsetTop*EdgeInsetBottom);
        
        //    collectionView.contentSize = CGSizeMake(100, 100);
        
        collectionView.backgroundColor = [UIColor greenColor];
        collectionView.delegate = self;
        collectionView.dataSource  = self;
//        collectionView.lay
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
        collectionView.pagingEnabled = YES;
        [self addSubview:collectionView];
        

        //    set pageController
        pageC = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height*0.8, 80, 20)];
        pageC.center = CGPointMake((self,frame.size.width/2), (self.frame.size.height*0.95));
        pageC.pageIndicatorTintColor = [UIColor yellowColor];
        pageC.currentPageIndicatorTintColor  = [UIColor greenColor];
        pageC.currentPage = 0;
        pageC.numberOfPages = sumCount%EveryPageShowNum ? sumCount/EveryPageShowNum+1 :sumCount/EveryPageShowNum;
        [self addSubview:pageC];
        
    }
    return self;
}



#pragma mark -- UICollectionViewDataSource   
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger number = sumCount%8? (sumCount+(8-sumCount%8)):sumCount ;
    NSLog(@"number is %i",number);
    return number;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    UICollectionViewCell * cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell) {
        NSLog(@"test...");
    }

    NSLog(@"test is cell :%i",indexPath.row);
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    NSLog(@"indexPaht.row is :%i",indexPath.row);
    if (indexPath.row < sumCount) {
        
          if (bQItemType == biaoQingItemVoiceImg) {

              VoiceObj* vObj = [[VoiceObj alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
              //    vObj.backgroundColor = [UIColor yellowColor];
              [vObj setImgNormalName:[biaoQingArray objectAtIndex:indexPath.row]];
              ;
             vObj.delegate = self;
              //    [vObj setImgNormalName:[((NSArray*)[[Util shareUtil]getBiaoQingIndex:1]) objectAtIndex:indexPath.row]];
              [cell addSubview:vObj];
            
             //    NSLog(@"pageC.numberOfPages : %i",pageC.numberOfPages);
              NSLog(@"pageC.numberOfPages is : %d",pageC.numberOfPages);
              //    pageC.numberOfPages =ceil( collectionView.contentSize.width/ collectionView.frame.size.width);
            
          }else if (bQItemType == biaoQingItemImg){
              ImgObj* iObj = [[ImgObj alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
              //    vObj.backgroundColor = [UIColor yellowColor];
              [iObj setImgNormalName:[biaoQingArray objectAtIndex:indexPath.row]];
//              ;
              
//              [iObj setImgNormalName:@"biaoQing.png"];
              iObj.delegate = self;
              //    [vObj setImgNormalName:[((NSArray*)[[Util shareUtil]getBiaoQingIndex:1]) objectAtIndex:indexPath.row]];
              [cell addSubview:iObj];
              
              //    NSLog(@"pageC.numberOfPages : %i",pageC.numberOfPages);
              NSLog(@"pageI.numberOfPages is : %d",pageC.numberOfPages);
              //    pageC.numberOfPages =ceil( collectionView.contentSize.width/ collectionView.frame.size.width);
     }
    }
    /*
    else if (bQItemType == biaoQingItemImg){
        UIImageView* vObj = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        //    vObj.backgroundColor = [UIColor yellowColor];
        
        vObj.image = [UIImage imageNamed:[biaoQingArray objectAtIndex:indexPath.row]];
        
//        vObj.delegate = self;
        //    [vObj setImgNormalName:[((NSArray*)[[Util shareUtil]getBiaoQingIndex:1]) objectAtIndex:indexPath.row]];
        [cell addSubview:vObj];
        
        //    NSLog(@"pageC.numberOfPages : %i",pageC.numberOfPages);
        NSLog(@"pageC.numberOfPages is : %d",pageC.numberOfPages);
        //    pageC.numberOfPages =ceil( collectionView.contentSize.width/ collectionView.frame.size.width);
        
    }else{
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.  width, cell.frame.size.height)];
        view.backgroundColor = [UIColor whiteColor];
        [cell addSubview:view];
    }
*/
    return cell;
}

//gifsend
//-(void)sendGif:(GifImageButton*)gifImg{
//    [gifImg sendGifImg];
//}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
    
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CGSize size = CGSizeMake(75, 75
//                             );
//    NSLog(@"size-w:%f ,size-h:%f",BiaoQingFrameWidth,self.frame.size.height/4);

    return contentionCellSize;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(EdgeInsetTop, EdgeInsetLeft, EdgeInsetBottom, EdgeInsetRight);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = collectionView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
//    int page = scrollView.contentOffset.x / pageWidth;
    pageC.currentPage = page;
}
-(void)sucessRecorder:(NSURL *)filePath andPicPath:(NSString *)imgPath{
    
    [self.delegate sucessRecorder:filePath andPicPath:imgPath];
//    [self.delegate keyBoradPic:imgPath andVoicePath:filePath];
}
//-(void)

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    CGSize size = CGSizeMake(5, 5);
    
    return size;
}

-(void)setbQItemType:(BiaoQingItemType)bQItemType2{
    bQItemType = bQItemType2;
}

-(BiaoQingItemType)getbQItemType{
    return bQItemType;
}

-(void)sucessForPicPath:(NSString *)file{
    
    NSLog(@"test %@",file);
    
//    -(void)sucessPicPath:(NSString *)imgPath;

    [self.myDelegate sucessPicPath:file];
}

-(void)sendGifImg:(GifImageButton*)btn{
//    [self.gifdelegate sucessedWithFile:[btn getPath]];

    
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

//    return CGSizeMake(5, 5);
//}

//-collectionView:layout:minimumInteritemSpacingForSectionAtIndex{
//
//}

@end

