//
//  GifImageButton.h
//  Gif_3_demo
//
//  Created by Ling Kangli on 15/8/10.
//
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
//#import "KeyBoradContentView.h"

@protocol GifImageBtnDelegate <NSObject>

-(void)sucessedWithFile:(NSString*)file;

@end
@class KeyBoradContentView;

@interface GifImageButton : UIButton<GifImageBtnDelegate>{
//    CGImageSourceRef gif;
//    NSDictionary *gifProperties;
//    size_t index;
//    size_t count;
//    NSTimer *timer;
//

    CGSize _size;
    NSString* imgPath;
}
@property(nonatomic,strong)id<GifImageBtnDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)setImageForPath: (NSString*)path;
-(NSString*)getPath;
-(void)sendGifImg;

@end
