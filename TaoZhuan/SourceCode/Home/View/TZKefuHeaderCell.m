//
//  TZKefuHeaderCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZKefuHeaderCell.h"

@implementation TZKefuHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:0];
        
        self.iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"kefuqq"]];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(18);
        }];
        
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"客服QQ（处理异常订单、积分兑换礼品、提现问题）" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(15)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
        }];
        self.titleLabel.attributedText = [NSString stringWithString:self.titleLabel.text Range:NSMakeRange(4, self.titleLabel.text.length-4) color:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] font:kFont(12)];
    }
    return self;
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
