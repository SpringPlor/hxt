//
//  TZMineIntegralCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineIntegralCell.h"

@implementation TZMineIntegralCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.integralModule = [[TZMineModuleView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 138) title:@"我的积分" iconArray:@[@"jifenmingxi",@"shangc",@"jifendingdan"] itemTitle:@[@"积分明细",@"积分兑换商城",@"积分兑换订单"]];
        self.integralModule.redView.image = [UIImage imageNamed:@"jifenbiaoti"];
        [self.contentView  addSubview:self.integralModule];
        self.integralModule.layer.cornerRadius = 5;
        WeakSelf(self);
        [self.integralModule setTapItemBlock:^(NSInteger index) {
            if (weakSelf.tapBlock) {
                weakSelf.tapBlock(index);
            }
        }];
        [self.integralModule setTapItemBlock:^(NSInteger index) {
            if (weakSelf.tapBlock) {
                weakSelf.tapBlock(index);
            }
        }];
        /*[self.integralModule setTapItemBlock:^(NSInteger index){
            if (![weakSelf judgeLogin]) {
                [weakSelf loginActionWithTarget:weakSelf];
                return ;
            }
            if (index == 0) {
                [MobClick event:jifenchakan];
                TZJFDetailViewController *jfDetailVC = [[TZJFDetailViewController alloc] init];
                [weakSelf.navigationController pushViewController:jfDetailVC animated:YES];
            }
            if (index == 1) {
                [MobClick event:jifenduihshangcheng];
                TZReturnJFExchangeViewController *jifenVC = [[TZReturnJFExchangeViewController alloc] init];
                [weakSelf.navigationController pushViewController:jifenVC animated:YES];
            }
            if (index == 2) {
                [MobClick event:jifenduihuandingdan];
                TZJFOrderViewController *jfOrderVC = [[TZJFOrderViewController alloc] init];
                [weakSelf.navigationController pushViewController:jfOrderVC animated:YES];
            }
        }];
        */
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
