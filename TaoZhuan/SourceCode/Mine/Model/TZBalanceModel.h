//
//  TZBalanceModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/21.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZBalanceModel : MYBaseModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,assign) CGFloat amount;
@property (nonatomic,copy) NSString *remainAmount;
@property (nonatomic,copy) NSString *moneyType;
@property (nonatomic,copy) NSString *evaluationToday;//当日预估
@property (nonatomic,copy) NSString *evaluationMonth;//当月预估
@property (nonatomic,copy) NSString *objectId;//关联id。如:提现就是对应Withdraw的主键
@property (nonatomic,copy) NSString *creationTime;

@end
