//
//  KLAlterPicker.m
//  QppFrame
//
//  Created by 孙兴国 on 15/8/15.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "KLAlterPicker.h"
#import "Utill.h"

#define AlertWidth 100
#define BtnHeight 40


@implementation KLAlterPicker
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//init+大写字母开头+其他
-(instancetype)initWithDirection:(DirectionType)dirType WithButtonNum:(NSInteger)num WithStly:(AlterStly)alertStyle{

//    self = [super init];//
    switch (alertStyle) {
        case AlterStlyDefult://中间显示
        {
            self = [super initWithFrame:CGRectMake((UIScreenWidth/2 - AlertWidth/2), ((UIScreenHeight/2)-((BtnHeight*num)/2)), AlertWidth, BtnHeight*num)];//设置alert位置
            
            if (self) { //设置按钮
                CGFloat x = 0;
                CGFloat y = 0;
                for (NSInteger n = 0  ; n<num; n++) {
                    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, AlertWidth, BtnHeight)];
                    if (n %2 == 0) {
                        btn.backgroundColor = [UIColor redColor];
                    }else{
                        btn.backgroundColor = [UIColor blueColor];
                    }
                    btn.tag = n;
                    btn.layer.borderColor = [UIColor blackColor].CGColor;
                    btn.layer.borderWidth = 1.0;
                    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
                    y += btn.frame.size.height;
//                    [[UIApplication alloc] addSubview:btn];
                    [self addSubview:btn];
                }
            }
        }
            break;
            
        default:
            break;
    }
    return self;
}

-(void)clickBtn:(UIButton*)btn {

    [self.delegate clickTheBtn:btn];
}



@end
