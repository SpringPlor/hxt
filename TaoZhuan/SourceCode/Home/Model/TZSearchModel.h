//
//  TZSearchModel.h
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/9/29.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "MYBaseModel.h"

@interface TZSearchModel : MYBaseModel

//@{@"method":@"taobao.tbk.item.get",@"app_key":AliTradeSDK_Key,@"sign_method":@"md5",@"timestamp":[ZMUtils currentDateStr],@"format":@"json",@"v":@"2.0",@"fields":@"num_iid,title,pict_url,small_images,reserve_price,zk_final_price,user_type,provcity,item_url,seller_id,volume,nick",@"q":@"女装"};

@property (nonatomic,copy) NSString *method;
@property (nonatomic,copy) NSString *app_key;
@property (nonatomic,copy) NSString *sign_method;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *format;
@property (nonatomic,copy) NSString *v;
@property (nonatomic,copy) NSString *fields;
@property (nonatomic,copy) NSString *q;//搜索时使用，关键字
@property (nonatomic,copy) NSString *num_iids;//详情时使用，ids。用，隔开
@property (nonatomic,copy) NSString *adzone_id;//推广位id,转链接时使用
@property (nonatomic,copy) NSString *start_time;//推广位id,转链接时使用
@property (nonatomic,copy) NSString *end_time;//推广位id,转链接时使用
@property (nonatomic,copy) NSString *page_no;
@property (nonatomic,copy) NSString *page_size;

@end
