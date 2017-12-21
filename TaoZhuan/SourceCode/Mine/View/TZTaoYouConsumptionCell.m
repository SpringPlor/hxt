//
//  TZTaoYouConsumptionCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZTaoYouConsumptionCell.h"

@implementation TZTaoYouConsumptionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(11*kScale)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15*kScale);
            make.top.equalTo(self.contentView).offset(12*kScale);
        }];
        
        self.settlementLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(12*kScale)];
        [self.contentView addSubview:self.settlementLabel];
        [self.settlementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15*kScale);
            make.width.mas_equalTo(95*kScale);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12*kScale);
        }];
        
        self.consumptionLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(12*kScale)];
        [self.contentView addSubview:self.consumptionLabel];
        [self.consumptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.settlementLabel.mas_left);
            make.width.mas_equalTo(95*kScale);
            make.centerY.equalTo(self.settlementLabel);
        }];

    }
    return self;
}

- (void)setCellInfoWithModel:(TZTaoYouOrderModel *)model{
    if ([model.status isEqualToString:@"订单付款"]) {//预估
        self.settlementLabel.textColor = [UIColor colorWithHexString:@"#17a2ea" alpha:1.0];
        self.settlementLabel.text = [NSString stringWithFormat:@"预估 ¥%.2f",model.resultEvaluation];
        self.consumptionLabel.text = [NSString stringWithFormat:@"消费 ¥%.2f",model.payAmount];
    }else if ([model.status isEqualToString:@"订单结算"]){//结算
        self.settlementLabel.textColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0];
        self.settlementLabel.text = [NSString stringWithFormat:@"结算 ¥%.2f",model.resultEvaluation];
        self.consumptionLabel.text = [NSString stringWithFormat:@"消费 ¥%.2f",model.payAmount];
        self.timeLabel.text = [NSString stringWithFormat:@"%@结算",[[ZMUtils timeWithTimeIntervalString:model.checkDate] substringWithRange:NSMakeRange(0, 10)]];
        [self.settlementLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-12*kScale);
        }];
    }else if ([model.status isEqualToString:@"订单失效"]){//失效
        self.settlementLabel.textColor = [UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0];
        self.settlementLabel.text = @"已失效";
        self.consumptionLabel.text = @"消费0";
    }else{
        self.settlementLabel.textColor = [UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0];
        self.settlementLabel.text = @"已失效";
        self.consumptionLabel.text = [NSString stringWithFormat:@"消费 ¥%.2f",model.payAmount];
    }    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
