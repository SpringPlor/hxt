//
//  TZShareShotPdtView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZServiceGoodsModel.h"
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"

@interface TZShareShotPdtView : UIView

@property (nonatomic,strong) UIImageView *pdtImageView;
@property (nonatomic,strong) UIImageView *QRCodeBgView;
@property (nonatomic,strong) UIImageView *QRCodeImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *tbPriceLabel;
@property (nonatomic,strong) UIImageView *couponLeft;
@property (nonatomic,strong) UIImageView *couponRight;
@property (nonatomic,strong) UILabel *couponPriceLabel;
@property (nonatomic,strong) UILabel *finalPriceLabel;
@property (nonatomic,copy) NSString *shareUrl;

- (instancetype)initWithFrame:(CGRect)frame withModel:(id)model;

@end
