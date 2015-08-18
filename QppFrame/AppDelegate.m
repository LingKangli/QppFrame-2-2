//
//  AppDelegate.m
//  QppFrame
//
//  Created by LingKangLi on 15/6/18.
//  Copyright (c) 2015年 LingKangLi. All rights reserved.
//

#import "AppDelegate.h"
//main Controller
#import "ViewController.h"

//Tab Controller
#import "TabBarViewController.h"
#import "QppViewController.h"
#import "AddressBookViewController.h"
#import "FindViewController.h"
#import "MoreViewController.h"

//static AppDelegate* shareAppDel = nil;


@interface AppDelegate ()
@end

static AppDelegate *shareAppDel = nil;

@implementation AppDelegate
@synthesize tabBar;
/*

+ (AppDelegate *)sharedManager
{
    
//    static AppDelegate* sharedAppDelegate = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        if (self == nil) {
//            sharedAppDelegate = [[self alloc] init];
//        }
//    });
//    NSLog(@"aaaaa");
//    return sharedAppDelegate;
    
    if (shareAppDel == nil) {
        shareAppDel = [[super allocWithZone:NULL]init];
    }
    return shareAppDel;
}
*/


+(AppDelegate *)sharedManager{
    @synchronized (self){//为了确保多线程情况下，仍然确保实体的唯一性
        if (!shareAppDel) {
           shareAppDel = [[self alloc] init];//非ARC模式下,该方法会调用 allocWithZone
        }
        return shareAppDel;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    shareAppDel = [AppDelegate sharedManager];
//    1.创建Window
    shareAppDel.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
//    a.初始化一个tabBar控制器
//    tabBar = [[TabBarViewController alloc]init];
    
    ViewController* loginVC = [[ViewController alloc]init];

//    设置控制器为Window的根控制器
    self.window.rootViewController = loginVC;
    
//2.设置Window为主窗口并显示出来
    [shareAppDel.window makeKeyAndVisible];
    
    NSError* error1;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error1]; [session setActive:YES error:&error1];
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
