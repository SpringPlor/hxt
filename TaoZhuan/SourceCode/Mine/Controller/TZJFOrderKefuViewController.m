//
//  TZJFOrderKefuViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/14.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJFOrderKefuViewController.h"
#import "TZJFOrderKefuPhoneView.h"

@interface TZJFOrderKefuViewController ()

@property (nonatomic,strong) TZJFOrderKefuPhoneView *phoneModule;
@property (nonatomic,strong) TZJFOrderKefuPhoneView *wxModule;
@property (nonatomic,strong) TZJFOrderKefuPhoneView *qqModule;


@end

@implementation TZJFOrderKefuViewController

- (NSString *)title{
    return @"积分兑换订单";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView{
    UIImageView *kefuImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"kefubanner"]];
    [self.view addSubview:kefuImageView];
    [kefuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(170*kScale);
    }];
    
    UILabel *infoLabel = [MYBaseView labelWithFrame:CGRectZero text:@"亲，积分兑换商品成功后，我们客服会在24小时内联系您。若您超过24小时没有收到消息，请主动联系我们的客服哦！" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(16)];
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kefuImageView).offset(21);
        make.top.equalTo(kefuImageView.mas_bottom).offset(21);
        make.centerX.equalTo(self.view);
    }];
    infoLabel.numberOfLines = 0;
    
    CGFloat textHeight = [NSString stringHightWithString:infoLabel.text size:CGSizeMake(SCREEN_WIDTH-42, MAXFLOAT) font:kFont(16) lineSpacing:defaultLineSpacing].height;
    
    self.qqModule = [[TZJFOrderKefuPhoneView alloc] initWithFrame:CGRectMake(21, 170*kScale+22+textHeight+60, SCREEN_WIDTH-42, 40)];
    [self.view addSubview:self.qqModule];
    self.qqModule.icon.image = [UIImage imageNamed:@"kfqq"];
    self.qqModule.kefuLabel.text = @"客服QQ：";
    self.qqModule.account.text = @"783656843";
    
    self.wxModule = [[TZJFOrderKefuPhoneView alloc] initWithFrame:CGRectMake(21, 170*kScale+22+textHeight+60*2, SCREEN_WIDTH-42, 40)];
    [self.view addSubview:self.wxModule];
    self.wxModule.icon.image = [UIImage imageNamed:@"kfweixin"];
    self.wxModule.kefuLabel.text = @"客服微信：";
    self.wxModule.account.text = @"huixiangtao2017";
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
