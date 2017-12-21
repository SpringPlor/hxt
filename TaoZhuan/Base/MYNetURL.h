//
//  MYNetURL.h
//  MaiYou
//
//  Created by PengJiawei on 2017/1/11.
//  Copyright © 2017年 PengJiawei. All rights reserved.
//

#define MODULE_ALiTradeAPIDEMO_LOGIN      @"ALiTradeSDKLoginViewController"//淘宝登录
#define ALiTradeSearchMethod @"taobao.tbk.item.get"//淘宝客商品搜索
#define ALiTradeDetailMethod @"taobao.tbk.item.info.get"//淘宝客商品详情
#define ALITradeTransformMethod @"taobao.tbk.ju.tqg.get"//淘宝客商品链接转化

#import <Foundation/Foundation.h>

static NSString * const Verify_Code = @"api/user/getVerifyCode";//获取验证码
static NSString * const Login_Phone = @"api/user/loginByPhone";//使用手机号登录
static NSString * const Login_Device_ID = @"api/user/loginAsGuest";//使用设备号登录
static NSString * const Set_Invite_Code = @" api/user/setMaster";//登录设置邀请码
static NSString * const Home_Banner = @"api/category/getBanners";//获取所有banner
static NSString * const Home_Banner_Hot = @"api/category/getHotSearchs";//获取热搜
static NSString * const Home_Snap_UP = @"api/adSet/getRushPurchases";//获取今日必抢
static NSString * const Home_Popover = @"api/adSet/getDayPopupAdSet";//首页商品弹窗
static NSString * const Searc_Recommand = @"api/adSet/getRecommends";//搜索推荐
static NSString * const Goods_Category = @"api/goods/getGoodsByIds";//不同分类下的商品
//static NSString * const Home_Banner_Recommend = @"api/category/getRecommends";//获取推荐类别
static NSString * const Banner_Detail = @"api/commodity/getCommodities";//获取banner详情
static NSString * const Home_Category_Image = @"api/resource/getByCategories";//获取首页底部分类图
static NSString * const Fetch_UserInfo = @"api/user/getInfo";//用户信息
static NSString * const Sing_In = @"api/user/signin";//签到
static NSString * const User_Invite_Code = @"api/user/getInvitationCode";//用户邀请码
static NSString * const Login_Out = @"api/user/quit";//登出
static NSString * const Integral_Details = @"api/integrallog/getIntegralLogs";//积分明细
static NSString * const Integral_Order = @"api/order/getIntegralOrders";//积分兑换订单
static NSString * const TaoBao_Friends = @"api/user/getApprentices";//淘友
static NSString * const Integral_Commodity = @"api/commodity/getIntegralCommodities";//积分商品
static NSString * const Integral_Exchange = @"api/commodity/exchangeIntegralCommodity";//积分兑换
//static NSString * const Integral_Exchange_Order = @"api/order/getIntegralOrders";//积分兑换订单
static NSString * const Bind_Order = @"api/order/bindUser";//绑定订单号
static NSString * const Supplement_Order = @"api/order/supplement";//订单补录
static NSString * const Cash_Withdrawal = @"api/user/withdraw";//提现
static NSString * const Return_JF_Orders = @"api/order/getOrders";//返积分订单
static NSString * const Fetch_Balance = @"api/moneylog/getMoneyLogs";//余额明细
static NSString * const Fetch_Balance_Orders = @"api/order/getApprenticesOrders";//余额订单明细
static NSString * const Message_Return = @"api/user/feedback";//意见反馈
static NSString * const Fetch_Agent_Type = @"api/agent/getSource";//合伙人后台类型
static NSString * const Agent_Login = @"api/agent/loginAgent";//合伙人登录
static NSString * const Agent_Earning_Report = @"api/order/getAgentEarningReport";//收益报表
static NSString * const Agent_Orders = @"api/order/getAgentOrders";//代理人下淘友订单
static NSString * const Agent_Partner_Earning = @"api/order/getAgentPartnerInfos";//代理人下团队进贡
static NSString * const Merge_Url = @"api/agent/mergeUrl";//高佣链接
static NSString * const Tao_Token_Url = @"api/agent/getTpwd";//淘口令
static NSString * const Agent_Apply = @"api/agentApply/toAgentApply";//代理人申请
static NSString * const Order_Image_Urls = @"api/order/getOrderImageUrl";//订单主图统一接口



static NSString *const TaoBao_Pdt_Pic_URL = @"http://hws.m.taobao.com/cache/mtop.wdetail.getItemDescx/4.1/";//全网商品图片

/*  
 GET:
 q，sort，order，start，limit，keywords
 
 q： 数据类型 从1-13 分别代表不同数据。
 
 1. 默认数据
 2. 搜索数据
 3. 每日精选
 4. 昨日销量榜
 5. 实时销量榜
 6. 品牌馆
 7. 聚划算
 8. 9.9包邮
 9. 19.9包邮
 10 29.9包邮
 11 极有家
 12 全球购
 13 今日推荐
 14 优选
 
 sort: 数据二级类目
 all           ： 默认数据
 naz         ：男装
 nvz         ：女装
 ny           ：内衣
 my          ：母婴
 hzp         ：化妆品
 jj 　         ：家居
 xbps         :鞋包配饰
 ms           ：美食
 wtcp        ：文体车品
 smjd        ：数码家电
 other       ：其他
 
 order：排序
 default      ：默认
 cpnprice     ：优惠券
 cmsrate      ：佣金
 pdtscore     ：评分
 pdtsell      ：销量
 pdtbuy       ：销量
 
 start  ： 起始位置
 limit  ： 请求数量 （最大50）
 keywords :   搜索关键词， 在 q==2 时生效。（urlencode）
 */
static NSString * const Dawanjia_Api = @"http://ljl.youxiangla.com/jl_info.php";//大玩家获取数据api

/*
 POST 请求.
 参数：
 item_id：商品id
 code    ： 校验码
 xor_id  ： 商品数据返回的认证码
 text    ： 标题
 url     ： 券链接
 */
static NSString * const ApplyUrl_Api = @"http://jl.youxiangla.com/ljl_item.php";//申请新链接api

/*
    
 GET 请求
 method     : API接口名称。(淘宝客商品查询)
 app_key    : appkey
 sign_method: 签名的摘要算法，可选值为：hmac，md5。
 sign       : 签名
 timestamp  : 时间戳，格式为yyyy-MM-dd HH:mm:ss
 format     ：响应格式。默认为xml格式，可选值：xml，json
 v          : 2.0 版本号
 fields : 返回数据中需要返回字段
 page_no
 page_size
 */

static NSString * const AliTrade_Search_Api_Box = @"http://gw.api.tbsandbox.com/router/rest";//淘宝客商品查询（沙盒环境）
//static NSString * const AliTrade_Search_Api = @"http://gw.api.taobao.com/router/rest";//淘宝客商品查询（正式环境）、详情获取（同样的接口，api接口名称不一样）//------------------------弃用，使用抓包接口搜索
static NSString * const AliTrade_Transform_Api = @"http://gw.api.taobao.com/router/rest";//淘宝客商品url转化
static NSString * const AliTrade_Search_Api = @"http://pub.alimama.com/items/search.json";//淘宝搜索抓包接口
static NSString * const Apply_Xor_id = @"http://app.youxiangla.com/ljl_ginfos.php";//抓包数据id获取转链接认证码

