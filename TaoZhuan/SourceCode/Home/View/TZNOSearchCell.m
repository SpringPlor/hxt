//
//  TZNOSearchCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZNOSearchCell.h"

@implementation TZNOSearchCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.noImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"图标"]];
        [self.contentView addSubview:self.noImageView];
        [self.noImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.mas_equalTo(81);
            make.height.mas_equalTo(85);
        }];
        
        self.noLabel = [MYBaseView labelWithFrame:CGRectZero text:@"没有找到您要的商品！" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(16)];
        [self.contentView addSubview:self.noLabel];
        [self.noLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.noImageView.mas_bottom).offset(20);
            make.centerX.equalTo(self.contentView);
        }];
    }
    return self;
}

@end
