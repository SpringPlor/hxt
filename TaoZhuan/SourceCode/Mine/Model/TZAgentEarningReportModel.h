//
//  TZAgentEarningReportModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/12.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZAgentEarningReportModel : MYBaseModel

/*
 monthTotalBalance - Double : 本月结算汇总
 monthSelfBalance - Double : 本月本人结算
 monthFirstLevelBalance - Double : 本月一级结算
 monthSecondLevelBalance - Double : 本月二级结算
 lastMonthTotalBalance - Double : 上月结算汇总
 lastMonthSelfBalance - Double : 上月本人结算
 lastMonthFirstLevelBalance - Double : 上月一级结算
 lastMonthSecondLevelBalance - Double : 上月二级结算
 monthTotalBudget - Double : 本月预估汇总
 monthSelfBudget - Double : 本月本人预估
 monthFirstLevelBudget - Double : 本月一级预估
 monthSecondLevelBudget - Double : 本月二级预估
 yesterdayTotalBudget - Double : 昨日预估汇总
 yesterdaySelfBudget - Double : 昨日本人预估
 yesterdayFirstLevelBudget - Double : 昨日一级预估
 yesterdaySecondLevelBudget - Double : 昨日二级预估
 todayTotalBudget - Double : 今日预估汇总
 todaySelfBudget - Double : 今日本人预估
 todayFirstLevelBudget - Double : 今日一级预估
 todaySecondLevelBudget - Double : 今日二级预估
 todayOrders - Long : 今日订单数
 yesterdayOrders - Long : 昨日订单数
 monthOrders - Long : 本月订单数
*/
 
@property (nonatomic,assign) CGFloat lastMonthFirstLevelBalance;
@property (nonatomic,assign) CGFloat lastMonthSecondLevelBalance;
@property (nonatomic,assign) CGFloat lastMonthSelfBalance;
@property (nonatomic,assign) CGFloat lastMonthTotalBalance;
@property (nonatomic,assign) CGFloat monthFirstLevelBalance;
@property (nonatomic,assign) CGFloat monthFirstLevelBudget;
@property (nonatomic,assign) CGFloat monthSecondLevelBalance;
@property (nonatomic,assign) CGFloat monthSecondLevelBudget;
@property (nonatomic,assign) CGFloat monthSelfBalance;
@property (nonatomic,assign) CGFloat monthSelfBudget;
@property (nonatomic,assign) CGFloat monthTotalBalance;
@property (nonatomic,assign) CGFloat monthTotalBudget;
@property (nonatomic,assign) CGFloat todayFirstLevelBudget;
@property (nonatomic,assign) CGFloat todaySecondLevelBudget;
@property (nonatomic,assign) CGFloat todaySelfBudget;
@property (nonatomic,assign) CGFloat todayTotalBudget;
@property (nonatomic,assign) CGFloat yesterdayFirstLevelBudget;
@property (nonatomic,assign) CGFloat yesterdaySecondLevelBudget;
@property (nonatomic,assign) CGFloat yesterdaySelfBudget;
@property (nonatomic,assign) CGFloat yesterdayTotalBudget;
@property (nonatomic,assign) CGFloat totalMoney;
@property (nonatomic,assign) NSInteger todayOrders;
@property (nonatomic,assign) NSInteger yesterdayOrders;
@property (nonatomic,assign) NSInteger monthOrders;

@end
