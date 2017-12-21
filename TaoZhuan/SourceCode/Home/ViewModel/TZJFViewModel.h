//
//  TZJFViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZJFViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *jfProductCommand;
@property (nonatomic,strong) RACCommand *jfExchangeCommand;
@property (nonatomic,strong) RACCommand *jfExchangeOrderCommand;

@end
