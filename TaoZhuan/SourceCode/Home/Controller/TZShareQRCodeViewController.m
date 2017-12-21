//
//  TZShareQRCodeViewController.m
//  TaoZhuan
//
//  Created by 彭佳伟 on 2017/11/3.
//  Copyright © 2017年 Jwpeng. All rights reserved.
//

#import "TZShareQRCodeViewController.h"
#import "TZKeyChain.h"
#import "TZThirdShare.h"
#import "TZSearchProductViewModel.h"

@interface TZShareQRCodeViewController ()

@property (nonatomic,strong) UIImageView *shareImage;
@property (nonatomic,strong) UIImageView *qrCodeImage;
@property (nonatomic,strong) UIView *blackBgView;
@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) UIImage *thirdImage;
@property (nonatomic,strong) TZSearchProductViewModel *viewModel;

@end

@implementation TZShareQRCodeViewController

- (NSString *)title{
    return @"分享二维码";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fenxiangimg"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self initView];
    [self bindingCommand];
    [self initShareUI];
    // Do any additional setup after loading the view.
}

- (void)initView{
    self.shareImage = [MYBaseView imageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) andImage:[UIImage imageNamed:@"分享二维码"]];
    [self.view addSubview:self.shareImage];
}

- (void)share{
    self.blackBgView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteBgView.frame = CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100);
    }];
}

- (void)bindingCommand{
    // 3. 将字符串转换成NSData
    NSData *UUID = [TZKeyChain load:kUUIDKeyChainKey];
    NSString *deviceUUID = [[NSString alloc] initWithData:UUID encoding:NSUTF8StringEncoding];
    NSString *shareUrl = [NSString stringWithFormat:@"http://www.0760jeans.cn:9000/down?invitationCode=%@",self.inviteCode];
    self.viewModel = [TZSearchProductViewModel new];
    [[self.viewModel.shortUrlCommand.executionSignals switchToLatest] subscribeNext:^(NSString *url) {
        [self getQRCodeImageWithShareUrl:url];
    }];
    
    [self.viewModel.shortUrlCommand execute:@{@"url":shareUrl}];
}

- (void)getQRCodeImageWithShareUrl:(NSString *)shareUrl{
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    NSData *data = [shareUrl dataUsingEncoding:NSUTF8StringEncoding];
    // 4. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示 (此时获取到的二维码比较模糊,所以需要用下面的createNonInterpolatedUIImageFormCIImage方法重绘二维码)
    //UIImage *codeImage = [UIImage imageWithCIImage:outputImage scale:1.0 orientation:UIImageOrientationUp];
    
    UIImageView *wechatImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.shareImage addSubview:wechatImageView];
    if (SCREEN_WIDTH < 375) {
        [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.shareImage.mas_bottom).offset(-34*kScale);
            make.width.height.mas_offset(110*kScale);
        }];
    }else if (SCREEN_WIDTH == 375){
        [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.shareImage.mas_bottom).offset(-34*kScale);
            make.width.height.mas_offset(110*kScale);
        }];
    }else{
        [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.shareImage.mas_bottom).offset(-36*kScale);
            make.width.height.mas_offset(110*kScale);
        }];
    }
    wechatImageView.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:110*kScale];//重绘二维码,使其显示清晰
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size{

    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

//截图
- (UIImage *)imageFromView: (UIView *)theView atFrame:(CGRect)r{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

- (void)initShareUI{
    self.blackBgView = [MYBaseView viewWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT) backgroundColor:[UIColor blackColor]];
    [kWindow addSubview:self.blackBgView];
    self.blackBgView.alpha = 0.3;
    self.blackBgView.hidden = YES;
    WeakSelf(self);
    [self.blackBgView addGestureRecognizer:[UITapGestureRecognizer nvm_gestureRecognizerWithActionBlock:^(id sender) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.whiteBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 100);
        } completion:^(BOOL finished) {
            self.blackBgView.hidden = YES;
        }];
    }]];
    
    CGFloat spaceWith = ((SCREEN_WIDTH-100)-48*4)/3;
    NSArray *iconArray = @[@"fxpengyouquan",@"fxweixin",@"fxkongjian",@"fxqq"];
    self.whiteBgView = [MYBaseView viewWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 100) backgroundColor:[UIColor whiteColor]];
    [kWindow addSubview:self.whiteBgView];
    for (int i = 0; i < iconArray.count; i ++) {
        UIButton *iconButton = [MYBaseView buttonWithFrame:CGRectZero buttonType:UIButtonTypeCustom image:[UIImage imageNamed:iconArray[i]] selectImage:nil];
        [self.whiteBgView addSubview:iconButton];
        [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteBgView).offset(50+(48+spaceWith)*i);
            make.centerY.equalTo(self.whiteBgView);
            make.width.height.mas_equalTo(48);
        }];
        [iconButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        iconButton.tag = 1000+i;
    }
}

- (void)shareAction:(UIButton *)sender{
    if (self.thirdImage == nil) {
        if (@available(iOS 11.0, *)){
            self.thirdImage = [self imageFromView:self.shareImage atFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        }else{
            self.thirdImage = [self imageFromView:self.shareImage atFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        }
    }
    switch (sender.tag - 1000) {
        case 0:
        {
            [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_WechatTimeLine image:self.thirdImage];
        }
            break;
        case 1:
        {
            [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_WechatSession image:self.thirdImage];

        }
            break;
        case 2:
        {
            [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_Qzone image:self.thirdImage];
        }
            break;
        case 3:
        {
            [TZThirdShare shareQRCodeToAppWith:UMSocialPlatformType_QQ image:self.thirdImage];
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.whiteBgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 100);
    } completion:^(BOOL finished) {
        self.blackBgView.hidden = YES;
    }];
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
