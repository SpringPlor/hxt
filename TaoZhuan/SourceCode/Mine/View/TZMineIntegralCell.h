//
//  TZMineIntegralCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZMineModuleView.h"

@interface TZMineIntegralCell : UITableViewCell

@property (nonatomic,strong) TZMineModuleView *integralModule;//积分
@property (nonatomic,copy) void (^tapBlock)(NSInteger index);

@end
