//
//  TZJFOrderCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZJFOrderModel.h"

@interface TZJFOrderCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *jfIcon;
@property (nonatomic,strong) UILabel *jfNumLabel;

- (void)setCellInfoWithModel:(TZJFOrderModel *)model;

@end
