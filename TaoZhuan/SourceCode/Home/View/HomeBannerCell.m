//
//  HomeBannerCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/30.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeBannerCell.h"

@implementation HomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:SCREEN_WIDTH];
        
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:nil];
        [self.contentView addSubview:self.cycleScrollView];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(kScale*209);
        }];
        self.cycleScrollView.delegate = self;
        NSArray *imageNames = @[@"9.9包邮",@"极有家",@"品牌馆",@"全球购"];
        NSMutableArray *images = [NSMutableArray array];
        for (NSString *imageName in imageNames){
            [images addObject:[UIImage imageNamed:imageName]];
        }
        self.cycleScrollView.localizationImagesGroup = images;
        
        self.arcImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"homebannerarc"]];
        [self.contentView addSubview:self.arcImageView];
        [self.arcImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.bottom.equalTo(self.cycleScrollView.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(5*kScale);
        }];
        
        NSArray *imageArray = @[@"homejiaoc",@"homeqiandao",@"yaoqingyj",@"homejifen"];
        NSArray *nameArray = @[@"购买教程",@"签到奖励",@"邀请有奖",@"积分兑换"];
        CGFloat space = (SCREEN_WIDTH-45*4)/5;
        for (int i = 0; i < 4; i ++){
            UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:imageArray[i]] selectImage:nil];
            [self.contentView addSubview:itemButton];
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(space+(space+45)*i);
                make.top.equalTo(self.cycleScrollView.mas_bottom).offset(15);
                make.width.height.mas_equalTo(45);
            }];
            [itemButton addTarget:self action:@selector(buttonAciton:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = 10086+i;
            UILabel *nameLabel = [MYBaseView labelWithFrame:CGRectZero text:nameArray[i] textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1] textAlignment:NSTextAlignmentCenter andFont:kFont(12)];
            [self.contentView addSubview:nameLabel];
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(itemButton);
                make.top.equalTo(itemButton.mas_bottom).offset(10);
            }];
        }
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.bannerTapBlcok) {
        self.bannerTapBlcok(index);
    }
}

- (void)setBannerInfoWithArray:(NSArray *)array{
    NSMutableArray *urlArray = [NSMutableArray array];
    for (int i = 0; i < array.count ; i++){
        TZHomeBannerModel *model = array[i];
        if (model.imgUrl) {
            [urlArray addObject:[NSString stringWithFormat:@"%@",model.imgUrl]];
        }
    }
    self.cycleScrollView.imageURLStringsGroup = urlArray;
}

- (void)buttonAciton:(UIButton *)sender{
    if (self.itemTapBlcok) {
        self.itemTapBlcok(sender.tag-10086);
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
