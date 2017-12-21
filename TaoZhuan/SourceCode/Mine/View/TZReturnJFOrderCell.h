//
//  TZReturnJFOrderCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZReturnJfOrderModel.h"
#import "TZTaoYouOrderModel.h"

@interface TZReturnJFOrderCell : UITableViewCell

@property (nonatomic,strong) UILabel *orderNumber;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *typeLabel;
@property (nonatomic,strong) UILabel *orderStatusLabel;
@property (nonatomic,strong) UILabel *jfLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) TZOrderImageModel *model;

- (void)setCellInfoWithModel:(TZReturnJfOrderModel *)model;

@end
