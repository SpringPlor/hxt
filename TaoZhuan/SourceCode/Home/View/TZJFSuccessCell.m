//
//  TZJFSuccessCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFSuccessCell.h"

@implementation TZJFSuccessCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = rGB_Color(240, 56, 60);
        
        self.successLabel = [MYBaseView labelWithFrame:CGRectZero text:@"恭喜您！兑换成功啦！" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
        [self.contentView addSubview:self.successLabel];
        [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(43);
            make.centerX.equalTo(self.contentView.mas_centerX).offset(30);
        }];
        
        self.iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"duihuancg"]];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.successLabel);
            make.right.equalTo(self.successLabel.mas_left).offset(-15);
        }];
        
        self.noticeLabel = [MYBaseView labelWithFrame:CGRectZero text:@"我们客服将会在24小时内联系您，谢谢！" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(13)];
        [self.contentView addSubview:self.noticeLabel];
        [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(50);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(25);
            make.centerX.equalTo(self.contentView);
        }];
        self.noticeLabel.numberOfLines = 0;
    }
    return self;
}

@end
