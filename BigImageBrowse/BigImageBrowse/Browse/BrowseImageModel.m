//
//  BrowseImageModel.m
//  BigImageBrowse
//
//  Created by Dayuan on 2017/3/31.
//  Copyright © 2017年 Dayuan. All rights reserved.
//


#import "BrowseImageModel.h"
#import "BrowseDefault.h"


@interface BrowseImageModel ()

@end

@implementation BrowseImageModel
- (instancetype)initWithImageView:(UIImageView *)imageView
{
    self = [super init];
    if (self) {
        NSAssert(imageView.image, @"init image is nil");
        _smallImageView = imageView;
        _source = SourceSmallImageView;
        _image = imageView.image;
        
        _smallRect = [imageView.superview convertRect:imageView.frame toView:imageView.window];
        
    }
    return self;
}



@end
