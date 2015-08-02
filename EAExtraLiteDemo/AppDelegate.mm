//
//  AppDelegate.mm
//  EAExtraLiteDemo
//
//  Created by easycoding on 15/8/2.
//  Copyright (c) 2015年 easycoding. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "EADebugWindow.h"

@implementation AppDelegate

-(void)enableSkinDebug
{
    EADebugWindow* debugWin = [EADebugWindow createDebugWindow];
    
    debugWin.hidden = NO;
    
#if TARGET_IPHONE_SIMULATOR
    [debugWin setSkinPath:@"Resources" absolutePath:__FILE__];
#endif
    
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewController alloc] initWithNibName:nil bundle:nil];
    [self.window makeKeyAndVisible];
    
#if DEBUG
    //DEBUG 时，显示在顶部的控制菜单
    //刷一下， 可以进行一次刷新
    //自动刷新 每隔一秒进行一次自动刷新
    [self enableSkinDebug];
#endif
    
    return YES;
}

@end
