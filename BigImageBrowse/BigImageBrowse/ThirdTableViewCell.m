//
//  ThirdTableViewCell.m
//  BigImageBrowse
//
//  Created by 刘志远 on 2017/4/6.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 90 , 90)];
        [self.contentView addSubview:_cellImageView];
        _cellImageView.image = [UIImage imageNamed:@"text1"];
        _cellImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [_cellImageView addGestureRecognizer:tap];
    }
    return self;
}
- (void)click:(UITapGestureRecognizer *)tap{
    [_delegate Cellclick:tap.view];
}
@end
