//
//  TZShareProductView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/12/6.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZShareProductView.h"

@interface TZShareProductView()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation TZShareProductView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andImage:[UIImage imageNamed:@"blackclearbg"]];
        [self addSubview:self.bgView];
        self.bgView.userInteractionEnabled = YES;
        [self.bgView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
            
        }]];
        
        UIButton *cancelButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"取消" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(18)];
        [self addSubview:cancelButton];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.bottom.equalTo(self.mas_bottom).offset(-20);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(45);
        }];
        cancelButton.backgroundColor = [UIColor whiteColor];
        cancelButton.layer.cornerRadius = 5;
        [[cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if (self.removeBlock) {
                self.removeBlock(9999);
            }
        }];
        
        //CGRectMake(15, SCREEN_HEIGHT-20-45-10-344*kScale, SCREEN_WIDTH-30, 344*kScale)
        self.whiteBgView = [MYBaseView viewWithFrame:CGRectZero  backgroundColor:[UIColor whiteColor]];
        [self addSubview:self.whiteBgView];
        [self.whiteBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cancelButton.mas_top).offset(-10);
            make.left.equalTo(self).offset(15);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(344*kScale);
        }];
        self.whiteBgView.layer.cornerRadius = 6;
        
        UIImageView *noteImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"折页"]];
        [self.whiteBgView addSubview:noteImageView];
        [noteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.whiteBgView).offset(10);
            make.centerX.mas_equalTo(self.whiteBgView);
            make.height.mas_equalTo(179*kScale);
        }];
        noteImageView.userInteractionEnabled = YES;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [noteImageView addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(noteImageView);
            make.center.equalTo(noteImageView);
        }];
        self.scrollView.bounces = NO;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        UILabel *namaLabel = [MYBaseView labelWithFrame:CGRectZero text:@"规范健康属地管理发快递老顾客解放东路了古代诗歌发到空间" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.scrollView addSubview:namaLabel];
        [namaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(10);
            make.top.equalTo(self.scrollView).offset(8*kScale);
            make.centerX.equalTo(self.scrollView);
        }];
        namaLabel.numberOfLines = 0;
        
        UILabel *oriPrice = [MYBaseView labelWithFrame:CGRectZero text:@"【原价】" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.scrollView addSubview:oriPrice];
        [oriPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(10*kScale);
            make.top.equalTo(namaLabel.mas_bottom).offset(8*kScale);
        }];
        
        UILabel *currentPrice = [MYBaseView labelWithFrame:CGRectZero text:@"【券后价】" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.scrollView addSubview:currentPrice];
        [currentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(10*kScale);
            make.top.equalTo(oriPrice.mas_bottom).offset(8*kScale);
        }];
        
        UILabel *recommandLabel = [MYBaseView labelWithFrame:CGRectZero text:@"推荐理由：" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.scrollView addSubview:recommandLabel];
        [recommandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(10*kScale);
            make.top.equalTo(currentPrice.mas_bottom).offset(20*kScale);
            make.centerX.equalTo(self.scrollView);
        }];
        recommandLabel.numberOfLines = 0;
        
        UILabel *messageLabel = [MYBaseView labelWithFrame:CGRectZero text:@"复制消息打开淘宝" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.scrollView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(10*kScale);
            make.top.equalTo(recommandLabel.mas_bottom).offset(15*kScale);
            make.centerX.equalTo(self.scrollView);
        }];
        messageLabel.numberOfLines = 0;
        
        UILabel *webLabel = [MYBaseView labelWithFrame:CGRectZero text:@"优惠信息：www.baidu.com" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(12)];
        [self.scrollView addSubview:webLabel];
        [webLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView).offset(10*kScale);
            make.top.equalTo(messageLabel.mas_bottom).offset(8*kScale);
            make.centerX.equalTo(self.scrollView);
        }];
        webLabel.hidden = YES;
        
        UIButton *copyButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:@"仅复制文案" titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(14)];
        [self.whiteBgView addSubview:copyButton];
        [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(noteImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self.whiteBgView);
            make.width.mas_equalTo(140);
            make.height.mas_equalTo(30);
        }];
        copyButton.layer.cornerRadius = 4;
        copyButton.layer.borderColor = [UIColor colorWithHexString:TZ_LIGHT_RED alpha:1.0].CGColor;
        copyButton.layer.borderWidth = 0.5;
        copyButton.userInteractionEnabled = YES;
        @weakify(self);
        [[copyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSMutableString *string = [NSMutableString string];
            [string appendString:[NSString stringWithFormat:@"%@\n",namaLabel.text]];
            [string appendString:[NSString stringWithFormat:@"%@\n",oriPrice.text]];
            [string appendString:[NSString stringWithFormat:@"%@\n",currentPrice.text]];
            [string appendString:[NSString stringWithFormat:@"%@\n",recommandLabel.text]];
            [string appendString:[NSString stringWithFormat:@"%@\n",messageLabel.text]];
            [[UIPasteboard generalPasteboard] setString:string];
            [SVProgressHUD showSuccessWithStatus:@"复制成功"];
        }];
        
        NSArray *imageArray = @[@"朋友圈icon",@"微信icon",@"QQ空间icon",@"qqicon"];
        NSArray *titleArray = @[@"朋友圈",@"微信",@"QQ空间",@"QQ"];
        //CGRectMake(i*(SCREEN_WIDTH-30)/4, 344-25-80, (SCREEN_WIDTH-30)/4, 80)
        for (int i = 0 ; i < 4; i ++) {
            UIButton *button = [MYBaseView buttonWithFrame:CGRectZero image:[UIImage imageNamed:imageArray[i]] title:titleArray[i] titleColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] font:kFont(11)];
            [self.whiteBgView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.whiteBgView).offset(i*(SCREEN_WIDTH-30)/4);
                make.top.equalTo(copyButton.mas_bottom).offset(15*kScale);
                make.width.mas_equalTo((SCREEN_WIDTH-30)/4);
                make.height.mas_equalTo(80);
            }];
            [button setButtonImageTitleStyle:ButtonImageTitleStyleTop padding:6];
            button.tag = i;
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *sender) {
                if (self.removeBlock) {
                    self.removeBlock(sender.tag);
                }
            }];
        }
        [RACObserve(self, model) subscribeNext:^(id model) {
            if ([model isKindOfClass:[TZTaoBaoProductModel class]]) {
                TZTaoBaoProductModel *tbModel = model;
                namaLabel.text = [ZMUtils filterHTML:tbModel.title];
                oriPrice.text = [NSString stringWithFormat:@"【原价】%.2f",tbModel.couponAmount+tbModel.zkPrice];
                currentPrice.text = [NSString stringWithFormat:@"【券后价】%.2f",tbModel.zkPrice];
                recommandLabel.text = [NSString stringWithFormat:@"推荐理由：%@",@"实惠好货，品优价廉，抢到就是赚到"];
                CGFloat height = [NSString stringHightWithString:recommandLabel.text size:CGSizeMake(SCREEN_WIDTH-30-20*kScale, MAXFLOAT) font:kFont(12) lineSpacing:defaultLineSpacing].height;
                self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH-30-20, 179*kScale+height);
            }
            
            if ([model isKindOfClass:[TZServiceGoodsModel class]]) {
                TZServiceGoodsModel *serviceModel = model;
                namaLabel.text = [ZMUtils filterHTML:serviceModel.title];
                oriPrice.text = [NSString stringWithFormat:@"【原价】%.2f",serviceModel.price];
                currentPrice.text = [NSString stringWithFormat:@"【券后价】%.2f",serviceModel.price- serviceModel.couponPrice];
                recommandLabel.text = [NSString stringWithFormat:@"推荐理由：%@",serviceModel.describe == nil ? @"实惠好货，品优价廉，抢到就是赚到" : serviceModel.describe];
                CGFloat height = [NSString stringHightWithString:recommandLabel.text size:CGSizeMake(SCREEN_WIDTH-30-20*kScale, MAXFLOAT) font:kFont(12) lineSpacing:defaultLineSpacing].height;
                self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH-30-20, 179*kScale+height);
            }
            
            if ([model isKindOfClass:[TZSearchProductModel class]]) {
                TZSearchProductModel *dwjModel = model;
                namaLabel.text = [ZMUtils filterHTML:dwjModel.pdttitle];
                oriPrice.text = [NSString stringWithFormat:@"【原价】%.2f",[dwjModel.pdtprice floatValue]];
                currentPrice.text = [NSString stringWithFormat:@"【券后价】%.2f",[dwjModel.pdtbuy floatValue]];
                recommandLabel.text = [NSString stringWithFormat:@"推荐理由：%@",dwjModel.pdtdesc == nil ? @"实惠好货，品优价廉，抢到就是赚到" : dwjModel.pdtdesc];
                
                CGFloat height = [NSString stringHightWithString:recommandLabel.text size:CGSizeMake(SCREEN_WIDTH-30-20*kScale, MAXFLOAT) font:kFont(12) lineSpacing:defaultLineSpacing].height;
                self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH-30-20, 179*kScale+height);

            }
        }];
        [RACObserve(self, taoToken) subscribeNext:^(NSString *token) {
            messageLabel.text = [NSString stringWithFormat:@"%@ 复制这条消息，打开[手机淘宝]即可抢购更多",token];
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
