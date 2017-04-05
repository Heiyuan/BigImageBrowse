//
//  BrowseImageModel.h
//  BigImageBrowse
//
//  Created by Dayuan on 2017/3/31.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ModelDatasource) {
    SourceSmallImageView,
};

@interface BrowseImageModel : NSObject
@property (nonatomic,weak) UIImage *image;
@property (nonatomic,assign,readonly) CGRect smallRect;
@property (nonatomic,assign,readonly) ModelDatasource source;
@property (nonatomic,weak) UIImageView *smallImageView;
@end


@interface BrowseImageModel ()


/**
 init
 There will not be holding the imageView In order to obtain the current image and position
 @param imageView smallImageView
 @return model
 */
- (instancetype)initWithImageView:(UIImageView *)imageView;


@end
