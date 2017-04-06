//
//  ThirdTableViewCell.h
//  BigImageBrowse
//
//  Created by 刘志远 on 2017/4/6.
//  Copyright © 2017年 Dayuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol celldelegate <NSObject>

- (void)Cellclick:(UIImageView *)imageView;

@end


@interface ThirdTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *cellImageView;
@property (nonatomic,weak) id <celldelegate>delegate;
@end
