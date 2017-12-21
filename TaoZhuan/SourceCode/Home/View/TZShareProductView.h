//
//  TZShareProductView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"
#import "TZServiceGoodsModel.h"

@interface TZShareProductView : UIView

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) id model;
@property (nonatomic,copy) NSString *taoToken;
@property (nonatomic,copy) void (^removeBlock)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame;

@end
