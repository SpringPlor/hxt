//
//  TZEarningsReportNumCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZEarningsReportNumCell.h"

@implementation TZEarningsReportNumCell

- (void)setCellInfoWithIndex:(NSInteger)index model:(TZAgentEarningReportModel *)model{
    switch (index) {
        case 0:{
            self.label1.text = [NSString stringWithFormat:@"%.2f",model.monthTotalBalance];
            self.label2.text = [NSString stringWithFormat:@"%.2f",model.monthSelfBalance];
            self.label3.text = [NSString stringWithFormat:@"%.2f",model.monthFirstLevelBalance];
            self.label4.text = [NSString stringWithFormat:@"%.2f",model.monthSecondLevelBalance];
        }
            break;
        case 1:{
            self.label1.text = [NSString stringWithFormat:@"%.2f",model.lastMonthTotalBalance];
            self.label2.text = [NSString stringWithFormat:@"%.2f",model.lastMonthSelfBalance];
            self.label3.text = [NSString stringWithFormat:@"%.2f",model.lastMonthFirstLevelBalance];
            self.label4.text = [NSString stringWithFormat:@"%.2f",model.lastMonthSecondLevelBalance];
        }
            break;
        case 2:{
            self.label1.text = [NSString stringWithFormat:@"%.2f",model.monthTotalBudget];
            self.label2.text = [NSString stringWithFormat:@"%.2f",model.monthSelfBudget];
            self.label3.text = [NSString stringWithFormat:@"%.2f",model.monthFirstLevelBudget];
            self.label4.text = [NSString stringWithFormat:@"%.2f",model.monthSecondLevelBudget];
        }
            break;
        case 3:{
            self.label1.text = [NSString stringWithFormat:@"%.2f",model.yesterdayTotalBudget];
            self.label2.text = [NSString stringWithFormat:@"%.2f",model.yesterdaySelfBudget];
            self.label3.text = [NSString stringWithFormat:@"%.2f",model.yesterdayFirstLevelBudget];
            self.label4.text = [NSString stringWithFormat:@"%.2f",model.yesterdaySecondLevelBudget];
        }
            break;
        case 4:{
            self.label1.text = [NSString stringWithFormat:@"%.2f",model.todayTotalBudget];
            self.label2.text = [NSString stringWithFormat:@"%.2f",model.todaySelfBudget];
            self.label3.text = [NSString stringWithFormat:@"%.2f",model.todayFirstLevelBudget];
            self.label4.text = [NSString stringWithFormat:@"%.2f",model.todaySecondLevelBudget];
        }
            break;
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
