//
//  TZEarningsReportTypeCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/4.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZEarningsReportTypeCell.h"

@interface TZEarningsReportTypeCell()

@property (nonatomic,copy) NSArray *array;

@end

@implementation TZEarningsReportTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSeperatorInsetToZero];
        CGFloat width = SCREEN_WIDTH/4;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7" alpha:1.0];
        for (int i = 0; i < 4; i++) {
            UILabel *label = [MYBaseView labelWithFrame:CGRectZero text:@"" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(width*i);
                make.top.equalTo(self.contentView);
                make.width.mas_equalTo(width);
                make.centerY.equalTo(self.contentView);
            }];
            label.tag = 100+i;
            
            UIView *line = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
            [label addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(label);
                make.width.mas_equalTo(0.5);
                make.centerY.equalTo(label);
            }];
            if (i == 3) {
                [line removeFromSuperview];
            }
            if (i == 0) {
                self.label1 = label;
            }
            if (i == 1) {
                self.label2 = label;
            }
            if (i == 2) {
                self.label3 = label;
            }
            if (i == 3) {
                self.label4 = label;
            }

        }
    }
    return self;
}

- (void)setCellInfoWithIndex:(NSInteger)index{
    NSArray *array1 = @[@"结算汇总",@"本人结算",@"一级结算",@"二级结算"];
    NSArray *array2 = @[@"汇总",@"本人预估",@"一级预估",@"二级预估"];
    if (index == 0 || index == 1) {
        self.array = array1;
    }else{
        self.array = array2;
    }
    for (int i = 0 ; i < 4; i ++) {
        UILabel *label = (UILabel *)[self viewWithTag:100+i];
        label.text = self.array[i];
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
