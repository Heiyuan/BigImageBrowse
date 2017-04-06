//
//  BrowseImageScrollView.h
//  BigImageBrowse
//
//  Created by Dayuan on 2017/4/1.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseImageScrollView : UIScrollView
@property (nonatomic,weak)  UITapGestureRecognizer *hiddtap;
@property (nonatomic,strong) UIImage *image;


@property (nonatomic,strong) UIImageView *imageView;

@end
