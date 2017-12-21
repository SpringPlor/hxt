//
//  TZSearchProductViewController.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewController.h"

@interface TZSearchProductViewController : MYBaseViewController

@property (nonatomic,copy) NSString *searchKeyword;

@property (nonatomic,assign) BOOL autSearchTB;//大玩家无数据时搜淘宝

@end
