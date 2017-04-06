//
//  BrowseViewController.m
//  BigImageBrowse
//
//  Created by Dayuan on 2017/3/31.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "BrowseViewController.h"
#import "BrowseImageModel.h"
#import "BrowScroller.h"
#import "BrowseDefault.h"
#import "BrowseImageScrollView.h"

typedef void(^PositionReduction)();

@interface BrowseViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray <BrowseImageModel *> *imageModelArr;
@property (nonatomic,strong) UIView *snapshotView;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) BrowScroller *mainScroller;
/**< 辅助动画 */
@property (nonatomic,strong) UIImageView *mainImageView;
/**< 上个视图的image */
@property (nonatomic,strong) UIImageView *upVcImageView;
/**< 返回的图片位置 */
@property (nonatomic,assign) CGRect ReturnFrame;

@property (nonatomic,weak) BrowseImageModel *nowModel;
@property (nonatomic,copy) PositionReduction commectBlock;
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@end

@implementation BrowseViewController{
    NSInteger nowPicIndex;
}

- (void)dealloc{
    NSLog(@"内存没有泄露,图片浏览器释放了");
}

- (instancetype)initWithimageModelArr:(NSArray<BrowseImageModel *> *)imageModelArr{
    self = [super init];
    if (self) {
        nowPicIndex = 0;
        self.imageModelArr = imageModelArr;
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddself)];
        [self.view addGestureRecognizer:_tap];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    [self.view addSubview:_snapshotView];

    _shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_shadowView];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0;
    
    _mainScroller = [[BrowScroller alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mainScroller];
    _mainScroller.backgroundColor = [UIColor clearColor];
    _mainScroller.contentSize = CGSizeMake(BROScreenW * _imageModelArr.count, 0);
    _mainScroller.pagingEnabled = YES;
    _mainScroller.delegate = self;
    {
        for (NSInteger i = 0 ; i < _imageModelArr.count; i++) {
            BrowseImageScrollView *imageViewScroller = [[BrowseImageScrollView alloc] init];
            imageViewScroller.frame = CGRectMake(i * BROScreenW, 0, BROScreenW, BROScreenH);
            imageViewScroller.image = [_imageModelArr[i] image];
            imageViewScroller.hiddtap = _tap;
            imageViewScroller.tag = 1000 + i;
            [_mainScroller addSubview:imageViewScroller];
        }
    }
    _mainScroller.hidden = YES;
    [self.view addSubview:self.mainImageView];
    
}
//MARK:scrollerView 增加视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSInteger tap =  999 + (scrollView.contentOffset.x / BROScreenW);
    return [scrollView viewWithTag:tap];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
    [UIView animateWithDuration:.1 animations:^{
        _shadowView.alpha = 1;
    }];
    [_mainScroller setContentOffset:CGPointMake(nowPicIndex * BROScreenW, 0) animated:NO];
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGSize size = [self getImageViewInit:_mainImageView.image];
        _mainImageView.frame = CGRectMake(0, 0, size.width, size.height);
        _mainImageView.center = self.view.center;
    } completion:^(BOOL finished) {
        if (_mainImageView.broHeight > BROScreenH) {
            [UIView animateWithDuration:.2 animations:^{
                [_mainImageView setbroY:0];
            } completion:^(BOOL finished) {
                _mainImageView.hidden = YES;
                _mainScroller.hidden = NO;
            }];
        }else{
            _mainImageView.hidden = YES;
            _mainScroller.hidden = NO;
        }
    }];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _upVcImageView.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _upVcImageView.hidden = NO;
    _nowModel.smallImageView.userInteractionEnabled = YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setImageModelArr:(NSArray<BrowseImageModel *> *)imageModelArr{
    NSAssert(imageModelArr.count, @"imageModelArrCount is zero");
    _imageModelArr = imageModelArr;
    self.nowModel = [imageModelArr objectAtIndex:nowPicIndex];;
}
- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] init];
    }
    return _mainImageView;
}
- (void)setNowModel:(BrowseImageModel *)nowModel{
    _nowModel = nowModel;
    self.mainImageView.frame = _nowModel.smallRect;
    self.mainImageView.clipsToBounds = _nowModel.smallImageView.clipsToBounds;
    self.mainImageView.contentMode = _nowModel.smallImageView.contentMode;
    _ReturnFrame = _nowModel.smallRect;
    self.mainImageView.image = _nowModel.image;
}
- (void)showBrowseViewControllerIndex:(NSInteger)index{
    nowPicIndex = index;
    self.nowModel = [_imageModelArr objectAtIndex:nowPicIndex];;
    NSAssert((index < _imageModelArr.count), @"Jump wrong");
    [self showBrowseViewController];
}

