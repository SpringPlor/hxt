//
//  SearchItemCell.m
//  MaiYou
//
//  Created by bm on 2017/4/5.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#import "SearchItemCell.h"

@implementation SearchItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.height.mas_equalTo(28);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        self.nameLabel.clipsToBounds = YES;
        self.nameLabel.layer.cornerRadius = 12;
        self.nameLabel.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5" alpha:1.0];
        self.nameLabel.numberOfLines = 1;
    }
    return self;
}

- (void)setCellInfoWithModel:(SearchItemModel *)model{
    self.nameLabel.text = model.name;
}

- (CGFloat)cellItemWidth{
    CGSize size = [self.nameLabel.text sizeWithAttributes:@{NSFontAttributeName:kFont(12)}];
    return ceilf(size.width)+20;
}

@end
