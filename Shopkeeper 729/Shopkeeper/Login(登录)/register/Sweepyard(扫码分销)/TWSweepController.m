//
//  TWSweepController.m
//  TWCompare
//
//  Created by TianView on 16/6/23.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWSweepController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "TWDescController.h"
#import "Masonry.h"
#import "LoginController.h"
#import "TWRegiModel.h"
#import "PrefixHeader.pch"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TWSweepController ()<AVCaptureMetadataOutputObjectsDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *scanRectView;
@property (nonatomic ,strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preView;
@property (nonatomic, strong) UIWebView *webView;

@property(copy,nonatomic)NSString * passvalnn;


///记录向上滑动最小边界
@property (nonatomic, assign) CGFloat minY;
///记录向下滑动最大边界
@property (nonatomic, assign) CGFloat maxY;
///扫描区域图片
@property (nonatomic, strong) UIImageView *imageV;
///扫描区域的横线是否是应该向上跑动
@property (nonatomic, assign) BOOL shouldUp;

@end

@implementation TWSweepController

- (void)viewWillAppear:(BOOL)animated {
    //    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    //    self.navigationController.navigationBar.barTintColor = [UIColor navColor2];
    [self.session startRunning];
}
- (void)notfication{
    
    
   // LoginController * login = [[LoginController alloc]init];
      [self.navigationController popViewControllerAnimated:NO];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor yellowColor];
    
    
    self.title = @"扫一扫";
    
    [self sweepView];
    
    
    NSLog(@"ddddddd");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notfication) name:@"aa" object:nil];
    
    
}


//- (void)back:(UIBarButtonItem *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//
//  //  TWLoginController * login =[[TWLoginController alloc]init];
//
//   // [self dismissViewControllerAnimated:YES completion:nil];
//    [self.session stopRunning];
//
//}

///扫描时从上往下跑动的线以及提示语
- (void)scanningAnimationWith:(CGRect) rect {
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat with = rect.size.width;
    CGFloat height = rect.size.height;
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, with, 3)];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"scanLine" ofType:@"png"];
    self.imageV.image = [UIImage imageWithContentsOfFile:imagePath];
    self.shouldUp = NO;
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(repeatAction) userInfo:nil repeats:YES];
    [self.view addSubview:self.imageV];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(x, y + height, with, 30)];
    lable.text = @"请将扫描区域对准二维码";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    [self.view addSubview:lable];
    
    
}
- (void)repeatAction {
    CGFloat num = 1;
    if (self.shouldUp == NO) {
        self.imageV.frame = CGRectMake(CGRectGetMinX(self.imageV.frame), CGRectGetMinY(self.imageV.frame) + num, CGRectGetWidth(self.imageV.frame), CGRectGetHeight(self.imageV.frame));
        if (CGRectGetMaxY(self.imageV.frame) >= self.maxY) {
            self.shouldUp = YES;
        }
    }else {
        self.imageV.frame = CGRectMake(CGRectGetMinX(self.imageV.frame), CGRectGetMinY(self.imageV.frame) - num, CGRectGetWidth(self.imageV.frame), CGRectGetHeight(self.imageV.frame));
        if (CGRectGetMinY(self.imageV.frame) <= self.minY) {
            self.shouldUp = NO;
        }
    }
}

