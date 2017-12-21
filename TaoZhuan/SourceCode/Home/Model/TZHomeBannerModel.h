//
//  TZHomeBannerModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/16.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZHomeBannerModel : MYBaseModel

@property (nonatomic,copy) NSString *creationTime;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *title;

@end
