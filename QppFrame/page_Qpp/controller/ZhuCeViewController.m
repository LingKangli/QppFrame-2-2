//
//  ZhuCeViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/7/11.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//
//http://blog.csdn.net/ryantang03/article/details/8203605 (解决UITextField遮挡问题。)

#import "ZhuCeViewController.h"
#import "TitleView.h"
#import "Utill.h"
#import "XWAlterview.h"
#import "ServerConnect.h"

#define ContentCGRect CGRectMake(0, titleY+titleHeight, UIScreenWidth, UIScreenHeight-titleHeight)
#define titleItemY -10


@implementation ZhuCeViewController

//-(instancetype)init{
//
//    self = [self init];
//    if (self) {
//        
//        alterTitle = @"";
//        alterContentText = @"";
//        alterleftButtonTitile = @"";
//        alterRightButtonTitle = @"";
//    }
//    return self;
//}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
  
    alterTitle = @"";
    alterContentText = @"";
    alterleftButtonTitile = @"";
    alterRightButtonTitle = @"";
    
    contentView = [[UIView alloc]initWithFrame:ContentCGRect];
//    contentView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:contentView];
    
    
    TitleView* titleView = [[TitleView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, titleHeight)];
    [titleView.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
     titleView.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    [titleView.leftBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:titleView];
    
    UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth/2-50, 30, 100, 100)];
    img.image = [UIImage imageNamed:@"QPP1_03.png"];
    [contentView addSubview:img];
    
    UIImageView* userBG = [[UIImageView alloc]initWithFrame:CGRectMake(20, img.frame.origin.y+img.frame.size.height+80, UIScreenWidth-40, 40)];
    userBG.userInteractionEnabled = YES;
    userBG.image = [UIImage imageNamed:@"userNameBGImg.png"];
    [contentView addSubview:userBG];

    userName = [[UITextField alloc]initWithFrame:CGRectMake(60, 3, UIScreenWidth-115, 40)];
    userName.font = [UIFont systemFontOfSize:18];
    userName.placeholder = @"请输入您的注册邮箱";
    userName.delegate = self;
    [userBG addSubview:userName];

//UIImageView的userInteractionEnabled为YES,
    
    UIImageView* pwdBG = [[UIImageView alloc]initWithFrame:CGRectMake(20, userBG.frame.origin.y+userBG.frame.size.height+50, UIScreenWidth-40, 40)];
    pwdBG.image = [UIImage imageNamed:@"passWordBGImg.png"];
    pwdBG.userInteractionEnabled = YES;
    [contentView addSubview:pwdBG];
    
    pwdName = [[UITextField alloc]initWithFrame:CGRectMake(60, 3, UIScreenWidth-115, 40)];
    pwdName.placeholder = @"请输入您的密码";
    pwdName.delegate = self;
    [pwdBG addSubview:pwdName];
    
    UIImageView* pwdAgainBG = [[UIImageView alloc]initWithFrame:CGRectMake(20, pwdBG.frame.origin.y+pwdBG.frame.size.height+10, UIScreenWidth-40, 40)];
    pwdAgainBG.image = [UIImage imageNamed:@"passWordBGImg.png"];
    pwdAgainBG.userInteractionEnabled = YES;
    [contentView addSubview:pwdAgainBG];
    
    pwdAgainName = [[UITextField alloc]initWithFrame:CGRectMake(60, 3, UIScreenWidth-115, 40)];
    pwdAgainName.placeholder = @"请再次输入您的密码";
    pwdAgainName.delegate = self;
    [pwdAgainBG addSubview:pwdAgainName];
    
    //指定编辑时键盘的return键类型
    userName.returnKeyType = UIReturnKeyNext;
    pwdName.returnKeyType = UIReturnKeyDefault;
    pwdAgainName.returnKeyType = UIReturnKeyDefault;
    
    //注册键盘响应事件方法
    [userName addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [pwdAgainName addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [pwdName addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];

    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    UIButton*  resignBtn = [[UIButton alloc]initWithFrame:CGRectMake(userBG.frame.origin.x, pwdAgainBG.frame.origin.y+pwdAgainBG.frame.size.height+50, pwdAgainBG.frame.size.width, pwdAgainBG.frame.size.height-10)];
    resignBtn.backgroundColor = BackColor;
    resignBtn.layer.cornerRadius = 5.0;
    [resignBtn setTitle:@" 注  册" forState:UIControlStateNormal];
    [resignBtn addTarget:self action:@selector(resignClickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    resignBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    resignBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [contentView addSubview:resignBtn];
}

-(void)resignClickBtn:(id) sender{
    
    
   BOOL  isResign =  [self sendMessgeToServer];
    
    XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"" contentText:alterContentText leftButtonTitle:alterleftButtonTitile rightButtonTitle:alterRightButtonTitle];

    if (isResign) {
        alter.leftBlock=^()
        {
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"exit.");}];
            NSLog(@"左边按钮被点击");
        };
    }else{
        
        alter.leftBlock=^()
        {
            NSLog(@"左边按钮被点击");
        };
        
    }
    alter.dismissBlock=^()
    {
        NSLog(@"窗口即将消失");
    };
    
    [alter show];
}
//返回按钮事件
-(void)returnClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"exit.");}];
}

