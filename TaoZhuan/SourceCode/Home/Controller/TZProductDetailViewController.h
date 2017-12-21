//
//  TZProductDetailViewController.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseViewController.h"
#import "TZSearchProductModel.h"
#import "TZSearchResultModel.h"
#import "TZServiceGoodsModel.h"

@interface TZProductDetailViewController : MYBaseViewController

@property (nonatomic,strong) TZTaoBaoProductModel *resultModel;//淘宝数据

@property (nonatomic,strong) TZSearchProductModel *productModel;//大玩家数据

@property (nonatomic,strong) TZServiceGoodsModel *detailModel;//爬虫数据

@end
