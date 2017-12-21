//
//  TZJiFenRecommendCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJiFenRecommendCell.h"

@implementation TZJiFenRecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:0];
        self.iconImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"chaozhiduihuan"]];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(99);
        }];
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