///获取扫描区域的坐标
- (void)getCGRect:(CGRect)rect {
    CGFloat with = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat x = CGRectGetMinX(rect);
    CGFloat y = CGRectGetMinY(rect);
    CGFloat w = CGRectGetWidth(rect);
    CGFloat h = CGRectGetHeight(rect);
    [self creatFuzzyViewWith:CGRectMake(0, 0, with, y)];
    [self creatFuzzyViewWith:CGRectMake(0, y, x, h)];
    [self creatFuzzyViewWith:CGRectMake(x + w, y, with - x - w, h)];
    [self creatFuzzyViewWith:CGRectMake(0, y + h, with, height - h - y)];
}
///创建扫描区域之外的模糊效果
- (void)creatFuzzyViewWith :(CGRect)rect {
    UIView *view11 = [[UIView alloc] initWithFrame:rect];
    view11.backgroundColor = [UIColor blackColor];
    view11.alpha = 0.4;
    
    [self.view addSubview:view11];
    
    UIView * v = [[UIView alloc]init];
    v.frame = CGRectMake(0, 0, self.view.frame.size.width, 90);
    v.backgroundColor = [UIColor blackColor];
    v.alpha = 0.1;
    [self.view addSubview:v];
    
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];

    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [v addSubview:leftButton];

    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(v.mas_left).offset(10);
        make.top.equalTo(v.mas_top).offset(35);
        make.size.mas_equalTo(CGSizeMake(60, 30));
        
    }];
    
}

- (void)backView{
    
    [self.navigationController popViewControllerAnimated:YES];

    [self.session stopRunning];

}



