//
//  ObtainViewController.h
//  BigImageBrowse
//
//  Created by 刘志远 on 2017/4/6.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ObtainViewController : NSObject
+ (UIViewController *)getCurrentVC;
+ (BOOL)NavigationControllerShow;
+ (BOOL)tabbarControllerShow;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC;
@end
