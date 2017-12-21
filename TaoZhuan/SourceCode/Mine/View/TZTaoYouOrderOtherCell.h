//
//  TZTaoYouOrderOtherCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZTaoYouOrderModel.h"

@interface TZTaoYouOrderOtherCell : UITableViewCell

@property (nonatomic,strong) UILabel *settlementLabel;
@property (nonatomic,strong) UILabel *consumptionLabel;

- (void)setCellInfoWithModel:(TZTaoYouOrderModel *)model;

@end
