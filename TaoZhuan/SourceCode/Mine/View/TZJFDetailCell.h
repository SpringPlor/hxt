//
//  TZJFDetailCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZJFDetailModel.h"

@interface TZJFDetailCell : UITableViewCell

@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *limitLabel;
@property (nonatomic,strong) UILabel *changeLabel;

- (void)setCellInfoWithModel:(TZJFDetailModel *)model;

@end
