//
//  TZReturnJFOrderAuditCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/18.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZReturnJfOrderModel.h"

@interface TZReturnJFOrderAuditCell : UITableViewCell

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *tbLabel;
@property (nonatomic,strong) UILabel *orderLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *statusButton;

- (void)setCellInfoWithModel:(TZReturnJfOrderModel *)model;

@end
