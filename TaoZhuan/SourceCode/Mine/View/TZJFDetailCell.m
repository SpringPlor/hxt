//
//  TZJFDetailCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFDetailCell.h"

@implementation TZJFDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.typeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"购买商品" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.contentView addSubview:self.typeLabel];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(16);
        }];
        
        self.changeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"+18.00" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(18)];
        [self.contentView addSubview:self.changeLabel];
        [self.changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.typeLabel);
        }];
        self.changeLabel.attributedText = [NSString stringWithString:self.changeLabel.text Range:NSMakeRange(0, 1) color:nil font:kFont(13)];
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2017-10-06" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeLabel);
            make.top.equalTo(self.typeLabel.mas_bottom).offset(15);
        }];
        
        self.limitLabel = [MYBaseView labelWithFrame:CGRectZero text:@"16.00" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentRight andFont:kFont(13)];
        [self.contentView addSubview:self.limitLabel];
        [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.timeLabel);
        }];
    }
    return self;
}

- (void)setCellInfoWithModel:(TZJFDetailModel *)model{
    self.typeLabel.text = model.integralType;
    if (model.amount > 0) {
        self.changeLabel.text = [NSString stringWithFormat:@"+%.2f",model.amount];
    }else{
        self.changeLabel.text = [NSString stringWithFormat:@"%.2f",model.amount];
    }
    self.timeLabel.text = [[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)];
    self.limitLabel.text = model.remainAmount;
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
