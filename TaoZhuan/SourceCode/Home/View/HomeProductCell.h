//
//  HomeProductCell.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/10/31.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductModel.h"

@interface HomeProductCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *saleLabel;
@property (nonatomic,strong) UILabel *originLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIImageView *rightCoupon;
@property (nonatomic,strong) UIImageView *leftCoupon;
@property (nonatomic,strong) UILabel *couponPriceLabel;

- (void)setCellInfoWith:(TZSearchProductModel *)model;

@end