- (void)showBrowseViewController{
    _nowModel.smallImageView.userInteractionEnabled = NO;
    __weak __typeof(self)weakSelf = self;
    if (CGRectGetMinY(_nowModel.smallRect) < BROTopBarY && [ObtainViewController NavigationControllerShow]) {
        _commectBlock = ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            [UIView animateWithDuration:.2 animations:^{
                
                [weakSelf.upVcImageView setbroY:weakSelf.nowModel.smallRect.origin.y];
            } completion:^(BOOL finished) {
                [strongSelf.upVcImageView removeFromSuperview];
                strongSelf.nowModel.smallImageView.hidden = NO;
                strongSelf.upVcImageView  = nil;
            }];
        };
        _upVcImageView = [[UIImageView alloc] initWithFrame:_nowModel.smallRect];
        _upVcImageView.image = _nowModel.image;
        [[[ObtainViewController getCurrentVC] view] addSubview:_upVcImageView];
         [UIView animateWithDuration:.2 animations:^{
             
             [_upVcImageView setbroY:BROTopBarY];
         } completion:^(BOOL finished) {
             self.mainImageView.frame = _upVcImageView.frame;
             _ReturnFrame = _upVcImageView.frame;
             [self show];
         }];
        

        return;
    }
   
    
    if (CGRectGetMinY(_nowModel.smallRect) < 0) {
        _commectBlock = ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            [UIView animateWithDuration:.2 animations:^{
                
                [weakSelf.upVcImageView setbroY:weakSelf.nowModel.smallRect.origin.y];
            } completion:^(BOOL finished) {
                [strongSelf.upVcImageView removeFromSuperview];
                strongSelf.nowModel.smallImageView.hidden = NO;
                strongSelf.upVcImageView  = nil;
            }];
        };
        _upVcImageView = [[UIImageView alloc] initWithFrame:_nowModel.smallRect];
        _upVcImageView.image = _nowModel.image;
        [[[ObtainViewController getCurrentVC] view] addSubview:_upVcImageView];
        [UIView animateWithDuration:.2 animations:^{
            
            [_upVcImageView setbroY:0];
        } completion:^(BOOL finished) {
            self.mainImageView.frame = _upVcImageView.frame;
            _ReturnFrame = _upVcImageView.frame;
            [self show];
        }];
        
        
        return;
    }

    
    
    
    if (CGRectGetMaxY(_nowModel.smallRect) > BROTabBarY && [ObtainViewController tabbarControllerShow]) {

        _commectBlock = ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [UIView animateWithDuration:.2 animations:^{
                
                [weakSelf.upVcImageView setbroY:weakSelf.nowModel.smallRect.origin.y];
            } completion:^(BOOL finished) {
                [strongSelf.upVcImageView removeFromSuperview];
                strongSelf.nowModel.smallImageView.hidden = NO;
                strongSelf.upVcImageView  = nil;
            }];
        };
        _upVcImageView = [[UIImageView alloc] initWithFrame:_nowModel.smallRect];
        _upVcImageView.image = _nowModel.image;
        [[[ObtainViewController getCurrentVC] view] addSubview:_upVcImageView];
        [UIView animateWithDuration:.2 animations:^{
            
            [_upVcImageView setbroY:(BROTabBarY - _upVcImageView.broHeight)];
        } completion:^(BOOL finished) {
            self.mainImageView.frame = _upVcImageView.frame;
            _ReturnFrame = _upVcImageView.frame;
            [self show];
        }];
        
        return;

        
    }
    
    
    
    if (CGRectGetMaxY(_nowModel.smallRect) > BROScreenH ) {
        
        _commectBlock = ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [UIView animateWithDuration:.2 animations:^{
                
                [weakSelf.upVcImageView setbroY:weakSelf.nowModel.smallRect.origin.y];
            } completion:^(BOOL finished) {
                [strongSelf.upVcImageView removeFromSuperview];
                strongSelf.nowModel.smallImageView.hidden = NO;
                strongSelf.upVcImageView  = nil;
            }];
        };
        _upVcImageView = [[UIImageView alloc] initWithFrame:_nowModel.smallRect];
        _upVcImageView.image = _nowModel.image;
        [[[ObtainViewController getCurrentVC] view] addSubview:_upVcImageView];
        [UIView animateWithDuration:.2 animations:^{
            
            [_upVcImageView setbroY:(BROScreenH - _upVcImageView.broHeight)];
        } completion:^(BOOL finished) {
            self.mainImageView.frame = _upVcImageView.frame;
            _ReturnFrame = _upVcImageView.frame;
            [self show];
        }];
        
        return;
        
        
    }

    
    _commectBlock = ^{
        weakSelf.nowModel.smallImageView.hidden = NO;
    };
    [self show];

}
//MARK:show & hidd

