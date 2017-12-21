//
//  TZKefuCourseModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/13.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZKefuCourseModel : MYBaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) BOOL isSpread;//是否展开
@property (nonatomic,assign) CGFloat height;//展开高度

@end
