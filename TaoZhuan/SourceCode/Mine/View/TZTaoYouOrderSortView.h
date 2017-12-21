//
//  TZSearchSortView.h
//  ZhaoQuanWang
//
//  Created by 彭佳伟 on 2017/11/2.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZTaoYouOrderSortView : UIView

@property (nonatomic,strong) UIView *redView;
@property (nonatomic,copy) void (^tapBlcok)(NSInteger index,NSString *order);

- (instancetype)initWithFrame:(CGRect)frame;

@end
