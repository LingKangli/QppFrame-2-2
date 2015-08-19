//
//  KeyBoradContentView.m
//  KeyBorad
//
//  Created by LingKangLi on 15/7/7.
//  Copyright (c) 2015年 fengdu. All rights reserved.
//

#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#import "KeyBoradContentView.h"
#import "Utill.h"
#import "PicViewItem.h"
#import "VoiceObj.h"

#import "XWAlterview.h"
//#import "ChatMultiViewController.h"

#define verticalCount 2    //垂直2行
#define horizontalCount 4  //水平4行

#define verticalHeight  90  //垂直90
#define horizontalWidth UIScreenWidth/4  //水平80


#define kUTTypeImage @".png"

@implementation KeyBoradContentView
@synthesize keyBoradState = _keyBoradState;
@synthesize delegate;

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

  
    if (self) {

        showViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        frameView = [[UIView alloc]initWithFrame:showViewFrame];
        
        _keyBoradState = KeyBoradContentState_none;
        [self initWithState:_keyBoradState];
        
        isCreateVoice = NO;
        isCreateEmj = NO;
        isCreatePic = NO;
        isVoicePicker = NO;
        
        NSArray* imgs = [[NSArray alloc]initWithObjects:@"biaoQing1.png",@"biaoQing2.png",@"biaoQing3.png",@"biaoQing4.png", nil];
        NSArray* imgs2 = [[NSArray alloc]initWithObjects:@"biaoQing5.png",@"biaoQing6.png",@"biaoQing7.png",@"biaoQing4.png", nil];
        imgNames = [[NSArray alloc]initWithObjects:imgs,imgs2,nil];
    }
    return self;
}

-(void)initWithState:(KeyBoradContentState)keyBoradStates{

//    [self removeFromSuperview];
    for(int i = 0;i<[frameView.subviews count];i++){
        [[frameView.subviews objectAtIndex:i]removeFromSuperview] ;
    }
    
    switch (keyBoradStates) {
        case KeyBoradContentState_none:{
            isCreateEmj = NO;
            isCreatePic = NO;
            isCreateVoice = NO;
//            frameView= nil;
        }
            
            break;
        case KeyBoradContentState_voice:{
            isCreateVoice = YES;
            [self addVoiceKeyBoradView];
        }
            
            break;
        case KeyBoradContentState_Emoji:{
            isCreateEmj = YES;
            [self addFaceKeyBoradView];
        }
            
            break;
        case KeyBoradContentState_Pic:{
            isCreatePic = YES;
            [self addPicKeyBoradView];
        }
            break;
            
        default:
            break;
    }
}

-(void)initVoiceKeyBorad:(UIView*)backView{

    
    NSLog(@"voice borad");
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
   [data setObject:@"add some content" forKey:@"c_key"];
    
    NSLog(@"%@", data);//直接打印数据。
    
    UIButton* btn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
    [btn1 setImage:[UIImage imageNamed:@"voice_HL@2x.png"] forState:UIControlStateNormal];
    [backView addSubview:btn1];
}


-(void)changeToState:(KeyBoradContentState)keyBoradState{

    [self initWithState:keyBoradState];
}


//from here .............
-(void)addVoiceKeyBoradView{

  
//    UIScreen *screen = [UIScreen mainScreen];
//    width = screen.bounds.size.width;
//    height = screen.bounds.size.height;
    //    images= @[@"1.jpg",@"2.jpg"];
//    frameView = nil;//释放所有frameView上的元素。－－注意此处需要正确方法
    for(int i = 0;i<[frameView.subviews count];i++){
        [[frameView.subviews objectAtIndex:i]removeFromSuperview] ;
    }
//    frameView = [[UIView alloc]initWithFrame:showViewFrame];
//    frameView.backgroundColor = [UIColor yellowColor];
    
    biaoQingArray = [[UtilBiaoQingData shareUtil]getBiaoQingTypeArray];
    NSLog(@"biaoQingType is %@",biaoQingArray);
    
    // Do any additional setup after loading the view, typically from a nib.
    
    int biaoQingTypeNum = [biaoQingArray count];
    //    NSMutableArray* biaoQingItemNum = [NSMutableArray arrayWithObjects:@[{2,3}],@[{2,8}], nil];
    
    scrollViewArray = [[NSMutableArray alloc]init];//存有几组表情
    
    //    外框
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BiaoQingFrameWidth, frameView.frame.size.height*0.8)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    NSInteger x = 0;
    NSInteger y = 0;
    CGFloat contentWidth = 0;
    NSInteger allStyleNum = 0;
    