-(BOOL)sendMessgeToServer{
    
    NSDictionary* reslutInfo = [[NSDictionary alloc]init];
    reslutInfo =[[ServerConnect sharedManager]resignToName:userName.text ToPwd:pwdName.text];
    
    if (reslutInfo != nil) {

        alterTitle = [reslutInfo objectForKey:@"result"];
        alterContentText = [reslutInfo objectForKey:@"data"];
        alterleftButtonTitile = @"确定";
        alterRightButtonTitle = @"取消";
        NSLog(@"alterTitle%@",alterTitle);
        NSLog(@"alterContentText%@",alterContentText);
        NSLog(@"alterleftButtonTitile%@",alterleftButtonTitile);
        NSLog(@"alterRightButtonTitle%@",alterRightButtonTitle);
        if ([alterContentText isEqualToString:@"Registered successfully!"]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}



//-(BOOL)isReginSucess{

    /*一。本地检测
     *   1.用户名是否为空，用户密码是否为空，二次输入密码是否为空。
     *   2.用户密码与二次输入密码是否一致。＝＝＝＝》发送到服务器
     *二。服务器端检测
     *   1.用户名是否已存在。
     */
    
  /*
    if((![userName.text isEqualToString:@""]) && ![pwdName.text isEqualToString:@"" ]&& ![pwdAgainName.text isEqualToString:@""]){//用户名是否为空，用户密码是否为空，二次输入密码是否为空。
        
        if ([pwdName.text isEqualToString:pwdAgainName.text]) {//用户密码与二次输入密码是否一致。
            
            NSString* info = [[NSString alloc]init];
          info = [[ServerConnect sharedManager]isResignOKToName:@"test" ToPwd:@"testok"];
            
            XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"注册信息" contentText:info leftButtonTitle:@"确定"  rightButtonTitle:@"取消"];
            alter.rightBlock=^()
            {
                NSLog(@"右边按钮被点击");
            };
            alter.leftBlock=^()
            {
                
                NSLog(@"左边按钮被点击");
            };
            alter.dismissBlock=^()
            {
                NSLog(@"窗口即将消失");
            };
            [alter show];
            */
//      发送数据到服务器端。
//      http://blog.csdn.net/kangli_1990/article/details/46875999
           
            
//            if ([[ServerConnect sharedManager]isResignOKToName:@"test" ToPwd:@"testok"]isEqualToString:@"1") {
//                return YES;
//            }else{
//            
//                return NO;
//            }
//            
  /*      }

    }
    
    return NO;

}*/

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-30,width,height);
    contentView.frame=rect;
    [UIView commitAnimations];
    return YES;
}

//恢复原始视图位置
-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect=ContentCGRect;
    contentView.frame=rect;
    [UIView commitAnimations];
    
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    NSLog(@"hidenKeyboard");
    [userName resignFirstResponder];
    [pwdName resignFirstResponder];
    [pwdAgainName resignFirstResponder];
    [self resumeView];
}

//点击键盘上的Return按钮响应的方法
-(void)nextOnKeyboard:(UITextField *)sender
{
    if (sender == userName ) {
        [userName becomeFirstResponder];
        [self resumeView];
    }else if (sender == pwdAgainName || sender == pwdName){
        [self hidenKeyboard];
    }
}


@end
