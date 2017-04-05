//
//  SecondViewController.m
//  BigImageBrowse
//
//  Created by Dayuan on 2017/3/31.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "SecondViewController.h"
#import "Browse.h"

@interface SecondViewController ()

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, -30, 180*1.3, 100*1.3)];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"text1"];
    //    imageView.center = self.view.center;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButton:)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)clickButton:(UITapGestureRecognizer *)tap{
    UIImageView *imageView = (UIImageView *)tap.view;
    
    BrowseImageModel *model = [[BrowseImageModel alloc] initWithImageView:imageView];
    
    
    
    BrowseViewController *vc = [[BrowseViewController alloc] initWithimageModelArr:@[model]];
    [vc showBrowseViewController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
