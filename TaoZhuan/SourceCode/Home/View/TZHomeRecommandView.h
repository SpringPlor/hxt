//
//  TZHomeRecommandView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZServiceGoodsModel.h"

@interface TZHomeRecommandView : UIView

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *whiteBgView;

@property (nonatomic,copy) void (^tapBlock)();
@property (nonatomic,copy) void (^pdtBlock)(TZServiceGoodsModel *model);

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

@end
