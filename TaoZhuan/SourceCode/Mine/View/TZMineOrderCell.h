//
//  TZMineOrderCell.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZMineModuleView.h"

@interface TZMineOrderCell : UITableViewCell

@property (nonatomic,strong) TZMineModuleView *orderModule;
@property (nonatomic,copy) void (^tapBlock)(NSInteger index);


@end