//    CGFloat contentHeight1 = frameView.frame.size.height*0.8;
    
    
    for (int num = 0; num < biaoQingTypeNum; num++) {
        
        //        ScrollItemView* sIV = [[ScrollItemView alloc]initWithFrame:CGRectMake(x, y, [UIScreen mainScreen].bounds.size.width, contentHeight) WithHCount:2 WithVCount:10 WithTypeName:num+1];
         allStyleNum += [[[UtilBiaoQingData shareUtil]getBiaoQingIndex:num]count];
//        bQSumNum = bQSumNum%8 ? (bQSumNum/8+1) :bQSumNum/8;
        ScrollItemView* sIV = [[ScrollItemView alloc]initWithFrame:CGRectMake(x, y, BiaoQingFrameWidth, scrollView.frame.size.height) WithTypesIndex:num];
        [sIV setbQItemType:biaoQingItemVoiceImg];
        sIV.delegate = self;

        if (num%2 == 0) {
            [sIV setBackgroundColor:[UIColor greenColor]];
        }else{
            [sIV setBackgroundColor:[UIColor grayColor]];
        }
        
        NSLog(@"the num is %i",num);
        [scrollViewArray addObject:sIV];
        [scrollView addSubview:sIV];
        
        x += sIV.frame.size.width;
        y = y;
        contentWidth+=BiaoQingFrameWidth;

    }

    scrollView.contentSize = CGSizeMake(contentWidth, scrollView.frame.size.height);
    [frameView addSubview:scrollView];
    //
    NSLog(@"the scrollView .frame : %f",scrollView.frame.size.height);
    dynamicScrollView = [[DynamicScrollView alloc] initWithFrame:CGRectMake(0,scrollView.frame.size.height, UIScreenWidth, frameView.frame.size.height-scrollView.frame.size.height) withImages:[biaoQingArray mutableCopy]];
    dynamicScrollView.delegate = self;
    dynamicScrollView.backgroundColor = [UIColor redColor];
    
    [frameView addSubview:dynamicScrollView];
    [self addSubview:frameView];
    
    
    
    
//    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(20, dynamicScrollView.frame.origin.y+dynamicScrollView.frame.size.height+20, 20, 20)];
//    btn.layer.borderWidth = 1;
//    btn.layer.borderColor = [UIColor blackColor].CGColor
//    ;
//    btn.backgroundColor  = [UIColor greenColor];
//    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [frameView addSubview:btn];

//    self.backgroundColor = [UIColor greenColor];
    
    /*
    frameView = nil;//释放所有frameView上的元素。－－注意此处需要正确方法
    frameView = [[UIView alloc]initWithFrame:showViewFrame];
    frameView.backgroundColor = [UIColor yellowColor];
    
    for (int vertical = 0; vertical < verticalCount; vertical++) {
        for (int horizontal = 0; horizontal < horizontalCount; horizontal++) {
//            VoiceItemButton* itemBtn = [[VoiceItemButton alloc]initWithFrame:CGRectMake(horizontal*horizontalWidth,vertical* verticalHeight, horizontalWidth, 90)];
//            itemBtn.backgroundColor = [UIColor greenColor];
//            [itemBtn setImgNormalName:[[imgNames objectAtIndex:vertical] objectAtIndex:horizontal]];
//            [itemBtn setImgSelectedName:@"face@2x.png"];
//            [frameView addSubview:itemBtn];
            
            VoiceObj* itemVoiceBtn = [[VoiceObj alloc]initWithFrame:CGRectMake(horizontal*horizontalWidth,vertical* verticalHeight, horizontalWidth, 90)];
            [itemVoiceBtn setImgNormalName:[[imgNames objectAtIndex:vertical] objectAtIndex:horizontal]];
            [itemVoiceBtn setImgSelectedName:[[imgNames objectAtIndex:vertical] objectAtIndex:horizontal]];
            itemVoiceBtn.delegate = self;
            [frameView addSubview:itemVoiceBtn];
//            [frameView addSubview:itemVoiceBtn.imgView];
            
        }
    }
    UIButton* frameIndexBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,verticalHeight*verticalCount, UIScreenWidth/5, 30)];
    frameIndexBtn.backgroundColor = [UIColor redColor];
    [frameIndexBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [frameView addSubview:frameIndexBtn];
    [self addSubview:frameView];
    */
}

