//
//  TZEarningsReportHeadCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZEarningsReportHeadCell.h"

@implementation TZEarningsReportHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeperatorInsetToZero];
        self.lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#d23639" alpha:1.0]];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(4);
            make.height.mas_equalTo(17);
        }];
        self.lineView.layer.cornerRadius = 2;
        
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"本月结算" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        self.infoLabel = [MYBaseView labelWithFrame:CGRectZero text:@"(本月已确认收货的订单收入)" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.contentView addSubview:self.infoLabel];
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setCellInfoWithIndex:(NSInteger)index model:(TZAgentEarningReportModel *)model{
    switch (index) {
        case 0:{
            self.lineView.backgroundColor = [UIColor colorWithHexString:@"#d23639" alpha:1.0];
            self.titleLabel.text = @"本月结算";
            self.infoLabel.text = @"(本月已确认收货的订单收入)";
        }
            break;
        case 1:{
            self.lineView.backgroundColor = [UIColor colorWithHexString:@"#c0a35e" alpha:1.0];
            self.titleLabel.text = @"上月结算";
            self.infoLabel.text = @"(上个月已确认收货的订单收入)";
        }
            break;
        case 2:{
            self.lineView.backgroundColor = [UIColor colorWithHexString:@"#d23639" alpha:1.0];
            self.titleLabel.text = [NSString stringWithFormat:@"本月预估（%ld单）",model.monthOrders];
            self.infoLabel.text = @"";
        }
            break;
        case 3:{
            self.lineView.backgroundColor = [UIColor colorWithHexString:@"#c0a35e" alpha:1.0];
            self.titleLabel.text = [NSString stringWithFormat:@"昨日预估（%ld单）",model.yesterdayOrders];
            self.infoLabel.text = @"";
        }
            break;
        case 4:{
            self.lineView.backgroundColor = [UIColor colorWithHexString:@"#1b5ec2" alpha:1.0];
            self.titleLabel.text = [NSString stringWithFormat:@"今日预估（%ld单）",model.todayOrders];
            self.infoLabel.text = @"";
        }
            break;
        default:
            break;
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
