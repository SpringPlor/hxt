//
//  TZMineViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZMineViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *userInfoCommand;//获取用户信息
@property (nonatomic,strong) RACCommand *signinCommand;//签到
@property (nonatomic,strong) RACCommand *inviteVodeCommand;//邀请码
@property (nonatomic,strong) RACCommand *loginOutCommand;//登出
@property (nonatomic,strong) RACCommand *integralDetailCommand;//积分明细
@property (nonatomic,strong) RACCommand *intergralOrder;//积分兑换订单
@property (nonatomic,strong) RACCommand *tyCommand;//淘友
@property (nonatomic,strong) RACCommand *supplementCommand;//订单补录
@property (nonatomic,strong) RACCommand *zfbCashCommand;//提现
@property (nonatomic,strong) RACCommand *balanceCommand;//余额明细
@property (nonatomic,strong) RACCommand *balanceOrderCommand;//余额订单明细
@property (nonatomic,strong) RACCommand *messageReturnCommand;//意见反馈
@property (nonatomic,strong) RACCommand *agentApplyCommand;//代理申请

@end
