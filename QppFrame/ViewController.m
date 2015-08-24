//
//  ViewController.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "ViewController.h"
#import "TabBarViewController.h"
#import "Utill.h"
#import "ZhuCeViewController.h"
#import "ServerConnect.h"
#import "XWAlterview.h"

#define loginHeight 100
#define loginWeight 100

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIImage *image = [UIImage imageNamed:@"BGImg.png"];
    self.view.layer.contents = (id) image.CGImage;

    UIImageView* logImg = [[UIImageView alloc]initWithFrame:CGRectMake(UIScreenWidth/2-loginWeight/2, 100, loginWeight, loginHeight)];
    logImg.image = [UIImage imageNamed:@"loginIcon.png"];
    [self.view addSubview:logImg];

    UIImageView* userBG = [[UIImageView alloc]initWithFrame:CGRectMake(50, UIScreenHeight/2-50, UIScreenWidth*0.8, 0.7)];
    userBG.backgroundColor = COLOR(178, 178, 181, 1);
    [self.view addSubview:userBG];
    
    UIImageView* userImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, userBG.frame.origin.y-30, 20,25)];
    userImg.image = [UIImage imageNamed:@"1.png"];
    [self.view addSubview:userImg];
    
    NSMutableAttributedString * attributedUser = [[NSMutableAttributedString alloc]initWithString:@"QQ号/手机号/邮箱"];
    [attributedUser addAttribute:NSForegroundColorAttributeName value:COLOR(178, 178, 181, 1) range:NSMakeRange(0, attributedUser.length)];
    userName = [[UITextField alloc]initWithFrame:CGRectMake(userImg.frame.origin.x+50, userImg.frame.origin.y-10, UIScreenWidth*0.6, 50)];
    userName.attributedPlaceholder = attributedUser;
    [userName setValue:COLOR(178, 178, 181, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [userName setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];  //    userName.tintColor = [UIColor whiteColor];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [self.view addSubview:userName ];

    
    UIImageView* pwdImgBG = [[UIImageView alloc]initWithFrame:CGRectMake(50, userImg.frame.origin.y+userImg.frame.size.height+50, UIScreenWidth*0.8, 0.7)];
    pwdImgBG.backgroundColor = COLOR(178, 178, 181, 1);
    [self.view addSubview:pwdImgBG];
   
    
    UIImageView* pwdImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, pwdImgBG.frame.origin.y-30, 20,25)];
    pwdImg.image = [UIImage imageNamed:@"2.png"];
    [self.view addSubview:pwdImg];
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:@"密码"];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:COLOR(178, 178, 181, 1) range:NSMakeRange(0, attributedStr.length)];

    
    pwdName = [[UITextField alloc]initWithFrame:CGRectMake(pwdImg.frame.origin.x+50, pwdImg.frame.origin.y-10, UIScreenWidth*0.6, 50)];
    [pwdName setValue:COLOR(178, 178, 181, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [pwdName setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    pwdName.textAlignment = NSTextAlignmentCenter;
    pwdName.attributedPlaceholder = attributedStr;
    pwdName.textColor = [UIColor whiteColor];
    pwdName.secureTextEntry = YES;
    [self.view addSubview:pwdName ];
    
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(pwdImgBG.frame.origin.x, pwdImgBG.frame.origin.y+50, pwdImgBG.frame.size.width, 35)];
//    btn.backgroundColor = [UIColor colorWithRed:0.8 green:0.5 blue:0.6 alpha:0.6];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
//    [btn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview: btn];
    
    UILabel* noEnter = [[UILabel alloc]initWithFrame:CGRectMake(UIScreenWidth/2+100, btn.frame.origin.y+btn.frame.size.height+10, 100, 40)];
    noEnter.text = @"无法登陆？";
//    noEnter.font = [UIFont systemFontOfSize:13];
    noEnter.font = [UIFont boldSystemFontOfSize:13];
    noEnter.textColor = COLOR(178, 178, 181, 1);
    [self.view addSubview:noEnter];
    
    UIButton* reginBtn = [[UIButton alloc]initWithFrame:CGRectMake(UIScreenWidth/2-20, btn.frame.origin.y+btn.frame.size.height+110, 55, 22)];
    [reginBtn setImage:[UIImage imageNamed:@"zhuce.png"] forState:UIControlStateNormal];
    [reginBtn addTarget:self action:@selector(zhuCe:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reginBtn];
    
    /*
    
    
    
//    UIImageView* passwordImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, UIScreenHeight/6,50, 50)];
//    userImg.image = [UIImage imageNamed:@"2.png"];
//    [self.view addSubview:passwordImg];
    */
}

-(void)click:(id)sender{

//    if ([self login]) {
        TabBarViewController  *tabBar = [[TabBarViewController alloc]init];
        [self presentModalViewController:tabBar animated:YES];
        NSLog(@"click...");
        
        
//    }
}

-(BOOL)login{
    NSDictionary* infoDic = [[ServerConnect sharedManager]loginOfName:userName.text ToPwd:pwdName.text];

    if ([[infoDic objectForKey:@"result"] integerValue]==0) {
        NSLog(@"you are right.");
        return YES;
    }else{
        NSLog(@"you are wrong");
        XWAlterview *alter=[[XWAlterview alloc]initWithTitle:@"" contentText:[infoDic objectForKey:@"data"] leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
        alter.leftBlock=^()
        {
            NSLog(@"左边按钮被点击");
        };
        alter.dismissBlock=^()
        {
            NSLog(@"窗口即将消失");
        };
        
        [alter show];
        NSLog(@"the test no");
        return NO;
    }

    return YES;
}

-(void)zhuCe:(id)sender{
    ZhuCeViewController  *zhuCe = [[ZhuCeViewController alloc]init];
    [self presentModalViewController:zhuCe animated:YES];
    NSLog(@"click...");
    
//    对应消除方法
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"exit.");
//    }];
//
}

//取消 textFiled 键盘   （点击任意处键盘消失。）

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //当textField不再是第一监听者时键盘关闭
    [userName resignFirstResponder];
    [pwdName resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
