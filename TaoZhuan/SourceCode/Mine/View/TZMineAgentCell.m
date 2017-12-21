//
//  TZMineAgentCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZMineAgentCell.h"
#import "TZMinePartnerView.h"

@implementation TZMineAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:TZ_TableView_Color alpha:1.0];
        self.partnerModule = [[TZMinePartnerView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 138) title:@"合伙人中心" iconArray:@[@"收益报表icon",@"我的团队icon"] itemTitle:@[@"收益报表",@"我的团队"]];
        [self.contentView  addSubview:self.partnerModule];
        self.partnerModule.arrowImageView.hidden = YES;
        self.partnerModule.orderButton.hidden = YES;
        self.partnerModule.numLabel.hidden = YES;
        self.partnerModule.layer.cornerRadius = 5;
        self.partnerModule.redView.image = [UIImage imageNamed:@"yuebiaoti"];
        WeakSelf(self);
        [self.partnerModule setTapItemBlock:^(NSInteger index){
            if (weakSelf.tapBlock) {
                weakSelf.tapBlock(index);
            }
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
