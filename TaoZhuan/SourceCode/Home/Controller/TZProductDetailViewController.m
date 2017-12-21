//
//  TZProductDetailViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/11.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/albbsdk.h>

#import "TZProductDetailViewController.h"
#import "TZDetailTitleCell.h"
#import "TZDetailInfoCell.h"
#import "TZDetailDescribeCell.h"
#import "TZSearchProductViewModel.h"
#import "TZSearchModel.h"
#import "TZALiTradeAPITools.h"
#import "TZDeviceModel.h"
#import "TZProductWebViewController.h"
#import "TZShareProductView.h"
#import "ZMImageTool.h"
#import "TZImageModel.h"
#import "TZShareShotPdtView.h"
#import "TZThirdShare.h"
#import "ZMImageTool.h"
#import "TZLoginViewController.h"
#import "TZApplyAgentViewController.h"

@interface TZProductDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *oriPriceLabel;
@property (nonatomic,strong) UILabel *cutPriceLabel;
@property (nonatomic,strong) TZSearchProductViewModel *searchViewModel;
@property (nonatomic,strong) TZSearchModel *searchModel;//保存淘宝搜索字段信息
@property (nonatomic,strong) UIImageView *guideImageView;//引导页
@property (nonatomic,strong) TZShareProductView *shareView;
@property (nonatomic,strong) NSMutableArray *pdtImageArray;
@property (nonatomic,strong) TZShareShotPdtView *shotPdtView;//分享图片
@property (nonatomic,copy) NSString *couponHref;//券链接
@property (nonatomic,copy) NSString *buyHref;//商品链接
@property (nonatomic,copy) NSString *mergeUrl;//高佣链接
@property (nonatomic,copy) NSString *taoToken;//淘口令
@property (nonatomic,assign) BOOL showImages;//是否显示图组
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation TZProductDetailViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = rGB_Color(240, 240, 240);
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TZStatusBarStyle setStatusBarColor:[UIColor clearColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = YES;
    [MobClick event:chakanshangpinxiangqing];
    [self initBottomView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [TZStatusBarStyle setStatusBarColor:[UIColor whiteColor]];
    [self.bottomView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self initBackView];
    [self bindCommand];
    [self guideView];
    [self initShotView];

    // Do any additional setup after loading the view.
}

//分享图片
- (void)initShotView{
    if (self.resultModel) {
        self.shotPdtView = [[TZShareShotPdtView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH+45+120*kScale) withModel:self.resultModel];
    }
    if (self.productModel) {
        self.shotPdtView = [[TZShareShotPdtView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH+45+120*kScale) withModel:self.productModel];
    }
    if (self.detailModel) {
        self.shotPdtView = [[TZShareShotPdtView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_WIDTH+45+120*kScale) withModel:self.detailModel];
    }
    [self.view addSubview:self.shotPdtView];
}

//引导页
- (void)guideView{
    __block NSInteger index = 0;
    NSString *guide = [[NSUserDefaults standardUserDefaults] objectForKey:@"PdtGuide"];
    if (guide == nil) {
        self.guideImageView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:[UIImage imageNamed:[NSString stringWithFormat:@"pdtGuide%@",@(index)]]];
        [kWindow addSubview:self.guideImageView];
        self.guideImageView.userInteractionEnabled = YES;
        WeakSelf(self);
        [self.guideImageView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(UITapGestureRecognizer *sender) {
            if (index == 3) {
                [weakSelf.guideImageView removeFromSuperview];
                [[NSUserDefaults standardUserDefaults] setObject:@"PdtGuide" forKey:@"PdtGuide"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                index ++;
                weakSelf.guideImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pdtGuide%@",@(index)]];
            }
        }]];
    }
}

