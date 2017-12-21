//
//  TZReturnJFOrderAuditCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/18.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZReturnJFOrderAuditCell.h"

@implementation TZReturnJFOrderAuditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"headshenhezhong"]];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(15);
            make.width.height.mas_equalTo(50);
        }];
        
        self.tbLabel = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝网" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.tbLabel];
        [self.tbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(15);
        }];
        
        self.orderLabel = [MYBaseView labelWithFrame:CGRectZero text:@"订单号： 123456789010" textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.orderLabel];
        [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
        }];
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2017-10-17" textColor:[UIColor colorWithHexString:@"#666666" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        
        self.statusButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"审核中" titleColor:[UIColor colorWithHexString:@"#fcb545" alpha:1.0] font:kFont(13)];
        [self.contentView addSubview:self.statusButton];
        [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(65);
            make.height.mas_equalTo(25);
        }];
        self.statusButton.layer.cornerRadius = 12.5;
        self.statusButton.layer.borderColor = [UIColor colorWithHexString:@"#fcb545" alpha:1.0].CGColor;
        self.statusButton.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)setCellInfoWithModel:(TZReturnJfOrderModel *)model{
    self.orderLabel.text = [NSString stringWithFormat:@"订单号： %@",model.tbOrderId];
    self.timeLabel.text = [[ZMUtils timeWithTimeIntervalString:model.creationTime] substringWithRange:NSMakeRange(0, 10)];
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