//biaoQing use begin
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"the test is scroll.");
}

-(void)clickDymamic:(id)sender{
    
    
    NSLog(@"the test is %i",((UIImageView*)sender).tag);
    
    CGRect frame = scrollView.frame;
    frame.origin.x = ((ScrollItemView*)[scrollViewArray objectAtIndex:((UIButton*)sender).tag]).frame.origin.x;
    frame.origin.y = 0;
    NSLog(@"frame is x:%f",frame.origin.x);
    [scrollView scrollRectToVisible:frame animated:YES];
    [((ScrollItemView*)[scrollViewArray objectAtIndex:((UIButton*)sender).tag]).collectionView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    
}
//biaoQing use end
-(void)click:(id)sender{

    NSLog(@"click.");
}

-(void)sucessRecorder:(NSURL *)filePath andPicPath:(NSString *)imgPath{

    [self.delegate keyBoradPic:imgPath andVoicePath:filePath];
}

-(void)sucessPicPath:(NSString*)filePath2{
    
  [self.delegate keyBoradPic:filePath2];
}
-(void)sucessRecorder:(NSURL*)filePath2 andPic:(UIImage*) img{
    [self.delegate keyBoradPicWithImg:img andVoicePath:filePath2] ;
    [self addPicKeyBoradView];
}

#pragma addFaceBoradView


-(void)addFaceKeyBoradView{

    frameView.backgroundColor = [UIColor brownColor];
//    for(int i = 0;i<[frameView.subviews count];i++){
//        [[frameView.subviews objectAtIndex:i]removeFromSuperview] ;
//    }
    [self viewClear:frameView];
    
    
//    for(int i = 0;i<[frameView.subviews count];i++){
//        [[frameView.subviews objectAtIndex:i]removeFromSuperview] ;
//    }
    //    frameView = [[UIView alloc]initWithFrame:showViewFrame];
    //    frameView.backgroundColor = [UIColor yellowColor];
    
    biaoQingArray = [[UtilBiaoQingData shareUtil]getBiaoQingTypeArray];
    NSLog(@"biaoQingType is %@",biaoQingArray);
    
    // Do any additional setup after loading the view, typically from a nib.
    
    int biaoQingTypeNum = [biaoQingArray count];
    //    NSMutableArray* biaoQingItemNum = [NSMutableArray arrayWithObjects:@[{2,3}],@[{2,8}], nil];
    
    scrollViewArray = [[NSMutableArray alloc]init];//存有几组表情
    
    //    外框
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, BiaoQingFrameWidth, frameView.frame.size.height*0.8)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    NSInteger x = 0;
    NSInteger y = 0;
    CGFloat contentWidth = 0;
    NSInteger allStyleNum = 0;
    
    //    CGFloat contentHeight1 = frameView.frame.size.height*0.8;
    
    
    for (int num = 0; num < biaoQingTypeNum; num++) {
        allStyleNum += [[[UtilBiaoQingData shareUtil]getBiaoQingIndex:num]count];
        ScrollItemView* sIV = [[ScrollItemView alloc]initWithFrame:CGRectMake(x, y, BiaoQingFrameWidth, scrollView.frame.size.height) WithTypesIndex:num];
        sIV.myDelegate = self;
        [sIV setbQItemType:biaoQingItemImg];
        if (num%2 == 0) {
            [sIV setBackgroundColor:[UIColor greenColor]];
        }else{
            [sIV setBackgroundColor:[UIColor grayColor]];
        }
        NSLog(@"the num is %i",num);
        [scrollViewArray addObject:sIV];
        [scrollView addSubview:sIV];
        
        x += sIV.frame.size.width;
        y = y;
        contentWidth+=BiaoQingFrameWidth;
    }
    
    scrollView.contentSize = CGSizeMake(contentWidth, scrollView.frame.size.height);
    [frameView addSubview:scrollView];
    //
    NSLog(@"the scrollView .frame : %f",scrollView.frame.size.height);
    dynamicScrollView = [[DynamicScrollView alloc] initWithFrame:CGRectMake(0,scrollView.frame.size.height, UIScreenWidth, frameView.frame.size.height-scrollView.frame.size.height) withImages:[biaoQingArray mutableCopy]];
    dynamicScrollView.delegate = self;
    dynamicScrollView.backgroundColor = [UIColor redColor];
    
    [frameView addSubview:dynamicScrollView];
    [self addSubview:frameView];
}

