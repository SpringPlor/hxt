//
//  TZKefuCourseCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZKefuCourseCell.h"

@implementation TZKefuCourseCell

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
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"关于惠享淘" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lineView);
            make.left.equalTo(self.lineView.mas_right).offset(10);
        }];
        
        self.contentLabel = [MYBaseView labelWithFrame:CGRectZero text:@"边淘边赚，一个专门找优惠券的省钱利器。我们与淘宝天猫商家合作，独家获取内部优惠券。在平台搜索任意商品，都可以获得高额优惠券进行购买" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.lineView.mas_bottom).offset(10);
        }];
        
        self.arrowButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"xiala"] selectImage:[UIImage imageNamed:@"shouqi"]];
        [self.contentView addSubview:self.arrowButton];
        [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView).offset(20);
            make.width.mas_equalTo(11);
            make.height.mas_equalTo(7);
        }];
        self.arrowButton.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
        [self.arrowButton addTarget:self action:@selector(spreadContent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)spreadContent:(UIButton *)sender{
    self.arrowButton.selected = !self.arrowButton.selected;
    if (self.spreadBlock) {
        self.spreadBlock(self.arrowButton.selected);
    }
}

- (void)setCellInfoWithModel:(TZKefuCourseModel *)model{
    self.nameLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.arrowButton.selected = model.isSpread;
    if (model.isSpread) {
        self.contentLabel.numberOfLines = 0;
        [self.arrowButton setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateNormal];
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
