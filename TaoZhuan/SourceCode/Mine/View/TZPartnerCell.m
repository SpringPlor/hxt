//
//  TZPartnerCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZPartnerCell.h"

@implementation TZPartnerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.headImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(33);
        }];
        self.headImageView.backgroundColor = [UIColor lightGrayColor];
        self.headImageView.layer.cornerRadius = 16.5;
        
        self.phoneLabel = [MYBaseView labelWithFrame:CGRectZero text:@"123456" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.contentView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(5);
            make.centerY.equalTo(self.contentView);
        }];
        
        /*
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2017-12-4" textColor:[UIColor colorWithHexString:TZ_LIGHT_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(9)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImageView.mas_right).offset(5);
            make.top.equalTo(self.contentView.mas_centerY).offset(3.5);
        }];
        */
        
        self.moneyLabel = [MYBaseView labelWithFrame:CGRectZero text:@"+10086" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.moneyLabel];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(SCREEN_WIDTH/4-28);
            make.centerY.equalTo(self.contentView);
        }];

    }
    return self;
}

- (void)setCellInfoWithModel:(TZPartnerModel *)model{
    self.phoneLabel.text = model.account;
    //self.timeLabel.text = [model.creationTime substringWithRange:NSMakeRange(0, 10)];//[[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",model.price];
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
