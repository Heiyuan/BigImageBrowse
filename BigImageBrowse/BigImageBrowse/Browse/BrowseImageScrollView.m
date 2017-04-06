//
//  BrowseImageScrollView.m
//  BigImageBrowse
//
//  Created by Dayuan on 2017/4/1.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "BrowseImageScrollView.h"
#import "BrowseDefault.h"

@interface BrowseImageScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UITapGestureRecognizer *imageTap;
@end


@implementation BrowseImageScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.imageView.backgroundColor = [UIColor clearColor];
        {
            
            _imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
            [_imageTap setNumberOfTapsRequired:2];
            self.imageView.userInteractionEnabled = YES;
            [self.imageView addGestureRecognizer:_imageTap];
        }
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self addSubview:_imageView];
        self.delegate = self;
        
        // 设置最大缩放比例
        self.maximumZoomScale = 10.0;
        // 设置最小缩放比例
        self.minimumZoomScale = 1;
    }
    return self;
}
//获取点击消失手势 处理手势冲突
- (void)setHiddtap:(UITapGestureRecognizer *)hiddtap{
    _hiddtap = hiddtap;
    [hiddtap requireGestureRecognizerToFail:_imageTap];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // 延中心点缩放
    CGRect rect = _imageView.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    if (rect.size.width < self.broWidth) {
        rect.origin.x = floorf((self.broWidth - rect.size.width) / 2.0);
    }
    if (rect.size.height < self.broHeight) {
        rect.origin.y = floorf((self.broHeight - rect.size.height) / 2.0);
    }
    _imageView.frame = rect;
}
- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = _image;
    CGSize ksize = [self getImageViewInit:image];
    if (ksize.height > BROScreenH) {
        _imageView.frame = CGRectMake(0, 0, ksize.width, ksize.height);
    }else{
        _imageView.frame = CGRectMake(0, (BROScreenH  - ksize.height) /2.f, ksize.width, ksize.height);
    }
    self.contentSize = ksize;
    

}

- (void)clickImageView:(UITapGestureRecognizer *)tap{
    if (self.zoomScale < 1) {
        [self setZoomScale:1 animated:YES];
    }else if (self.zoomScale == 1){
        [self setZoomScale:5 animated:YES];
    }else{
        [self setZoomScale:1 animated:YES];
    }

}

- (CGSize )getImageViewInit:(UIImage *)image{
    CGSize imageSize = image.size;
    if (image.size.width >= self.bounds.size.width) {
        CGFloat height = self.bounds.size.width / imageSize.width   * imageSize.height;
        return CGSizeMake(self.bounds.size.width, height);
    }
    if (image.size.height >= self.bounds.size.height) {
        CGFloat width = imageSize.height / self.bounds.size.height  * imageSize.width;
        return CGSizeMake(width,self.bounds.size.height);
    }
    
    return imageSize;
}
@end
