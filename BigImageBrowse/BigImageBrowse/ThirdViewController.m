//
//  ThirdViewController.m
//  BigImageBrowse
//
//  Created by 刘志远 on 2017/4/6.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "ThirdViewController.h"
#import "ThirdTableViewCell.h"
#import "Browse.h"
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,celldelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    return cell;
}
- (void)Cellclick:(UIImageView *)imageView{
    BrowseImageModel *model = [[BrowseImageModel alloc] initWithImageView:imageView];
    BrowseViewController *vc = [[BrowseViewController alloc] initWithimageModelArr:@[model]];
    [vc showBrowseViewController];
}

@end
