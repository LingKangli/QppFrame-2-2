//
//  GifImageButton.m
//  Gif_3_demo
//
//  Created by Ling Kangli on 15/8/10.
//
//

#import "GifImageButton.h"
//#import <>

@implementation GifImageButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setImageForPath: (NSString*)imagePath{
    imgPath = imagePath;
    NSLog(@"test the path is %@",imagePath);
//    NSString *imagePath =[[NSBundle mainBundle] pathForResource:[path stringByReplacingOccurrencesOfString:@".gif" withString:@""] ofType:@"gif"];
    
//    NSString* imagePath = [[NSBundle mainBundle] pathForResource:@"2008821102746351" ofType:@"gif"];
    //1.获取图片
    NSLog(@"imagePath is %@",imagePath);
    CGImageSourceRef  cImageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:imagePath], NULL);
    
    
    if (cImageSource != nil) {
        
   
    //2.图片解析
    size_t imageCount = CGImageSourceGetCount(cImageSource);
    NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:imageCount];
    NSMutableArray *times = [[NSMutableArray alloc] initWithCapacity:imageCount];
    NSMutableArray *keyTimes = [[NSMutableArray alloc] initWithCapacity:imageCount];
    
    float totalTime = 0;
    for (size_t i = 0; i < imageCount; i++) {
        CGImageRef cgimage= CGImageSourceCreateImageAtIndex(cImageSource, i, NULL);
        [images addObject:(__bridge id)cgimage];
        CGImageRelease(cgimage);
        
        NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(cImageSource, i, NULL);
        NSDictionary *gifProperties = [properties valueForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSString *gifDelayTime = [gifProperties valueForKey:(__bridge NSString* )kCGImagePropertyGIFDelayTime];
        [times addObject:gifDelayTime];
        totalTime += [gifDelayTime floatValue];
        
        _size.width = [[properties valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
        _size.height = [[properties valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
    }
    
    float currentTime = 0;
    for (size_t i = 0; i < times.count; i++) {
        float keyTime = currentTime / totalTime;
        [keyTimes addObject:[NSNumber numberWithFloat:keyTime]];
        currentTime += [[times objectAtIndex:i] floatValue];
    }
    
    //        图片展示
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setValues:images];
    [animation setKeyTimes:keyTimes];
    animation.duration = totalTime;
    animation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:animation forKey:@"gifAnimation"];
  }
}

-(void)setImageForData: (NSData*)imageData{

    CGImageSourceRef  cImageData = CGImageSourceCreateWithData((__bridge CFDataRef)(imageData), nil);
    if (cImageData != nil) {
        //2.图片解析
        size_t imageCount = CGImageSourceGetCount(cImageData);
        NSMutableArray *images = [[NSMutableArray alloc] initWithCapacity:imageCount];
        NSMutableArray *times = [[NSMutableArray alloc] initWithCapacity:imageCount];
        NSMutableArray *keyTimes = [[NSMutableArray alloc] initWithCapacity:imageCount];
        
        float totalTime = 0;
        for (size_t i = 0; i < imageCount; i++) {
            CGImageRef cgimage= CGImageSourceCreateImageAtIndex(cImageData, i, NULL);
            [images addObject:(__bridge id)cgimage];
            CGImageRelease(cgimage);
            
            NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(cImageData, i, NULL);
            NSDictionary *gifProperties = [properties valueForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
            NSString *gifDelayTime = [gifProperties valueForKey:(__bridge NSString* )kCGImagePropertyGIFDelayTime];
            [times addObject:gifDelayTime];
            totalTime += [gifDelayTime floatValue];
            
            _size.width = [[properties valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
            _size.height = [[properties valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        }
        
        float currentTime = 0;
        for (size_t i = 0; i < times.count; i++) {
            float keyTime = currentTime / totalTime;
            [keyTimes addObject:[NSNumber numberWithFloat:keyTime]];
            currentTime += [[times objectAtIndex:i] floatValue];
        }
        
        //        图片展示
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [animation setValues:images];
        [animation setKeyTimes:keyTimes];
        animation.duration = totalTime;
        animation.repeatCount = HUGE_VALF;
        [self.layer addAnimation:animation forKey:@"gifAnimation"];
    }
}

-(NSString*)getPath{
    return imgPath;
}

//-(void)sendGifImg{
//    NSLog(@"test gifimage%@",imgPath);
//    [super addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//    [self.delegate sucessedWithFile:imgPath];
//}
@end
