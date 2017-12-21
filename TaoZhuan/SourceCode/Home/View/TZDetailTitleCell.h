//
//  TZDetailTitleCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"
#import "TZServiceGoodsModel.h"

@interface TZDetailTitleCell : UITableViewCell

@property (nonatomic,strong) SDCycleScrollView *scrollView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *couponArrow;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *tbPriceLabel;
@property (nonatomic,strong) UILabel *saleLabel;
@property (nonatomic,strong) UIImageView *couponLeftBgView;
@property (nonatomic,strong) UIImageView *couponRightBgView;
@property (nonatomic,strong) UILabel *couponPirce;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *jfLabel;
@property (nonatomic,strong) UIButton *showAllButton;
@property (nonatomic,copy) void (^applyBlock)();
@property (nonatomic,copy) void (^buyBlock)();

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model;

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model;

- (void)setCellInfoWithServiceModel:(TZServiceGoodsModel *)model;


@end
