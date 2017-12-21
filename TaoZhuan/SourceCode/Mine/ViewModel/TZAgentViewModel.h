//
//  TZAgentViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZAgentViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *earningReportCommand;//收益报表
@property (nonatomic,strong) RACCommand *agentOrderCommand;//代理淘友订单
@property (nonatomic,strong) RACCommand *agentEarningCommand;//代理团队进贡金额
@property (nonatomic,strong) RACCommand *orderImageUrlsCommand;//订单主图

@end
