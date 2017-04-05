//
//  UIView+BrowseLayout.h
//  BigImageBrowse
//
//  Created by Dayuan on 2017/4/1.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BrowseLayout)
- (CGFloat)broLeft;
- (CGFloat)broRight;
- (CGFloat)broBottom;
- (CGFloat)broTop;
- (CGFloat)broHeight;
- (CGFloat)broWidth;

- (void)setbroX:(CGFloat)broX;
- (void)setbroY:(CGFloat)broY;
- (void)setbroWidth:(CGFloat)broWidth;
- (void)setbroHeight:(CGFloat)broHeight;

- (void)bro_setFrameInSuperViewCenterWithSize:(CGSize)size;
@end
