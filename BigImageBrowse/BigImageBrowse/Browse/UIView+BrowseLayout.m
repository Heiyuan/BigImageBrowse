//
//  UIView+BrowseLayout.m
//  BigImageBrowse
//
//  Created by Dayuan on 2017/4/1.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "UIView+BrowseLayout.h"

@implementation UIView (BrowseLayout)
- (CGFloat)broLeft
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)broRight
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)broBottom
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)broTop
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)broHeight
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)broWidth
{
    return CGRectGetWidth(self.frame);
}

- (void)setbroX:(CGFloat)broX
{
    CGRect rect = self.frame;
    rect.origin.x = broX;
    self.frame = rect;
}

- (void)setbroY:(CGFloat)broY
{
    CGRect rect = self.frame;
    rect.origin.y = broY;
    self.frame = rect;
}

- (void)setbroWidth:(CGFloat)broWidth
{
    CGRect rect = self.frame;
    rect.size.width = broWidth;
    self.frame = rect;
}

- (void)setbroHeight:(CGFloat)broHeight
{
    CGRect rect = self.frame;
    rect.size.height = broHeight;
    self.frame = rect;
}

- (void)bro_setFrameInSuperViewCenterWithSize:(CGSize)size
{
    self.frame = CGRectMake((self.superview.broWidth - size.width) / 2, (self.superview.broHeight - size.height) / 2, size.width, size.height);
}

@end