- (void)bindCommand{
    self.searchViewModel = [TZSearchProductViewModel new];
    //获取商品图组
    self.pdtImageArray = [NSMutableArray array];
    [[self.searchViewModel.pdtPicCommand.executionSignals switchToLatest] subscribeNext:^(NSArray *images) {
        if (images) {
            for (int i = 0 ; i < images.count; i ++) {
                TZImageModel *model = [[TZImageModel alloc] init];
                model.imageUrl = images[i];
                model.imageSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
                [self.pdtImageArray addObject:model];
                /*[ZMImageTool downloadImageSizeWithURL:model.imageUrl imageSizeBlock:^(CGSize size) {
                    model.imageSize = size;
                    [self.pdtImageArray addObject:model];
                }];
                */
            }
            [self.tableView reloadData];
        }
    }];
    NSString *ids;
    if (self.resultModel) {
        ids = [NSString stringWithFormat:@"{item_num_id:%@}",self.resultModel.auctionId];
    }
    if (self.productModel) {
        ids = [NSString stringWithFormat:@"{item_num_id:%@}",self.productModel.pdtid];
    }
    if (self.detailModel) {
        ids = [NSString stringWithFormat:@"{item_num_id:%@}",self.detailModel.commodityId];
    }
    [self.searchViewModel.pdtPicCommand execute:@{@"data":ids}];
    
    if (self.resultModel) {
        self.couponHref = self.resultModel.couponLink == nil ? @"" : self.resultModel.couponLink;
        self.buyHref = self.resultModel.auctionUrl == nil ? @"" : self.resultModel.auctionUrl;
    }
    if (self.productModel) {
        self.couponHref = self.productModel.cpnaddr == nil ? @"" : self.productModel.cpnaddr;
        self.buyHref = self.productModel.pdtaddr == nil ? @"" : self.productModel.pdtaddr;
    }
    if (self.detailModel) {
        self.couponHref = self.detailModel.couponUrl == nil ? @"" : self.detailModel.couponUrl;
        self.buyHref = self.detailModel.commodityUrl == nil ? @"" : self.detailModel.commodityUrl;
    }

    @weakify(self);
    [[self.searchViewModel.mergeUrlCommand.executionSignals switchToLatest] subscribeNext:^(NSDictionary *response) {
        if (response) {
            @strongify(self);
            self.mergeUrl = response[@"couponClickUrl"];
            [self.searchViewModel.tklCommand execute:@{@"mergeUrl":self.mergeUrl}];
            return ;
            if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
                [self.searchViewModel.tklCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"t":[MYSingleton shareInstonce].loginModel.accessToken,@"mergeUrl":self.mergeUrl}];

            }else{
                if (UserDefaultsOFK(User_Device_Info)) {
                    TZDeviceModel *model = [TZDeviceModel mj_objectWithKeyValues:UserDefaultsOFK(User_Device_Info)];
                    [self.searchViewModel.tklCommand execute:@{@"u":model.id,@"t":model.accessToken,@"mergeUrl":self.mergeUrl}];
                }
            }
        }
    }];
    //获取高佣链接
    if ([UserDefaultsOFK(Login_Status) intValue] == 1) {
        [self.searchViewModel.mergeUrlCommand execute:@{@"u":[MYSingleton shareInstonce].loginModel.id,@"couponHref":self.couponHref,@"buyHref":self.buyHref}];
    }else{
        [self.searchViewModel.mergeUrlCommand execute:@{@"couponHref":self.couponHref,@"buyHref":self.buyHref}];
    }
    
    //获取短连接
    [[self.searchViewModel.shortUrlCommand.executionSignals switchToLatest] subscribeNext:^(NSString *shortUrl) {
        self.shotPdtView.shareUrl = shortUrl;
        NSLog(@"%@",shortUrl);
    }];
    //获取淘口令
    [[self.searchViewModel.tklCommand.executionSignals switchToLatest] subscribeNext:^(NSString *taoToken) {
        if (taoToken) {
            self.taoToken = taoToken;
            self.shareView.taoToken = self.taoToken;
            NSString *shareUrl;
            //获取短连接
            if (self.resultModel) {//淘宝
                shareUrl = [NSString stringWithFormat:@"http://118.31.45.203:9000/share?commodityId=%@&imageUrl=%@&shortTitle=%@&isTBorTM=%@&discountPrice=%.2f&price=%.2f&couponPrice=%ld&code=%@&couponLink=%@",self.resultModel.auctionId,[NSString stringWithFormat:@"http:%@",self.resultModel.pictUrl],[ZMUtils filterHTML:self.resultModel.title],self.resultModel.userType,self.resultModel.zkPrice,self.resultModel.zkPrice+self.resultModel.couponAmount,(long)self.resultModel.couponAmount,self.taoToken,self.mergeUrl];
                NSLog(@"%@",shareUrl);
            }
            if (self.detailModel) {//爬虫
                shareUrl = [NSString stringWithFormat:@"http://118.31.45.203:9000/share?commodityId=%@&imageUrl=%@&shortTitle=%@&isTBorTM=%@&discountPrice=%.2f&price=%.2f&couponPrice=%ld&code=%@&couponLink=%@",self.detailModel.commodityId,self.detailModel.imageUrl,self.detailModel.shortTitle,@(self.detailModel.isTmall),self.detailModel.price,self.detailModel.price+self.detailModel.couponPrice,(long)self.detailModel.couponPrice,self.taoToken,self.mergeUrl];
                NSLog(@"%@",shareUrl);
            }
            if (self.productModel) {//大玩家
                shareUrl = [NSString stringWithFormat:@"http://118.31.45.203:9000/share?commodityId=%@&imageUrl=%@&shortTitle=%@&isTBorTM=%@&discountPrice=%.2f&price=%.2f&couponPrice=%ld&code=%@&couponLink=%@",self.productModel.pdtid,self.productModel.pdtpic,self.productModel.pdttitle,self.productModel.shoptmall,[self.productModel.pdtbuy floatValue],[self.productModel.pdtprice floatValue],(long)self.productModel.cpnprice,self.taoToken,self.mergeUrl];
            }
            [self.searchViewModel.shortUrlCommand execute:@{@"url":shareUrl}];
        }
    }];
}