- (void)sweepView {
    ///获取摄像设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    ///创建输入流
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    ///创建输出流
    self.output = [[AVCaptureMetadataOutput alloc]init];
    ///设置代理,在主线程里面刷新
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    ///初始化连接对象
    self.session = [[AVCaptureSession alloc]init];
    ///高质量采集率
    [self.session setSessionPreset:(ScreenHeight<500?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh)];
    ///链接对象添加输入流和输出流
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    ///AVMetadataMachineReadableCodeObject对象从QR码生成返回这个常数作为他们的类型
    ///设置扫码支持的编码格式(设置条码和二维码兼容扫描)
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    ///自定义取景框
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    CGSize scanSize = CGSizeMake(windowSize.width*3/4, windowSize.width*3/4);
    CGRect scanRect = CGRectMake((windowSize.width-scanSize.width)/2, (windowSize.height-scanSize.height)/2, scanSize.width, scanSize.height);
    NSLog(@"%.f----%.f---%.f----%.f", scanRect.origin.x, scanRect.origin.y, scanRect.size.width, scanRect.size.height);
    
    /**
     *  横线开始上下滑动
     */
    [self scanningAnimationWith:scanRect];
    //创建周围模糊区域
    [self getCGRect:scanRect];
    self.minY = CGRectGetMinY(scanRect);
    self.maxY = CGRectGetMaxY(scanRect);

    //计算rectOfInterest 注意x,y交换位置
    scanRect = CGRectMake(scanRect.origin.y/windowSize.height, scanRect.origin.x/windowSize.width, scanRect.size.height/windowSize.height,scanRect.size.width/windowSize.width);
    self.output.rectOfInterest = scanRect;
    
    self.scanRectView = [UIView new];
    [self.view addSubview:self.scanRectView];
    self.scanRectView.frame = CGRectMake(0, 0, scanSize.width, scanSize.height);
    self.scanRectView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    //    self.scanRectView.layer.borderColor = [UIColor purpleColor].CGColor;
    self.scanRectView.layer.borderWidth = 1;
    self.output.rectOfInterest = scanRect;
    self.preView = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preView.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preView.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:self.preView atIndex:0];
    
    ///开始捕获
    //    [self.session startRunning];
    ////读取二维码iOS7以后支持.
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    ///系统处于铃声模式下扫描到结果会调用"卡擦"声音;
    AudioServicesPlaySystemSound(1305);
    ///系统处于震动模式扫描到结果会震动一下;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    //为零表示没有捕捉到信息,返回重新捕捉
    if (metadataObjects.count == 0) {
        return;
    }
    //不为零则为捕捉并成功存储了二维码
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *currentMetadataObject = metadataObjects.firstObject;
     //   http://store526.ejoydg.com/fenxiao.html
        
       //输出扫描字符串
        NSLog(@"currentMetadataObject.stringValue == %@",currentMetadataObject.stringValue);
        
        NSString * ADAD =[NSString stringWithFormat:@"%@",currentMetadataObject.stringValue];
        NSLog(@"XXXXX:%@",ADAD);

    //    NSString * strin = @"http://store325435433.ejoydg.com/fenxiao.html?rid=3";
        
        
        if ([ADAD hasPrefix:@"http://store"]) {
            
            NSString * url = [NSString stringWithFormat:@"%@",currentMetadataObject.stringValue];
            NSRange range = [url rangeOfString:@"."];
            url = [url substringWithRange:NSMakeRange(0, range.location)];
            NSString * t =[url substringWithRange:NSMakeRange(12, url.length - 12)];
            
          //  NSLog(@"url:%@",url);
            
           
            erWeiMaC = [[TWDescController alloc] init];
            
            UINavigationController *nacV = [[UINavigationController alloc] initWithRootViewController:erWeiMaC];
            //网址传到下一个页面
            erWeiMaC.myUrl = currentMetadataObject.stringValue;
            //把story_id传到下个页面
            erWeiMaC.story_id = t;
            erWeiMaC.storetype = @"2";
            NSLog(@"erWeiMaC.storetype:%@",erWeiMaC.storetype);
            
            dispatch_async(dispatch_get_main_queue(), ^{

                [self presentViewController:nacV animated:YES completion:nil];
            });
            //  http://www.tianview.com/api-ydz_getstoreinfo_byid.html?id=526
        }else if([ADAD hasSuffix:@"http://www.tianview.com/"]){

            NSString * url = [NSString stringWithFormat:@"%@",currentMetadataObject.stringValue];
            NSRange range = [url rangeOfString:@"."];
            url = [url substringWithRange:NSMakeRange(0, range.location)];
            NSString * t =[url substringWithRange:NSMakeRange(54, url.length - 54)];
            NSLog(@"t:%@",t);
            erWeiMaC.story_id = t;
            
            NSLog(@"url:%@",url);
            
            

            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//               [self.navigationController popViewControllerAnimated:YES];
//                
//            });
    
        }else{
        
        [self SentientbeingspromptboxView:@"不是有效的分销二维码，请重新扫描!"];
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//              
//                
//                [self.session startRunning];
//                
//                [self sweepView];
//                
//            });
    
   
        }
        
        
        /**
         *  这里不再判断扫描结果是否是可用网址链接,直接跳转至下界面,下界面判如果是可用网址链接则webView加载,否则直接显示出来;
         */
        
        //                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"结果" message:currentMetadataObject.stringValue preferredStyle:UIAlertControllerStyleAlert];
        //                __weak SweepViewController *weakSelf = self;
        //                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //     //   是http链接跳转到web界面
        //                    if ([currentMetadataObject.stringValue containsString:@"http"]) {
        //                        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:currentMetadataObject.stringValue]];
        //                        [weakSelf.webView loadRequest:request];
        //                        ErWeiMaViewController *erWeiMaC = [[ErWeiMaViewController alloc] init];
        //                         erWeiMaC.myUrl = currentMetadataObject.stringValue;
        //                        dispatch_async(dispatch_get_main_queue(), ^{
        //                            [weakSelf.navigationController pushViewController:erWeiMaC animated:NO];
        //                        });
        //                    }else {
        //                        //开始捕捉
        //                        [self.session startRunning];
        //                    }
        
#define mark4 老代码 如果直接加载网址则会出现以下问题:二维码扫描跳转后,webView界面的界面下方无法全屏,并且返回时无法重新调用相机,卡死..
        
        
    }
}

#pragma mark -------提示框 -------
- (void)SentientbeingspromptboxView:(NSString *)text{
    
    UILabel * lab = [[UILabel alloc]init];
    
    lab.numberOfLines = 0;
    
    lab.font = [UIFont systemFontOfSize:14.0];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    lab.layer.cornerRadius = 10;
    
    lab.text = text;
    
    lab.textColor = [UIColor whiteColor];
    
    lab.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0];
    
    [self.view addSubview:lab];
    
    [UIView animateWithDuration:4.0 animations:^{
        
        lab.alpha = 0.0;
        
    }];
    
    [lab performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 160, 60));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-200);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
