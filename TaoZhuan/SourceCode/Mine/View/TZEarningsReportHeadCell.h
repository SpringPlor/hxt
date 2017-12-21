//
//  TZEarningsReportHeadCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZAgentEarningReportModel.h"
#import "TZAgentEarningReportModel.h"

@interface TZEarningsReportHeadCell : UITableViewCell

@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *infoLabel;

- (void)setCellInfoWithIndex:(NSInteger)index model:(TZAgentEarningReportModel *)model;

@end
