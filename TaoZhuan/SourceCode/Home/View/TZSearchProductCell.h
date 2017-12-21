//
//  TZSearchProductCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/9.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"
#import "TZServiceGoodsModel.h"
@interface TZSearchProductCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *tbPriceLabel;
@property (nonatomic,strong) UILabel *salesNum;
@property (nonatomic,strong) UIImageView *couponLeft;
@property (nonatomic,strong) UIImageView *couponRight;
@property (nonatomic,strong) UILabel *couponPriceLabel;
@property (nonatomic,strong) UILabel *finalPriceLabel;

- (void)setCellInfoWithDWJModel:(TZSearchProductModel *)model;

- (void)setCellInfoWithTBModel:(TZTaoBaoProductModel *)model;

- (void)setCellInfoWithServiceModel:(TZServiceGoodsModel *)mode;;

@end
