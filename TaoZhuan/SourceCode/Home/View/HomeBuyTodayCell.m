//
//  HomeBuyTodayCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeBuyTodayCell.h"

@implementation HomeBuyTodayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        
        UIView *garyView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15) backgroundColor:[UIColor colorWithHexString:TZ_TableView_Color alpha:1.0]];
        [self.contentView addSubview:garyView];
        
        self.packageImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"jinri"]];
        [self.contentView addSubview:self.packageImageView];
        [self.packageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(27);
            make.width.mas_equalTo(12);
            make.height.mas_equalTo(14);
        }];
        
        UIView *shadowView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5) backgroundColor:[UIColor colorWithHexString:@"#e4e4e4" alpha:1.0]];
        [self.contentView addSubview:shadowView];
        
        self.todayBuyLabel = [MYBaseView labelWithFrame:CGRectZero text:@"今日必抢" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.todayBuyLabel];
        [self.todayBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.packageImageView.mas_right).offset(2);
            make.centerY.equalTo(self.packageImageView);
        }];
        
        self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"(早10点晚8点更新)" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.todayBuyLabel.mas_right).offset(2);
            make.centerY.equalTo(self.packageImageView);
        }];
        
        self.todayImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"baokuan"]];
        [self.contentView addSubview:self.todayImageView];
        [self.todayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-12);
        }];
        self.todayImageView.userInteractionEnabled = YES;
        [self.todayImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(todayBuy:)]];
        
        /*
        self.hLabel = [MYBaseView labelWithFrame:CGRectZero text:@"03" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
        [self.contentView addSubview:self.hLabel];
        [self.hLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.centerY.equalTo(self.todayBuyLabel);
            make.left.equalTo(self.todayBuyLabel.mas_right).offset(5);
        }];
        self.hLabel.backgroundColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
        self.hLabel.layer.cornerRadius = 2;
        self.hLabel.clipsToBounds = YES;
        
        UILabel *mhLabel1 = [MYBaseView labelWithFrame:CGRectZero text:@":" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.contentView addSubview:mhLabel1];
        [mhLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hLabel.mas_right).offset(2);
            make.centerY.equalTo(self.hLabel);
        }];
        
        self.mLabel = [MYBaseView labelWithFrame:CGRectZero text:@"24" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
        [self.contentView addSubview:self.mLabel];
        [self.mLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.centerY.equalTo(self.todayBuyLabel);
            make.left.equalTo(mhLabel1.mas_right).offset(2);
        }];
        self.mLabel.backgroundColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
        self.mLabel.layer.cornerRadius = 2;
        self.mLabel.clipsToBounds = YES;
        
        UILabel *mhLabel2 = [MYBaseView labelWithFrame:CGRectZero text:@":" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.contentView addSubview:mhLabel2];
        [mhLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mLabel.mas_right).offset(2);
            make.centerY.equalTo(self.hLabel);
        }];
        
        self.sLabel = [MYBaseView labelWithFrame:CGRectZero text:@"36" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
        [self.contentView addSubview:self.sLabel];
        [self.sLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(17);
            make.height.mas_equalTo(14);
            make.centerY.equalTo(self.todayBuyLabel);
            make.left.equalTo(mhLabel2.mas_right).offset(2);
        }];
        self.sLabel.backgroundColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0];
        self.sLabel.layer.cornerRadius = 2;
        self.sLabel.clipsToBounds = YES;
        */
    }
    return self;
}

- (void)todayBuy:(UITapGestureRecognizer *)sender{
    if (self.tapBlock) {
        self.tapBlock();
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
