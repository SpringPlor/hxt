//
//  TZKefuQQCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZKefuQQCell.h"

@implementation TZKefuQQCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:0];
        
        self.lineView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0]];
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(15);
            make.width.mas_equalTo(2);
            make.height.mas_equalTo(15);
        }];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"客服 - 晶晶" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lineView);
            make.left.equalTo(self.lineView.mas_right).offset(10);
        }];
        
        self.QQLabel = [MYBaseView labelWithFrame:CGRectZero text:@"2956225663" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.QQLabel];
        [self.QQLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.lineView.mas_right).offset(10);
        }];
        
        self.QQButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"复制" titleColor:[UIColor colorWithHexString:@"#f33535" alpha:1.0] font:kFont(14)];
        [self.contentView addSubview:self.QQButton];
        [self.QQButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(27);
        }];
        self.QQButton.layer.cornerRadius = 5.0f;
        self.QQButton.layer.borderColor = [UIColor colorWithHexString:@"#f33535" alpha:1.0].CGColor;
        self.QQButton.layer.borderWidth = 1.0f;
        [self.QQButton addTarget:self action:@selector(copyQQ:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setCellInfoWithIndex:(NSInteger)index{
    if (index == 1) {
        self.nameLabel.text = @"客服——小惠（QQ)";
        self.QQLabel.text = @"783656843";
    }else{
        self.nameLabel.text = @"客服——小惠（微信)";
        self.QQLabel.text = @"huixiangtao2017";
    }
}

- (void)copyQQ:(UIButton *)sender{
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
    [[UIPasteboard generalPasteboard] setString:self.QQLabel.text];
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
