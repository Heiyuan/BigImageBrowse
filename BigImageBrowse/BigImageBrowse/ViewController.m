//
//  ViewController.m
//  BigImageBrowse
//
//  Created by Dayuan on 2017/3/31.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "ViewController.h"
#import "Browse.h"
#import "BrowseImageViewController.h"
#import "BrowseDefault.h"

@interface ViewController ()
@property (nonatomic,strong) UIImageView *imgageView_2;
@property (nonatomic,strong) UIImageView *imgageView_3;
@property (nonatomic,strong) UIImageView *imgageView_4;
@property (nonatomic,strong) UIImageView *imageView ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 180*1.3, 100*1.3)];
    [self.view addSubview:_imageView];
    _imageView.image = [UIImage imageNamed:@"text1"];
    _imageView.tag = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButton:)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tap];
    
    
    _imgageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _imageView.broBottom + 10, 180*1.3, 100)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButton:)];
    _imgageView_2.userInteractionEnabled = YES;
    [_imgageView_2 addGestureRecognizer:tap1];
    _imgageView_3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _imgageView_2.broBottom + 10, 180*1.3, 100)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButton:)];
    _imgageView_3.userInteractionEnabled = YES;
    [_imgageView_3 addGestureRecognizer:tap2];
    _imgageView_4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, _imgageView_3.broBottom + 10, 180*1.3, 100)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButton:)];
    _imgageView_4.userInteractionEnabled = YES;
    [_imgageView_4 addGestureRecognizer:tap3];
    _imgageView_2.contentMode = 2;
    _imgageView_3.contentMode = 2;
    _imgageView_4.contentMode = 2;
    _imgageView_2.image = [UIImage imageNamed:@"text2"];
    _imgageView_3.image = [UIImage imageNamed:@"text3"];
    _imgageView_4.image = [UIImage imageNamed:@"text4"];
    _imgageView_2.clipsToBounds = YES;
    _imgageView_3.clipsToBounds = YES;
    _imgageView_4.clipsToBounds = YES;
    [self.view addSubview:_imgageView_2];
    [self.view addSubview:_imgageView_3];
    [self.view addSubview:_imgageView_4];

    _imgageView_2.tag = 1;
    _imgageView_3.tag = 2;
    _imgageView_4.tag = 3;

//

}
- (void)clickpushScrentVc{
    BrowseImageViewController *vc = [[BrowseImageViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)clickButton:(UITapGestureRecognizer *)tap{

    BrowseImageModel *model = [[BrowseImageModel alloc] initWithImageView:_imageView];
    BrowseImageModel *model1 = [[BrowseImageModel alloc] initWithImageView:_imgageView_2];
    BrowseImageModel *model2 = [[BrowseImageModel alloc] initWithImageView:_imgageView_3];
    BrowseImageModel *model3 = [[BrowseImageModel alloc] initWithImageView:_imgageView_4];
    BrowseViewController *vc = [[BrowseViewController alloc] initWithimageModelArr:@[model,model1,model2,model3]];
    
    [vc showBrowseViewControllerIndex:tap.view.tag];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