-(void)addPicKeyBoradView{

    [self viewClear:frameView];
    for (int i = 0; i < 4; i++) {
        PicViewItem* item = [[PicViewItem alloc]initWithFrame:CGRectMake(10+(10+80)*i, 5, 80, 80)];
        switch (i) {
            case 0:
                item.itemLab.text = @"Album" ;
                item.tag  = i;
                item.itemView.image = [UIImage imageNamed:@"face@2x.png"];
                break;
            case 1:
                item.itemLab.text = @"Camera" ;
                item.tag  = i;
                item.itemView.image = [UIImage imageNamed:@"face@2x.png"];
                break;
            case 2:
                item.itemLab.text = @"VSticker" ;
                item.tag  = i;
                item.itemView.image = [UIImage imageNamed:@"face@2x.png"];
                break;
            case 3:
                item.itemLab.text = @"VPhoto" ;
                item.tag  = i;
                item.itemView.image = [UIImage imageNamed:@"face@2x.png"];
                break;
                
            default:
                break;
                
        }
        [item addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
        [frameView addSubview:item];
    }

    frameView.backgroundColor = [UIColor greenColor];
    [self addSubview:frameView];
}

-(void)addVoiceImgFrom:(UIImage*)img{
    
    [self viewClear:frameView];
    CGFloat distince = 10.0;
    VoiceObj* vOB = [[VoiceObj alloc]initWithFrame:CGRectMake(0, distince, 100, 100)];
    [vOB setImgNormal:img];
    vOB.delegate = self;
    [self addSubview:vOB];

    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    btn.center = CGPointMake(vOB.frame.origin.x+vOB.frame.size.width, vOB.frame.origin.y);
    btn.layer.cornerRadius = 0.4;
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(addPicKeyBoradView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)viewClear:(UIView*)view {

    for(id tmpView in [view subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[PicViewItem class]])
        {
            UIImageView *imgView = (UIImageView *)tmpView;
            
            [imgView removeFromSuperview]; //删除子视图
        }
        
        if ([tmpView isKindOfClass:[UIView class]]) {
            UIImageView* imgView = (UIImageView*)tmpView;
            [imgView removeFromSuperview];
        }
    }
    
    for(id tmpView in [[[UIApplication sharedApplication] keyWindow] subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[KLAlterPicker class]])
        {
            UIImageView *imgView = (UIImageView *)tmpView;
            [imgView removeFromSuperview]; //删除子视图
        }
    }

}

-(void)picClick:(id)sender{
    
    NSLog(@"tag is test %i",((PicViewItem*)sender).tag);
    
    switch (((PicViewItem*)sender).tag) {
        case  0:{
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
//            isVoicePicker = NO;
//            isManyVoicePicker = NO;
            photoUseType = PhotoByPhoto;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES; //图片可编辑
            //            需要添加委托
            //            [self p];
            [[self getTheViewController] presentModalViewController:imagePicker animated:YES];
            
        }
            break;
        case  1:{
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
//            isVoicePicker = NO;
//            isManyVoicePicker = NO;
            photoUseType = PhotoByPhoto;

            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES; //图片可编辑
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            imagePicker.showsCameraControls  = YES;
            [[self getTheViewController] presentModalViewController:imagePicker animated:YES];

        }
            break;
        case  2:{
//            isManyVoicePicker = NO;
            photoUseType = PhotoByPVoice;
            KLAlterPicker* k = [[KLAlterPicker  alloc]initWithDirection:directionTypeMid WithButtonNum:2 WithStly:AlterStlyDefult];
            k.delegate = self;
            [[[UIApplication sharedApplication] keyWindow] addSubview:k];
        }
            break;
        case  3:{
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
//            isVoicePicker = NO;
//            isManyVoicePicker = YES;
            photoUseType = PhotoByManyPVoice;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES; //图片可编辑
            //            需要添加委托
            //            [self p];
            [[self getTheViewController] presentModalViewController:imagePicker animated:YES];
        }
            break;
        default:
            break;
    }
    
}
-(void)clearKLAlterPickerFromWindow{
    
  }

