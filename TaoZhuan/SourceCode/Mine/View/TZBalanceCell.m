//
//  TZBalanceCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZBalanceCell.h"

@implementation TZBalanceCell

- (void)setCellInfoWithModel:(TZBalanceModel *)model{
    self.typeLabel.text = model.moneyType;
    if (model.amount > 0) {
        self.changeLabel.text = [NSString stringWithFormat:@"+%.2f",model.amount];
    }else{
        self.changeLabel.text = [NSString stringWithFormat:@"%.2f",model.amount];
    }
    self.timeLabel.text = [[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)];
    self.limitLabel.text = model.remainAmount;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
