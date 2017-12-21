//
//  HomeTodayProductCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZServiceGoodsModel.h"

@interface HomeTodayProductCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIImageView *couponLeft;
@property (nonatomic,strong) UIImageView *couponRight;
@property (nonatomic,strong) UILabel *couponPriceLabel;
@property (nonatomic,strong) UILabel *tbPriceLabel;

- (void)setCellInfoWithModel:(TZServiceGoodsModel *)detailModel;

@end
