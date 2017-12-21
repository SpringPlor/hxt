//
//  TZYaoQingRulesCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZYaoQingRulesCell.h"

@implementation TZYaoQingRulesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"规则说明" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        
        self.rule1Label = [MYBaseView labelWithFrame:CGRectZero text:@"1.邀请10位好友成为淘友，即可免费申请成为代理人" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.rule1Label];
        [self.rule1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.rule1Label.numberOfLines = 0;

        self.rule2Label = [MYBaseView labelWithFrame:CGRectZero text:@"2.成为代理人后，淘友在惠享淘中领券购买商品，您还可以获得提成" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.rule2Label];
        [self.rule2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rule1Label.mas_bottom).offset(10);
            make.left.equalTo(self.rule1Label);
            make.centerX.equalTo(self.contentView);
        }];
        self.rule2Label.numberOfLines = 0;
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
