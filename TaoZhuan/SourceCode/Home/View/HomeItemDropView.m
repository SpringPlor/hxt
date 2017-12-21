//
//  HomeItemDropView.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/10/9.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "HomeItemDropView.h"

@implementation HomeItemDropView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgView = [MYBaseView viewWithFrame:CGRectZero backgroundColor:[UIColor blackColor]];
        [kWindow addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(kWindow);
            make.center.equalTo(kWindow);
        }];
        self.bgView.alpha = 0.3;
        [self.bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
        
        self.whiteBgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) backgroundColor:[UIColor whiteColor]];
        [self addSubview:self.whiteBgView];
        self.whiteBgView.clipsToBounds = YES;
        
        UIImageView *sortImageView = [MYBaseView imageViewWithFrame:CGRectZero andImage:[UIImage imageNamed:@"fenlei"]];
        [self.whiteBgView addSubview:sortImageView];
        [sortImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(15);
            make.width.mas_equalTo(18);
            make.height.mas_equalTo(15);
        }];
        
        UIButton *cancelButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:@"quxiao"] selectImage:nil];
        [self.whiteBgView addSubview:cancelButton];
        [cancelButton addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(sortImageView);
            make.width.height.mas_equalTo(15);
        }];
        cancelButton.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, -20, -20);
        
        UILabel *titleLabel = [MYBaseView labelWithFrame:CGRectZero text:@"全部分类" textColor:[UIColor colorWithHexString:TZ_GRAY alpha:1.0] textAlignment:NSTextAlignmentLeft andFont:kFont(14)];
        [self.whiteBgView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sortImageView.mas_right).offset(5);
            make.centerY.equalTo(sortImageView);
        }];
        CGFloat itemWidth = (SCREEN_WIDTH-15*5)/4;
        NSArray *itemArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeItem" ofType:@"plist"]];
        self.dataArray = [NSMutableArray array];
        [self.dataArray addObjectsFromArray:itemArray];
        [self.dataArray removeObjectAtIndex:0];
        
        TZHomeItemModel *homeModel =  [TZHomeItemModel mj_objectWithKeyValues:UserDefaultsOFK(Home_Item)];
        for (int i = 0; i < self.dataArray.count; i++){
            TZHomeItemModel *itemModel = [TZHomeItemModel mj_objectWithKeyValues:self.dataArray[i]];
            UIButton *itemButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom title:itemModel.title titleColor:[UIColor colorWithHexString:TZ_BLACK alpha:1.0] font:kFont(13)];
            [self.whiteBgView addSubview:itemButton];
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(15+(itemWidth+15)*(i%4));
                make.top.equalTo(titleLabel.mas_bottom).offset(15+45*(i/4));
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(30);
            }];
            itemButton.layer.borderColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0].CGColor;
            itemButton.layer.borderWidth = 0.5f;
            itemButton.layer.cornerRadius = 5;
            [itemButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            itemButton.backgroundColor = [UIColor whiteColor];
            itemButton.clipsToBounds = YES;
            
            [itemButton addTarget:self action:@selector(itemTap:) forControlEvents:UIControlEventTouchUpInside];
            itemButton.tag = 1200+i;
            if (homeModel) {
                if ([homeModel.title isEqualToString:itemModel.title]) {
                    itemButton.selected = YES;
                    itemButton.layer.borderColor = [UIColor redColor].CGColor;
                }
            }else{
                if (i == 0) {
                    itemButton.selected = YES;
                    itemButton.layer.borderColor = [UIColor redColor].CGColor;
                }
            }
        }
    }
    return self;
}

- (void)hideView{
    self.tapBlock(nil);
}

- (void)itemTap:(UIButton *)sender{
    for (int i = 0; i < self.dataArray.count; i++){
        UIButton *itemButton = (UIButton *)[self viewWithTag:1200+i];
        itemButton.layer.borderColor = [UIColor colorWithHexString:TZ_BLACK alpha:1.0].CGColor;
        itemButton.selected = NO;
    }
    sender.selected = YES;
    sender.layer.borderColor = [UIColor redColor].CGColor;
    self.tapBlock([TZHomeItemModel mj_objectWithKeyValues:self.dataArray[sender.tag-1200]]);
    [self MobClickWithIndex:sender.tag -1200];
}

- (void)MobClickWithIndex:(NSInteger)index{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        switch (index) {
            case 0:
                [MobClick event:nanzhuang];
                break;
            case 1:
                [MobClick event:nvzhuang];
                break;
            case 2:
                [MobClick event:neiyi];
                break;
            case 3:
                [MobClick event:muying];
                break;
            case 4:
                break;
            case 5:
                break;
            case 6:
                [MobClick event:xiebao];
                break;
            case 7:
                [MobClick event:meishi];
                break;
            case 8:
                [MobClick event:wenti];
                break;
            case 9:
                [MobClick event:shuma];
                break;
            case 10:
                [MobClick event:qita];
                break;
            default:
                break;
        }
    });
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
