//
//  BrowseViewController.h
//  BigImageBrowse
//
//  Created by Dayuan on 2017/3/31.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrowseImageModel;
@interface BrowseViewController : UIViewController

- (instancetype)initWithimageModelArr:(NSArray <BrowseImageModel *> *)imageModelArr;

- (void)showBrowseViewController;

- (void)showBrowseViewControllerIndex:(NSInteger)index;

@end
