//
//  ObtainViewController.m
//  BigImageBrowse
//
//  Created by 刘志远 on 2017/4/6.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "ObtainViewController.h"

@implementation ObtainViewController
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
//判断当先导航控制器是否显示
+ (BOOL)NavigationControllerShow{
    UIViewController *viewControll = [self getCurrentVC];
    if (!viewControll.navigationController) {
        return NO;
    }
    if (viewControll.navigationController.navigationBarHidden) {
        return NO;
    }
    return YES;
}
//判断当前tab是否显示
+ (BOOL)tabbarControllerShow{
    UIViewController *viewControll = [self getCurrentVC];
    return !viewControll.hidesBottomBarWhenPushed;
}

@end
