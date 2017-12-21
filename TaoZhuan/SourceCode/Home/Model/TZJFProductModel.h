//
//  TZJFProductModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/17.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZJFProductModel : MYBaseModel

@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *marketPrice;
@property (nonatomic,assign) CGFloat integral;
@property (nonatomic,copy) NSString * commodityUrl;

@end
