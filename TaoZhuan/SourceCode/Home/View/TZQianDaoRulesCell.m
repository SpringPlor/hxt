//
//  TZQianDaoRulesCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZQianDaoRulesCell.h"

@implementation TZQianDaoRulesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        
//        self.ruleImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"jifenguiz"]];
//        [self.contentView addSubview:self.ruleImageView];
//        [self.ruleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.equalTo(self.contentView);
//            make.center.equalTo(self.contentView);
//        }];
        
        self.titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"签到积分规则" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.titleLabel.numberOfLines = 0;
        
        self.rule1Label = [MYBaseView labelWithFrame:CGRectZero text:@"1.每次签到可获得5积分，连续签到6天，第7天开始可以获得双倍积分" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.rule1Label];
        [self.rule1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
            make.left.equalTo(self.contentView).offset(15);
            make.centerX.equalTo(self.contentView);
        }];
        self.rule1Label.numberOfLines = 0;
        
        self.rule2Label = [MYBaseView labelWithFrame:CGRectZero text:@"2.如中途签到中断，则连续签到天数从下次开始签到时算起" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.rule2Label];
        [self.rule2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rule1Label.mas_bottom).offset(10);
            make.left.equalTo(self.rule1Label);
            make.centerX.equalTo(self.contentView);
        }];
        self.rule2Label.numberOfLines = 0;

        self.rule3Label = [MYBaseView labelWithFrame:CGRectZero text:@"3.签到所得积分可以在积分商城中兑换商品" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.rule3Label];
        [self.rule3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rule2Label.mas_bottom).offset(10);
            make.left.equalTo(self.rule1Label);
            make.centerX.equalTo(self.contentView);
        }];
        self.rule3Label.numberOfLines = 0;
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
