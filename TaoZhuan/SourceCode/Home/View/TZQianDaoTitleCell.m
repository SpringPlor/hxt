//
//  TZQianDaoTitleCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZQianDaoTitleCell.h"

@implementation TZQianDaoTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        self.bgImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"qiandaobgtu"]];
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(210*kScale);
        }];
        self.bgImageView.userInteractionEnabled = YES;
        [self.bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qiandao:)]];
        
//        self.cycleImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"meiqiandao"]];;
//        [self.contentView addSubview:self.cycleImageView];
//        [self.cycleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.contentView);
//            make.top.equalTo(self.contentView).offset(29*kScale);
//            make.width.height.mas_equalTo(98);
//        }];
       
        
        self.qiandaoLabel = [MYBaseView labelWithFrame:CGRectZero text:@"签到" textColor:[UIColor colorWithHexString:@"#fe6a66" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.bgImageView addSubview:self.qiandaoLabel];
        [self.qiandaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgImageView);
            make.bottom.equalTo(self.bgImageView.mas_centerY).offset(-3);
        }];
        
        self.jifenLabel = [MYBaseView labelWithFrame:CGRectZero text:@"领积分" textColor:[UIColor colorWithHexString:@"#fe6a66" alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.bgImageView addSubview:self.jifenLabel];
        [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgImageView);
            make.top.equalTo(self.bgImageView.mas_centerY).offset(3);
        }];
        
        /*self.jfValueLabel = [MYBaseView labelWithFrame:CGRectZero text:@"30积分" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft andFont:kFont(21)];
        [self.contentView addSubview:self.jfValueLabel];
        [self.jfValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cycleImageView).offset(-10);
            make.top.equalTo(self.cycleImageView.mas_bottom).offset(20*kScale);
        }];
        self.jfValueLabel.attributedText = [NSString stringWithString:self.jfValueLabel.text Range:NSMakeRange(self.jifenLabel.text.length - 2, 2) color:nil font:kFont(12)];
        
        self.arrowImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"baiseqiantou"]];
        [self.contentView addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cycleImageView.mas_right).offset(10);
            make.centerY.equalTo(self.jfValueLabel.mas_centerY).offset(4);
        }];
        
        self.jfExchangeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"去兑换" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight andFont:kFont(12)];
        [self.contentView addSubview:self.jfExchangeLabel];
        [self.jfExchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.arrowImageView.mas_left).offset(-5);
            make.centerY.equalTo(self.arrowImageView);
        }];
        self.jfExchangeLabel.userInteractionEnabled = YES;
        [self.jfExchangeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exchangeJF:)]];
        
        self.jfDescribeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"（等值：1积分 = 1元钱）" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
        [self.contentView addSubview:self.jfDescribeLabel];
        [self.jfDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jfValueLabel.mas_bottom).offset(10);
            make.centerX.equalTo(self.bgImageView);
        }];*/
        
        CGFloat lineWidth = (SCREEN_WIDTH-100)/6;
        for (int i = 0 ; i < 6; i++){
            UIView *lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#fed2b2" alpha:1.0]];
            [self.contentView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(50+lineWidth*i);
                make.top.equalTo(self.bgImageView.mas_bottom).offset(24*kScale);
                make.width.mas_equalTo(lineWidth);
                make.height.mas_equalTo(1);
            }];
            lineView.tag = 100+i;
            
            UIView *pointView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#fed2b2" alpha:1.0]];
            [self.contentView addSubview:pointView];
            [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lineView);
                make.centerY.equalTo(lineView);
                make.width.height.mas_equalTo(9);
            }];
            pointView.layer.cornerRadius = 4.5;
            pointView.tag = 110+i;
            
            UILabel *dayLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
            [self.contentView addSubview:dayLabel];
            [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(pointView);
                make.top.equalTo(pointView.mas_bottom).offset(12);
            }];
            dayLabel.text = [NSString stringWithFormat:@"%d",i+1];
            
            if (i == 5) {
                UIView *pointView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#fed2b2" alpha:1.0]];
                [self.contentView addSubview:pointView];
                [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lineView.mas_right);
                    make.centerY.equalTo(lineView);
                    make.width.height.mas_equalTo(9);
                }];
                pointView.layer.cornerRadius = 4.5;
                pointView.tag = 110+i+1;
                
                UILabel *dayLabel = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
                [self.contentView addSubview:dayLabel];
                [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(pointView);
                    make.top.equalTo(pointView.mas_bottom).offset(12);
                }];
                dayLabel.text = [NSString stringWithFormat:@"%d",i+2];
            }
        }
        
        self.qdDescribeLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
        [self.contentView addSubview:self.qdDescribeLabel];
        [self.qdDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-18);
        }];
