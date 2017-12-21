//
//  TZLoginViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZLoginViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *verCommand;

@property (nonatomic,strong) RACCommand *loginCommand;

@property (nonatomic,strong) RACCommand *deviceIdCommand;

@property (nonatomic,strong) RACCommand *inviteCommand;

@end
