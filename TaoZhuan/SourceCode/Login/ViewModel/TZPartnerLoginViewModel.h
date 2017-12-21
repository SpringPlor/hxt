//
//  TZPartnerLoginViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/7.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZPartnerLoginViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *partnerTypeCommand;
@property (nonatomic,strong) RACCommand *agentLoginCommand;

@end