- (void)show{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
    {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    else
    {
        _snapshotView = [rootViewController.view snapshotViewAfterScreenUpdates:YES];
    }
    [rootViewController presentViewController:self animated:NO completion:^{
        _nowModel.smallImageView.hidden = YES;

    }];
}

- (void)hiddself{

    [UIView animateWithDuration:.2 delay:.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _shadowView.alpha = 0;

        
    } completion:nil];
    __weak __typeof(self)weakSelf = self;
    _mainImageView.hidden = NO;
    _mainScroller.hidden = YES;
    [UIView animateWithDuration:.4 animations:^{
        _mainImageView.frame = _ReturnFrame;

    } completion:^(BOOL finished) {
        [weakSelf dismissViewControllerAnimated:NO completion:_commectBlock?_commectBlock:nil];
    }];
}



//MARK:init size
- (CGSize )getImageViewInit:(UIImage *)image{
    CGSize imageSize = image.size;
    if (image.size.width >= self.view.bounds.size.width) {
        CGFloat height = self.view.bounds.size.width / imageSize.width   * imageSize.height;
        return CGSizeMake(self.view.bounds.size.width, height);
    }
    if (image.size.height >= self.view.bounds.size.height) {
        CGFloat width = imageSize.height / self.view.bounds.size.height  * imageSize.width;
        return CGSizeMake(width,self.view.bounds.size.height);
    }

    return imageSize;
}


//MARK:scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / BROScreenW;
    NSLog(@"%ld",index);
    self.nowModel.smallImageView.hidden = NO;
    self.nowModel.smallImageView.userInteractionEnabled = YES;
    self.nowModel = [_imageModelArr objectAtIndex:index];
    self.nowModel.smallImageView.hidden = YES;
    _ReturnFrame = _nowModel.smallRect;
    BrowseImageScrollView *imageScroller = [scrollView viewWithTag:1000 + index];
    _mainImageView.frame = imageScroller.imageView.frame;
    _upVcImageView.image = self.nowModel.image;
    __weak __typeof(self)weakSelf = self;
    
    
    self.upVcImageView.hidden = YES;
    _commectBlock = ^{
        //此处欠处理/
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.nowModel.smallImageView.hidden = NO;
        [strongSelf.upVcImageView removeFromSuperview];
 
    };
}


@end
