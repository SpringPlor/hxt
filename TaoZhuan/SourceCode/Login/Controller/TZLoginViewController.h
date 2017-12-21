//
//  TZLoginViewController.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewController.h"

@interface TZLoginViewController : MYBaseViewController

@property (nonatomic,assign) BOOL isRoot;

@property (nonatomic,copy) void (^loginBlock)();

@end
