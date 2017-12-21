//
//  TZSearchCell.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/2.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"
#import "TZServiceGoodsModel.h"
@interface TZSearchCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *originPrice;//原价
@property (nonatomic,strong) UILabel *priceLabel;//现价
@property (nonatomic,strong) UILabel *saleLabel;//销量
@property (nonatomic,strong) UIImageView *leftCouponImg;
@property (nonatomic,strong) UIImageView *rightCouponImg;
@property (nonatomic,strong) UILabel *couponPrice;
@property (nonatomic,strong) UILabel *integralLabel;

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model;

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model;

- (void)setCellInfoWithServiceModel:(TZServiceGoodsModel *)mode;

@end