//        self.qdDescribeLabel.text = @"已连续签到3天，再签到4天就可以领取双倍积分啦";
//        self.qdDescribeLabel.attributedText = [NSString stringWithString:self.qdDescribeLabel.text Range:NSMakeRange(self.qdDescribeLabel.text.length-5, 2) color:[UIColor colorWithHexString:@"#fe6a00" alpha:1.0] font:kFont(13)];
        
    }
    return self;
}

- (void)setCellInfoWithUserInfoModel{
    if ([MYSingleton shareInstonce].userInfoModel.isSigninToday != nil && [[MYSingleton shareInstonce].userInfoModel.isSigninToday intValue] == 1) {
        self.bgImageView.image = [UIImage imageNamed:@"yiqiandaobgtu"];
        self.qiandaoLabel.text = @"今日";
        self.jifenLabel.text = @"已签到";
        self.bgImageView.userInteractionEnabled = NO;
    }
    
    NSString *keepSigninDays = [MYSingleton shareInstonce].userInfoModel.keepSigninDays;
    if (keepSigninDays == nil) {
        keepSigninDays = @"0";
    }
    self.qdDescribeLabel.text = [NSString stringWithFormat:@"已连续签到%@天，再签到%d天就可以获得超额奖励啦",keepSigninDays,(7 - [keepSigninDays intValue])] ;
    self.qdDescribeLabel.attributedText = [NSString stringWithString:self.qdDescribeLabel.text Range:NSMakeRange(self.qdDescribeLabel.text.length-5, 2) color:[UIColor colorWithHexString:@"#fe6a00" alpha:1.0] font:kFont(13)];
    for (int i = 0 ; i < 7; i++){
        UIView *lineView = [self viewWithTag:100+i];
        UIView *pointView = [self viewWithTag:110+i];
        if (i < [keepSigninDays intValue]) {
            pointView.backgroundColor = [UIColor colorWithHexString:@"#fe6a00" alpha:1.0];
            if (lineView != nil) {
                lineView.backgroundColor = [UIColor colorWithHexString:@"#fe6a00" alpha:1.0];
            }
        }else{
            pointView.backgroundColor = [UIColor colorWithHexString:@"#fed2b2" alpha:1.0];
            if (lineView != nil) {
                lineView.backgroundColor = [UIColor colorWithHexString:@"#fed2b2" alpha:1.0];
            }
        }
    }
    
    /*
    NSInteger integral = [MYSingleton shareInstonce].userInfoModel.integral;
    NSString *jfText = [NSString stringWithFormat:@"%ld积分",(long)integral];
    self.jfValueLabel.attributedText = [NSString stringWithString:jfText Range:NSMakeRange(jfText.length - 2, 2) color:nil font:kFont(12)];
    */
}

- (void)qiandao:(UITapGestureRecognizer *)sender{
    if (self.signInBlock) {
        self.signInBlock();
    }
}

- (void)exchangeJF:(UITapGestureRecognizer *)sender{
    if (self.jfBlock) {
        self.jfBlock();
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
