//
//  HomeItemDropView.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/9.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZHomeItemModel.h"

@interface HomeItemDropView : UIView

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *whiteBgView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,copy) void (^tapBlock)(TZHomeItemModel *model);

@end
