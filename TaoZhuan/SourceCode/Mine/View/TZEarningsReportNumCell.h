//
//  TZEarningsReportNumCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZEarningsReportTypeCell.h"
#import "TZAgentEarningReportModel.h"

@interface TZEarningsReportNumCell : TZEarningsReportTypeCell

- (void)setCellInfoWithIndex:(NSInteger)index model:(TZAgentEarningReportModel *)model;

@end
