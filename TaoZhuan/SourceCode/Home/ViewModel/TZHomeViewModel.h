//
//  TZHomeViewModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/28.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewModel.h"

@interface TZHomeViewModel : MYBaseViewModel

@property (nonatomic,strong) RACCommand *bannerCommand;//获取所有banner
@property (nonatomic,strong) RACCommand *hotCommand;//获取热搜
@property (nonatomic,strong) RACCommand *bannerDetailCommand;
@property (nonatomic,strong) RACCommand *categoryCommand;//底部图
@property (nonatomic,strong) RACCommand *versionCommand;//版本判断
@property (nonatomic,strong) RACCommand *snapUpCommand;//今日必抢
@property (nonatomic,strong) RACCommand *snapGoodsCommand;//抢购商品
@property (nonatomic,strong) RACCommand *popCommand;//首页弹窗
@property (nonatomic,strong) RACCommand *popGoodsCommand;//弹窗商品
@property (nonatomic,strong) RACCommand *recommendCommand;//获取推荐
@property (nonatomic,strong) RACCommand *recommendShopsCommand;//推荐商品

@end
