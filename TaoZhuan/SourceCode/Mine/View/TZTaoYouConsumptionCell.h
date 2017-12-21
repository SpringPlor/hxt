//
//  TZTaoYouConsumptionCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZTaoYouOrderModel.h"

@interface TZTaoYouConsumptionCell : UITableViewCell

@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *settlementLabel;
@property (nonatomic,strong) UILabel *consumptionLabel;

- (void)setCellInfoWithModel:(TZTaoYouOrderModel *)model;

@end