//Delegate
-(void)clickTheBtn:(UIButton *)btn{

    NSLog(@"the test is %i",btn.tag);
    switch (btn.tag) {
        case  0:{
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
            isVoicePicker = YES;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES; //图片可编辑
            //            需要添加委托
            //            [self p];
            [[self getTheViewController] presentModalViewController:imagePicker animated:YES];
            [btn.superview removeFromSuperview];
        }
            break;
        case  1:{
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
            isVoicePicker = YES;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES; //图片可编辑
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.showsCameraControls  = YES;
            [[self getTheViewController] presentModalViewController:imagePicker animated:YES];
            [btn.superview removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

-(UIViewController*)getTheViewController{
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

#pragma pickerDelegate.
//.UIImagePickerController回调详解：
//成功获得相片还是视频后的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    /*
    NSLog(@"the info is %@",info);
    
    if (!isVoicePicker) {
        
            UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
            //        lingkanglitest
            NSData* data = UIImageJPEGRepresentation(orgImage, 1.0);
            [self.delegate keyBoradPicForData:data ForType:DataTypeImg];
            [picker dismissViewControllerAnimated:YES completion:nil];
        
    }else{
//        for(int i = 0;i<[frameView.subviews count];i++){
//            [[frameView.subviews objectAtIndex:i]removeFromSuperview] ;
//        }
//        frameView = nil;
        //依次遍历self.view中的所有子视图
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        [self addVoiceImgFrom:orgImage];
        [picker dismissViewControllerAnimated:YES completion:nil];

    }
     */
    
    switch (photoUseType) {
        case PhotoByPhoto:{
            UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
            //        lingkanglitest
            NSData* data = UIImageJPEGRepresentation(orgImage, 1.0);
            [self.delegate keyBoradPicForData:data ForType:DataTypeImg];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        case PhotoByPVoice:{
            //依次遍历self.view中的所有子视图
            UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
            [self addVoiceImgFrom:orgImage];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
        case PhotoByManyPVoice:{
            UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
            //        lingkanglitest
            NSData* data = UIImageJPEGRepresentation(orgImage, 1.0);
//            [self.delegate keyBoradPicForData:data ForType:DataTypeImg];
            
//            ChatMultiViewController  *cMVC = [[ChatMultiViewController alloc]init];
//            [[self getTheViewController] presentModalViewController:cMVC animated:YES];
            
            UIView* imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
            imageView.backgroundColor = [UIColor greenColor];
            [[[UIApplication sharedApplication] keyWindow]  addSubview:imageView];
            
            
            [picker dismissViewControllerAnimated:YES completion:nil];
            
            
        }
            break;
            
        default:
            break;
    }
}

//取消照相机的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //模态方式退出uiimagepickercontroller
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - 保存图片至沙盒
//- (NSString*) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
//{
//    
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    // 获取沙盒目录
//    
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    // 将图片写入文件
//    
//    [imageData writeToFile:fullPath atomically:NO];
//    return fullPath;
//}
//- (void)saveImageToPhotos:(UIImage*)savedImage
//{
//    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//}
// 指定回调方法
//- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
//{
//    NSString *msg = nil ;
//    if(error != NULL){
//        msg = @"保存图片失败" ;
//    }else{
//        msg = @"保存图片成功" ;
//    }
//    NSLog(@"contextInfo : %@",contextInfo);
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
//                                                    message:msg
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
//}



#define DefaultThumImageHigth 90.0f
#define DefaultPressImageHigth 960.0f
    
//-(void)saveGifToDocument:(NSURL *)srcUrl {
//        
//        ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
//            
//            if (asset != nil) {
//                ALAssetRepresentation *rep = [asset defaultRepresentation];
//                Byte *imageBuffer = (Byte*)malloc((unsigned long)rep.size);
//                NSUInteger bufferSize = [rep getBytes:imageBuffer fromOffset:0.0 length:(unsigned long)rep.size error:nil];
//                NSData *imageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
//                
//                NSDateFormatter* formater = [[NSDateFormatter alloc] init];
//                [formater setDateFormat:@"yyyyMMddHHmmssSSS"];
//                NSString* fileName =[NSString stringWithFormat:@"%@.gif", [formater stringFromDate:[NSDate date]]];
//                NSString* filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
//                
//                [imageData writeToFile:filePath atomically:YES];
//                
//                NSLog(@"path: %@",filePath);
//                
////               testImg.image = [UIImage imageWithContentsOfFile:filePath];
//                [self.delegate keyBoradPic:filePath];
//                
////                ECImageMessageBody *mediaBody = [[ECImageMessageBody alloc] initWithFile:filePath displayName:filePath.lastPathComponent];
////                [self sendMediaMessage:mediaBody];
//            } else {
//            }
//        };
//        
//        ALAssetsLibrary* assetLibrary = [[ALAssetsLibrary alloc] init];
//        [assetLibrary assetForURL:srcUrl
//                      resultBlock:resultBlock
//                     failureBlock:^(NSError *error){
//                     }];
//}

//-(void)saveGifToDocumentForData:(NSData *)data {

//    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
        /*
        if (asset != nil) {
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            Byte *imageBuffer = (Byte*)malloc((unsigned long)rep.size);
            NSUInteger bufferSize = [rep getBytes:imageBuffer fromOffset:0.0 length:(unsigned long)rep.size error:nil];
            NSData *imageData = [NSData dataWithBytesNoCopy:imageBuffer length:bufferSize freeWhenDone:YES];
            
            NSDateFormatter* formater = [[NSDateFormatter alloc] init];
            [formater setDateFormat:@"yyyyMMddHHmmssSSS"];
            NSString* fileName =[NSString stringWithFormat:@"%@.gif", [formater stringFromDate:[NSDate date]]];
            NSString* filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
            
            [imageData writeToFile:filePath atomically:YES];
            
            NSLog(@"path: %@",filePath);
            
            //               testImg.image = [UIImage imageWithContentsOfFile:filePath];
            [self.delegate keyBoradPic:filePath];
            
            //                ECImageMessageBody *mediaBody = [[ECImageMessageBody alloc] initWithFile:filePath displayName:filePath.lastPathComponent];
            //                [self sendMediaMessage:mediaBody];
        } else {
        }
         */
//    };
    
//    ALAssetsLibrary* assetLibrary = [[ALAssetsLibrary alloc] init];
//    [assetLibrary assetForURL:srcUrl
//                  resultBlock:resultBlock
//                 failureBlock:^(NSError *error){
//                 }];
    
    
//}

/*
-(NSString*)saveToDocument:(UIImage*)image {
    UIImage* fixImage = [self fixOrientation:image];
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString* fileName =[NSString stringWithFormat:@"%@.jpg", [formater stringFromDate:[NSDate date]]];
    
    NSString* filePath=[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    //图片按0.5的质量压缩－》转换为NSData
    CGSize pressSize = CGSizeMake((DefaultPressImageHigth/fixImage.size.height) * fixImage.size.width, DefaultPressImageHigth);
    UIImage * pressImage = [CommonTools compressImage:fixImage withSize:pressSize];
    NSData *imageData = UIImageJPEGRepresentation(pressImage, 0.5);
    [imageData writeToFile:filePath atomically:YES];
    
    CGSize thumsize = CGSizeMake((DefaultThumImageHigth/fixImage.size.height) * fixImage.size.width, DefaultThumImageHigth);
    UIImage * thumImage = [CommonTools compressImage:fixImage withSize:thumsize];
    NSData * photo = UIImageJPEGRepresentation(thumImage, 0.5);
    NSString * thumfilePath = [NSString stringWithFormat:@"%@.jpg_thum", filePath];
    [photo writeToFile:thumfilePath atomically:YES];
    
    return filePath;
    
}*/





@end
