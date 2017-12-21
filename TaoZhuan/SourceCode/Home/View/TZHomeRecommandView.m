//
//  TZHomeRecommandView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/8.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZHomeRecommandView.h"
#import "TZHomeRecommandCell.h"

@interface TZHomeRecommandView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,assign) NSInteger timeNum;

@end

@implementation TZHomeRecommandView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArray = dataArray;
        self.bgView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:[UIImage imageNamed:@"blackclearbg"]];
        [self addSubview:self.bgView];
        
        self.whiteBgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor whiteColor]];
        [self addSubview:self.whiteBgView];
        [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(290);
            make.height.mas_equalTo(410);
        }];
        self.whiteBgView.clipsToBounds = YES;
        self.whiteBgView.layer.cornerRadius = 15;
        self.whiteBgView.userInteractionEnabled = YES;
        
        UIButton *cancelButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"chacha"] selectImage:nil];
        [self addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.whiteBgView.mas_bottom).offset(20);
            make.centerX.equalTo(self.whiteBgView);
            make.width.height.mas_equalTo(24);
        }];
        cancelButton.userInteractionEnabled = YES;
        [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (self.tapBlock) {
                self.tapBlock();
            }
        }];
        [self initTopView];
        if (self.dataArray.count == 1) {
            [self initSingleProduct];
        }else{
            [self initMultipleView];
        }
    }
    return self;
}

- (void)initTopView{
    self.timeNum = 11;
    UIImageView *topImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"爆款推荐"]];
    [self.whiteBgView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.whiteBgView);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *topLabel = [MYBaseView labelWithFrame:CGRectZero text:@"爆款推荐" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(20)];
    [topImageView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topImageView);
    }];
    
    UIImageView *ballImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"倒计时"]];
    [self.whiteBgView addSubview:ballImageView];
    [ballImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteBgView).offset(29);
        make.right.equalTo(self.whiteBgView).offset(-10);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(29);
    }];
    
    self.timeLabel = [MYBaseView labelWithFrame:CGRectZero text:nil textColor:nil textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
    [ballImageView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ballImageView);
    }];
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",self.timeNum];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showNum) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantPast]];

}

- (void)showNum{
    if (self.timeNum == 0) {
        [self.timer invalidate];
        self.timer = nil;
        if (self.tapBlock) {
            self.tapBlock();
        }
    }else{
        self.timeNum --;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%ld",self.timeNum];
    if (self.timeNum == 0) {
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#fc2929" alpha:1.0];
    }
    if (self.timeNum == 1 || self.timeNum == 2) {
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#f64b1d" alpha:1.0];
    }
    if (self.timeNum == 3 || self.timeNum == 4) {
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#fa6633" alpha:1.0];
    }
    if (self.timeNum == 5 || self.timeNum == 6) {
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#fb8c42" alpha:1.0];
    }
    if (self.timeNum == 7 || self.timeNum == 8) {
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#f8b03f" alpha:1.0];
    }
    if (self.timeNum == 9 || self.timeNum == 10) {
        self.timeLabel.textColor = [UIColor colorWithHexString:@"#d3ad46" alpha:1.0];
    }
}

- (void)initSingleProduct{
    UIImageView *pdtImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
    [self.whiteBgView addSubview:pdtImageView];
    [pdtImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.whiteBgView);
        make.top.equalTo(self.whiteBgView).offset(60);
        make.width.height.mas_equalTo(230);
    }];
    pdtImageView.backgroundColor = [UIColor lightGrayColor];
    pdtImageView.layer.cornerRadius = 12;
    
    UIImageView *hotImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"抢"]];
    [pdtImageView addSubview:hotImageView];
    [hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(pdtImageView);
        make.width.height.mas_equalTo(50);
    }];
    
    UILabel *nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"艾克斯臣秋冬套装白色毛衣+格子短裤英伦风经典" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
    [self.whiteBgView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pdtImageView.mas_bottom).offset(10);
        make.left.equalTo(pdtImageView);
        make.centerX.equalTo(pdtImageView);
    }];
    nameLabel.numberOfLines = 0;
    
    UIButton *bottomButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"领券购买底部"] selectImage:nil];
    [self.whiteBgView addSubview:bottomButton];
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBgView);
        make.bottom.equalTo(self.whiteBgView.mas_bottom);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(40);
    }];
    bottomButton.userInteractionEnabled = YES;
    
    UILabel *couponPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"立即领40元券" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(15)];
    [bottomButton addSubview:couponPriceLabel];
    [couponPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomButton);
    }];
    
    UIImageView *couponImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"券后价"]];;
    [self.whiteBgView addSubview:couponImageView];
    [couponImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pdtImageView);
        make.bottom.equalTo(bottomButton.mas_top).offset(-15);
        make.width.mas_equalTo(49);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *priceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"¥160" textColor:[UIColor colorWithHexString:TZ_LIGHT_RED alpha:1] textAlignment:NSTextAlignmentLeft andFont:kFont(18)];
    [self.whiteBgView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(couponImageView.mas_right).offset(5);
        make.centerY.equalTo(couponImageView);
    }];
    priceLabel.attributedText = [NSString stringWithString:priceLabel.text Range:NSMakeRange(0, 1) color:nil font:kFont(12)];
    
    UILabel *tbPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"淘宝价 ¥210" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
    [self.whiteBgView addSubview:tbPriceLabel];
    [tbPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_right).offset(11);
        make.centerY.equalTo(couponImageView);
    }];
    tbPriceLabel.attributedText = [NSString addThroughLineWithString:tbPriceLabel.text Color:[UIColor colorWithHexString:TZ_GRAY alpha:1.0]];
    
    TZServiceGoodsModel *model = self.dataArray[0];
    [pdtImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    nameLabel.text = model.title;
    couponPriceLabel.text = [NSString stringWithFormat:@"立即领%.2f元券",model.couponPrice];
    priceLabel.text = [NSString stringWithFormat:@"¥%.2f",model.price - model.couponPrice];
    tbPriceLabel.text = [NSString stringWithFormat:@"淘宝价 ¥%.2f",model.price];
    [[bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.pdtBlock) {
            self.pdtBlock(model);
        }
    }];

}

//多个推荐
- (void)initMultipleView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, 290, 410-65) style:UITableViewStylePlain];
    [self.whiteBgView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor colorWithHexString:@"#dfdfdf" alpha:1.0];
}


#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor colorWithHexString:@"#dfdfdf" alpha:1.0]];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TZHomeRecommandCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TZHomeRecommandCell class])];
    if (cell == nil) {
        cell = [[TZHomeRecommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TZHomeRecommandCell class])];
    }
    [cell setCellInfoWithModel:self.dataArray[indexPath.row]];
    return cell;
}

#pragma mark - tableViewDelagete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.pdtBlock) {
        self.pdtBlock(self.dataArray[indexPath.row]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