- (void)initBackView{
    UIButton *backView = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"fanhui_detail"] selectImage:nil];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(35);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    backView.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
    [backView addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initBottomView{
    self.bottomView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
    [kWindow addSubview:self.bottomView];
    self.bottomView.userInteractionEnabled = YES;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kWindow).offset(0);
        make.bottom.equalTo(kWindow.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(49);
    }];
    UIButton *shareButton = [MYBaseView buttonWithFrame:CGRectMake(0, 0, 75, 49) image:[UIImage imageNamed:@"fenxiang"] title:@"分享" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(10)];
    [self.bottomView addSubview:shareButton];
    shareButton.userInteractionEnabled = YES;
    [shareButton setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:4];
    [[shareButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       self.shareView  = [[TZShareProductView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [kWindow addSubview:self.shareView];
        self.shareView.taoToken = self.taoToken;
        if (self.detailModel) {
            self.shareView.model = self.detailModel;
        }
        if (self.resultModel) {
            self.shareView.model = self.resultModel;
        }
        if (self.productModel) {
            self.shareView.model = self.productModel;
        }
        WeakSelf(self);
        [self.shareView setRemoveBlock:^(NSInteger index){
            [weakSelf.shareView removeFromSuperview];
            UIImage *shareImage = [ZMImageTool imageFromView:weakSelf.shotPdtView atFrame:weakSelf.shotPdtView.bounds];
            switch (index) {
                case 0:
                {
                    [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_WechatTimeLine image:shareImage];
                }
                    break;
                case 1:
                {
                    [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_WechatSession image:shareImage];
                    
                }
                    break;
                case 2:
                {
                    [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_Qzone image:shareImage];
                }
                    break;
                case 3:
                {
                    [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_QQ image:shareImage];
                }
                    break;
                default:
                    break;
            }
        }];
    }];
    
    UIView *lqBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0]];
    [self.bottomView addSubview:lqBgView];
    [lqBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView);
        make.left.equalTo(self.bottomView).offset(75);
        make.top.equalTo(self.bottomView);
        make.height.mas_equalTo(49);
    }];
    
    self.cutPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:[NSString stringWithFormat:@"¥%@",self.productModel.pdtbuy] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(18)];
    [lqBgView addSubview:self.cutPriceLabel];
    [self.cutPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lqBgView).offset(6);
        make.centerX.equalTo(lqBgView);
    }];
    if (self.productModel){
        self.cutPriceLabel.text = [NSString stringWithFormat:@"¥%@",self.productModel.pdtbuy];
    }
    if (self.resultModel) {
        self.cutPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.resultModel.zkPrice];
    }
    if (self.detailModel) {
        self.cutPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.detailModel.price - self.detailModel.couponPrice];
    }
    
    UILabel *lqLabel = [MYBaseView labelWithFrame:CGRectZero text:@"领券购买" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(10)];
    [lqBgView addSubview:lqLabel];
    [lqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lqBgView.mas_bottom).offset(-8);
        make.centerX.equalTo(lqBgView);
    }];
    lqBgView.userInteractionEnabled = YES;
    [lqBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lqBuy:)]];
}

