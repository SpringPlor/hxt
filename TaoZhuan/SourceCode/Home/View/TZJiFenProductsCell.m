//
//  TZJiFenProductsCell.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/10.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZJiFenProductsCell.h"

@implementation TZJiFenProductsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSeperatorInsetToZero:10];
        
        self.picImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:nil];
        [self.contentView addSubview:self.picImageView];
        self.picImageView.backgroundColor = [UIColor lightGrayColor];
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(10);
            make.width.height.mas_equalTo(105);
        }];
        
        self.nameLabel = [MYBaseView labelWithFrame:CGRectZero text:@"美国美德乐250ML婴儿储奶瓶奶瓶PP2个装大容量储奶" textColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(13)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.picImageView).offset(5);
        }];
        self.nameLabel.numberOfLines = 0;
        
        self.jifenLabel = [MYBaseView labelWithFrame:CGRectZero text:@"9.9积分" textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft andFont:kFont(17)];
        [self.contentView addSubview:self.jifenLabel];
        [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.picImageView.mas_right).offset(10);
            make.bottom.equalTo(self.picImageView.mas_bottom).offset(-5);
        }];
        self.jifenLabel.attributedText = [NSString stringWithString:self.jifenLabel.text Range:NSMakeRange(self.jifenLabel.text.length-3, 3) color:nil font:kFont(12)];
        
        self.oriPriceLabel = [MYBaseView labelWithFrame:CGRectZero text:@"¥ 19.9" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(11)];
        [self.contentView addSubview:self.oriPriceLabel];
        [self.oriPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.jifenLabel.mas_right).offset(5);
            make.bottom.equalTo(self.jifenLabel.mas_bottom);
        }];
        
        self.hotImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"dhbutton"]];
        [self.contentView addSubview:self.hotImageView];
        [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.jifenLabel);
            make.width.mas_equalTo(81);
            make.height.mas_equalTo(30);
        }];
        self.hotImageView.userInteractionEnabled = YES;
        [self.hotImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exchangeAction:)]];
        
        UILabel *jfdhLabel = [MYBaseView labelWithFrame:CGRectZero text:@"立即兑换" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter andFont:kFont(14)];
        [self.hotImageView addSubview:jfdhLabel];
        [jfdhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.hotImageView);
        }];
    }
    return self;
}

- (void)exchangeAction:(UITapGestureRecognizer *)sender{
    if (self.exchangeBlock) {
        self.exchangeBlock();
    }
}

- (void)setCellInfoWithModel:(TZJFProductModel *)model{
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"商品加载图片"]];
    NSString *jfString = [NSString stringWithFormat:@"%d积分",(int)model.integral];
    self.jifenLabel.attributedText = [NSString stringWithString:jfString Range:NSMakeRange(jfString.length-2, 2) color:nil font:kFont(12)];
    self.oriPriceLabel.text = [NSString stringWithFormat:@"¥ %@",model.marketPrice];
    self.nameLabel.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
