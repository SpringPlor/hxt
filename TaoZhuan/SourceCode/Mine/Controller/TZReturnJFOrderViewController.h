//
//  TZReturnJFOrderViewController.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

typedef enum{
    //OrderStatusALL      =    0,//全部
    OrderStatusSH       =    0,//审核中
    OrderStatusJJDZ,           //即将到账
    OrderStatusYDZ,            //已到账
    OrderStatusWXDD            //无效订单
}OrderStatus;

#import "MYBaseViewController.h"

@interface TZReturnJFOrderViewController : MYBaseViewController

@property (nonatomic,assign) OrderStatus currentStatus;

@end