#pragma mark - Action
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lqBuy:(UITapGestureRecognizer *)sender{
    [MobClick event:lingquangoumai];
    [self jumpUrl];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.showImages) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.pdtImageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.productModel) {
            return 360*kScale+70*kScale+115+[NSString stringHightWithString:[NSString stringWithFormat:@"  %@",self.productModel.pdttitle] size:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) font:kFont(15) lineSpacing:defaultLineSpacing].height+30;
        }else if (self.resultModel) {
            return 360*kScale+70*kScale+115+[NSString stringHightWithString:[NSString stringWithFormat:@"  %@",[ZMUtils filterHTML:self.resultModel.title]] size:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) font:kFont(15) lineSpacing:defaultLineSpacing].height+30;
        }else {
            return 360*kScale+70*kScale+115+[NSString stringHightWithString:[NSString stringWithFormat:@"  %@",self.detailModel.title] size:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) font:kFont(15) lineSpacing:defaultLineSpacing].height+30;
        }
    }else{
        TZImageModel *model = self.pdtImageArray[indexPath.row];
        return model.imageSize.height;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        TZImageModel *model = self.pdtImageArray[indexPath.row];
        if (CGSizeEqualToSize(model.imageSize, CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH))) {
            TZDetailDescribeCell *desCell = (TZDetailDescribeCell *)cell;
            [desCell.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                model.imageSize = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*image.size.height/image.size.width);
                [self.pdtImageArray replaceObjectAtIndex:indexPath.row withObject:model];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                //[self.tableView reloadData];
            }];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [MYBaseView viewWithFrame:CGRectZero backgroundColor:rGB_Color(242, 242, 242)];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TZDetailTitleCell *cell = [[TZDetailTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZDetailTitleCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.productModel) {//大玩家数据
            [cell setCellInfoWithDWJModel:self.productModel];
        }
        if (self.resultModel) {//淘宝数据
            [cell setCellInfoWithTBModel:self.resultModel];
        }
        if (self.detailModel) {
            [cell setCellInfoWithServiceModel:self.detailModel];
        }
        [cell setBuyBlock:^{
            [MobClick event:lijilingquan];
            [self jumpUrl];
        }];
        [[cell.showAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (!self.showImages) {
                self.showImages = !self.showImages;
                [self.tableView reloadData];
            }
            //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];
        }];
        [cell setApplyBlock:^{
            [self applayAgent];
        }];
        return cell;
    }else if (indexPath.section == 1){
        TZDetailDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZDetailDescribeCell class])];
        if (cell == nil) {
            cell =  [[TZDetailDescribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZDetailDescribeCell class])];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TZImageModel *model =  self.pdtImageArray[indexPath.row];
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
        return cell;
    }else{
        TZDetailInfoCell *cell = [[TZDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZDetailInfoCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - tableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

//跳转链接
- (void)jumpUrl{
    if (self.mergeUrl){
        //id<AlibcTradePage> page1 = [AlibcTradePageFactory itemDetailPage:transformId];//商品id
        id<AlibcTradePage> page3 = [AlibcTradePageFactory page:self.mergeUrl];//坑，只用url跳转会打开手淘
        //淘客信息
        AlibcTradeTaokeParams *taoKeParams = [[AlibcTradeTaokeParams alloc] init];
        taoKeParams.adzoneId = @"138744610"; //your adzoneId
        taoKeParams.extParams = @{@"taokeAppkey":AliTradeSDK_Key};//your taokeAppkey
        //打开方式
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = AlibcOpenTypeNative;

        [[AlibcTradeSDK sharedInstance].tradeService show:self.navigationController page:page3 showParams:showParam taoKeParams:nil trackParam:nil tradeProcessSuccessCallback:^(AlibcTradeResult * _Nullable result) {
            NSLog(@"%@",result);
        } tradeProcessFailedCallback:^(NSError * _Nullable error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)tbApplyXorid{
    [self.searchViewModel.applyXoridCommand execute:@{@"ids":self.resultModel.auctionId}];
}

//申请代理
- (void)applayAgent{
    if([UserDefaultsOFK(Login_Status) intValue] == 1){
        if ([MYSingleton shareInstonce].userInfoModel.agentInfo.id) {//已经是代理
            
        }else{//申请代理
            TZApplyAgentViewController *agentVC = [[TZApplyAgentViewController alloc] init];
            [self.navigationController pushViewController:agentVC animated:YES];
        }
    }else{//登录
        TZLoginViewController *loginVC = [[TZLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
