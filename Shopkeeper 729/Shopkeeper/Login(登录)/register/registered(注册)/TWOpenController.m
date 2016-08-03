//
//  TWOpenController.m
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWOpenController.h"
#import "Masonry.h"
#import "LoginController.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "Reachability.h"
#import "UIImageView+WebCache.h"
#import "UIImage+WebP.h"
#import "TWRegistController.h"


#define UISCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREENHEIGHT [UIScreen mainScreen].bounds.size.height
void UIImageWriteToSavedPhotosAlbum (
                                     UIImage  *image,
                                     id       completionTarget,
                                     SEL      completionSelector,
                                     void     *contextInfo
                                     );

@interface TWOpenController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL b;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIImageView * imageViewCode;//二维码
@property (nonatomic,strong) UIImageView * imageViewFenXiao;//分销二维码
@property (nonatomic,strong)UITapGestureRecognizer *tap;
@property (nonatomic,strong)UITapGestureRecognizer *tap1;
@property (nonatomic,strong)UITapGestureRecognizer *tap2;

@property (nonatomic,strong)AFHTTPSessionManager * sessionmanager;
@property (nonatomic,strong)NSArray *  array;


@end

@implementation TWOpenController

-(void)createNavbar{


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self NetWork];
    
    [self setattribute];
    
    self.b = YES;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
  
}
//初始化
- (void)setattribute{
    
    backView = [[UIView alloc]init];
    
    backView.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
    
    // backView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@100);
        make.top.equalTo(self.view.mas_top).offset(40);
        
    }];
    

    imageview = [[UIImageView alloc]init];
    
    UIImage * img =[UIImage imageNamed:@"select_shen"];
    
    imageview.image = img;
    
    [backView addSubview:imageview];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(backView.mas_centerX).offset(-75);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(backView.mas_top).offset(25);
        
    }];
    
    
 
    
    conuntLabel = [[UILabel alloc]init];
    
    conuntLabel.text = @"支付成功";
    
    conuntLabel.font = [UIFont systemFontOfSize:35.0 weight:2];
    
    conuntLabel.textColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    
    conuntLabel.textAlignment = NSTextAlignmentCenter;
    
    [backView addSubview:conuntLabel];
    
    [conuntLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(backView.mas_right).offset(-20);
        
        make.centerX.equalTo(backView.mas_centerX).offset(20);
        make.top.equalTo(backView.mas_top).offset(15);
        make.width.equalTo(@180);
        make.height.equalTo(@60);
        
    }];
    
    textLabel = [[UILabel alloc]init];
    
    textLabel.numberOfLines = 0;
    textLabel.font = [UIFont systemFontOfSize:15.0];
    
    NSString * textlabel;
    
    UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;
    if ([UserInfo shareUserInfoSingleton].userDataModel.mobile) {
        
        textlabel = [NSString stringWithFormat:@"尊敬的%@,感谢您的操作。\n您的年服务费用我们已收到!\n请登陆管理您的易云店!",userModel.mobile];
        
    }else{
       textlabel = [NSString stringWithFormat:@"尊敬的%@,感谢您的操作。\n您的年服务费用我们已收到!\n请登陆管理您的易云店!",_iphoneNumber];
    }


    
    
    NSMutableAttributedString * attribute = [[NSMutableAttributedString alloc]initWithString:textlabel];
    NSMutableParagraphStyle * paragrapstyle = [[NSMutableParagraphStyle alloc]init];
    [paragrapstyle setLineSpacing:15.0];
    [attribute addAttribute:NSParagraphStyleAttributeName value:paragrapstyle range:NSMakeRange(0, [textlabel length])];
   // [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0 weight:2.0] range:NSMakeRange(40, 14)];
    textLabel.attributedText = attribute;
    
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.equalTo(@190);
        make.top.equalTo(self.view.mas_top).offset(80);
        
    }];
    
    //审核说明
    button = [[UIButton alloc]init];
    [button setTitle:@"《审核说明》" forState:UIControlStateNormal];
    button.selected = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitleColor:[UIColor colorWithRed:84.0/255.0 green:161.0/255.0 blue:203.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ClickOne:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(100);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.height.equalTo(@40);
        make.top.equalTo(self.view.mas_top).offset(230);
        
    }];
    
    //放二维码的视图
    buttnView = [[UIView alloc]init];
    buttnView.layer.borderWidth = 1.0;
    buttnView.layer.borderColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0].CGColor;
   // buttnView.backgroundColor = [UIColor cyanColor];
    
    [self.view addSubview:buttnView];
    
    [buttnView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view.mas_top).offset(280);
        make.height.equalTo(@200);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(UISCREENWIDTH + 4);
        
    }];
    
    //访问二维码
    codeBut = [[UIButton alloc]init];
  //  [codeBut setImage:[UIImage imageNamed:@"011.jpg"] forState:UIControlStateNormal];
    codeBut.selected = YES;
    [codeBut addTarget:self action:@selector(addClickOne) forControlEvents:UIControlEventTouchUpInside];
    
    [buttnView addSubview:codeBut];
    

    [codeBut mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(buttnView.mas_left).with.offset(60);
        make.top.equalTo(buttnView.mas_top).offset(30);
        make.height.mas_equalTo(100);
        make.width.equalTo(@100);
    }];
    //访问二维码的Label
    codeLabel = [[UILabel alloc]init];
    codeLabel.text = @"访问二维码\n(点击放大保存)";
    codeLabel.numberOfLines = 0;
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.textColor =[UIColor blackColor];
    codeLabel.font = [UIFont systemFontOfSize:12.0];
    
    [buttnView addSubview:codeLabel];
    
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(buttnView.mas_left).with.offset(60);
        make.top.equalTo(codeBut.mas_top).offset(110);
        make.height.mas_equalTo(40);
        make.width.equalTo(@100);
        
    }];
    
    //分销二维码
    DistriBut = [[UIButton alloc]init];
   // [DistriBut setImage:[UIImage imageNamed:@"011.jpg"] forState:UIControlStateNormal];
    [DistriBut addTarget:self action:@selector(FenXiaoClick) forControlEvents:UIControlEventTouchUpInside];
    DistriBut.selected = YES;
    [buttnView addSubview:DistriBut];
    
    [DistriBut mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(codeBut.mas_right).with.offset(60);
        make.top.equalTo(buttnView.mas_top).with.offset(30);
        make.right.equalTo(buttnView.mas_right).with.offset(-60);
        make.height.mas_equalTo(100);
        make.width.equalTo(codeBut);
        
    }];
    
    //访问分销二维码的Label
    DistrLabel = [[UILabel alloc]init];
    DistrLabel.text = @"分销发展二维码\n(点击放大保存)";
    DistrLabel.numberOfLines = 0;
    DistrLabel.textAlignment = NSTextAlignmentCenter;
    DistrLabel.textColor =[UIColor blackColor];
    DistrLabel.font = [UIFont systemFontOfSize:12.0];
    
    [buttnView addSubview:DistrLabel];
    
    [DistrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(buttnView.mas_right).with.offset(-60);
        make.top.equalTo(DistriBut.mas_top).offset(110);
        make.height.mas_equalTo(40);
        make.width.equalTo(@100);
        
    }];

    
    
    //登陆管理云店按钮
    nextButton = [[UIButton alloc]init];
    
    nextButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    nextButton.layer.cornerRadius = 10;
    nextButton.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:1.0];
    
    [nextButton setTitle:@"登录管理易云店" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [nextButton addTarget:self action:@selector(NextController:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:nextButton];
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.left.equalTo(self.view.mas_left).offset(40);
        
    }];
    

}
#define mark请求数据
- (void)NetWork{

    Reachability * r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    NetworkStatus  status = [r currentReachabilityStatus];
    
    if (status == NotReachable) {
        //无网络状态
        [self createAlertView:@"请检查网络状态"];
    }else{
    
        // 有网络状态
        
        [self recahNetWork];
        
        [self CodeNetWork];
        
    }



}
#define mark访问二维码图片请求
- (void)CodeNetWork{
    
    
    NSString *  string;
    
//    UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;
//    
//    if (userModel.stores_id != userModel.mobile) {
      //  string = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_get_erweima.html?store_id=%@&type=erweimafx",userModel.stores_id];
   // }else{
        string = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_get_erweima.html?store_id=%@&type=erweimadp",_iphoneNumber];
   // }

    
    self.sessionmanager  = [AFHTTPSessionManager manager];
    self.sessionmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
    [self.sessionmanager GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.array = dic[@"errcode"];
        
        if ([dic[@"errcode"] isEqualToString:@"0"]) {
            
            NSString * s = [NSString stringWithFormat:@"http://www.tianview.com/%@",dic[@"data"]];
            
            url = [NSURL URLWithString:s];
            NSData * dat = [NSData dataWithContentsOfURL:url];
            
            UIImageView * imageviewM = [[UIImageView alloc]init];
            UIImage * im =[UIImage imageWithData:dat];
            
            imageviewM.image = im;
            NSLog(@"imageviewM.image:%@",imageviewM.image);
            
            [codeBut setImage:im forState:UIControlStateNormal];
            
            
        }else{
            
            
            [self createAlertView:@"请求图片错误"];
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    


}
#define mark分销数据请求
- (void)recahNetWork{
    
    NSString *  string;
    
    // http://www.tianview.com/api-ydz_get_erweima.html?store_id=3&type=erweimafx
  // http://www.tianview.com/api-ydz_get_erweima.html?store_id=3&type=erweimadp
    
    // http://www.tianview.com/api-ydz_get_erweima.html?store_id=18687005825&type=erweimafx
     /// http://www.tianview.com/api-ydz_get_erweima.html?store_id=18687005825&type=erweimadp
    
//UserDataModel * userModel = [UserInfo shareUserInfoSingleton].userDataModel;

        string = [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_get_erweima.html?store_id=%@&type=erweimafx",_stroye_ID];


    
    self.sessionmanager  = [AFHTTPSessionManager manager];
    self.sessionmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.sessionmanager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
  [self.sessionmanager GET:string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
      
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
      NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
      
      self.array = dic[@"errcode"];
      
      if ([dic[@"errcode"] isEqualToString:@"0"]) {
          
          NSString * s = [NSString stringWithFormat:@"http://www.tianview.com/%@",dic[@"data"]];
          
          fenxiaoUrl = [NSURL URLWithString:s];
          NSData * dat = [NSData dataWithContentsOfURL:fenxiaoUrl];
          
          UIImageView * imageviewM = [[UIImageView alloc]init];
          UIImage * im =[UIImage imageWithData:dat];
          
          imageviewM.image = im;
          NSLog(@"imageviewM.image:%@",imageviewM.image);
          
          [DistriBut setImage:im forState:UIControlStateNormal];

          
      }else{
      
      
          [self createAlertView:@"请求图片错误"];
      
      }
      
      
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"error:%@",error);
  }];


}
#define mark访问二维码
-(void)addClickOne{

    if (codeBut.selected == YES) {
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor blackColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageViewCode = [[UIImageView alloc]init];
            [self.imageViewCode sd_setImageWithURL:url];
            self.imageViewCode.userInteractionEnabled = YES;
            [_viewBack addSubview:_imageViewCode];
            
            [_imageViewCode mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.view);
                // make.left.equalTo(self.view.mas_left).offset(80);
                
                make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH,UISCREENHEIGHT - 90));
                make.top.equalTo(@100);
                
            }];
            NSLog(@"2222");
          
            self.tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewBackclickOne)];
            [self.viewBack addGestureRecognizer:self.tap1];

//            //保存图片手势
            self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapClickThree)];
            self.tap.numberOfTapsRequired = 1;
            self.tap.numberOfTouchesRequired = 1;
            [self.imageViewCode addGestureRecognizer:self.tap];

            
        }];
        
        return;
        
    }else{
        self.imageViewCode.alpha = 0.0;
        codeBut.selected = YES;
        
        return;
    }

}
- (void)viewBackclickOne{
    NSLog(@"666");
    
    [self.viewBack removeFromSuperview];
    [self.imageViewCode removeFromSuperview];

    
}
- (void)saveImageToPhotos:(UIImage*)savedImage{

UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}
#define mark二维码手势点击事件
- (void)imageTapClickThree{

    
        
         [self saveImageToPhotos:self.imageViewCode.image];
        

    
    if (self.imageViewCode.userInteractionEnabled == YES) {
        
        self.imageViewCode.userInteractionEnabled = NO;
        
    }else{
    
        self.imageViewCode.userInteractionEnabled = YES;
        
        [self.viewBack removeFromSuperview];
        [self.imageViewCode removeFromSuperview];
    }


    

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{


    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"图片已保存到系统相册" ;
    }
 
    [self createAlertView:msg];


}
#define mark分销二维码访问
- (void)FenXiaoClick{


    if (DistriBut.selected == YES) {
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor blackColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageViewFenXiao = [[UIImageView alloc]init];
           // self.imageViewFenXiao.image = [UIImage imageNamed:@"011.jpg"];
            [self.imageViewFenXiao sd_setImageWithURL:fenxiaoUrl];
            self.imageViewFenXiao.userInteractionEnabled = YES;
            [_viewBack addSubview:_imageViewFenXiao];
            
            [_imageViewFenXiao mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.equalTo(self.view);
                // make.left.equalTo(self.view.mas_left).offset(80);
                
                make.size.mas_equalTo(CGSizeMake(UISCREENWIDTH,UISCREENHEIGHT - 90));
                make.top.equalTo(@100);
                
            }];
            NSLog(@"2222");
            
            self.tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewBackclickOne)];
            [self.viewBack addGestureRecognizer:self.tap1];
            
            
            //            //保存图片手势
            self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapClickFour)];
            self.tap.numberOfTapsRequired = 1;
            self.tap.numberOfTouchesRequired = 1;
            [self.imageViewFenXiao addGestureRecognizer:self.tap];
            
            
        }];
        
        return;
        
    }else{
        self.imageViewFenXiao.alpha = 0.0;
        DistriBut.selected = YES;
        
        return;
    }
    


}
#define mark分销手势点击事件
- (void)imageTapClickFour{
    
    
    
    [self saveImageToPhotos:self.imageViewFenXiao.image];
    
    
    
    if (self.imageViewFenXiao.userInteractionEnabled == YES) {
        
        self.imageViewFenXiao.userInteractionEnabled = NO;
        
    }else{
        
        self.imageViewFenXiao.userInteractionEnabled = YES;
        
        [self.viewBack removeFromSuperview];
        [self.imageViewFenXiao removeFromSuperview];
    }
    
    
    
    
}

#define mark审核说明事件
- (void)ClickOne:(id)sender{

    if (button.selected == YES) {
        
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _viewBack.backgroundColor = [UIColor grayColor];
        _viewBack.alpha = 1.0;
        _viewBack.tag = 0;
        
        [self.view addSubview:_viewBack];
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.imageView = [[UIImageView alloc]init];
            self.imageView.image = [UIImage imageNamed:@"shenhe.png"];
            [_viewBack addSubview:_imageView];
            
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(self.viewBack);
                // make.left.equalTo(self.view.mas_left).offset(80);
                
                make.size.mas_equalTo(CGSizeMake(self.viewBack.frame.size.width,self.viewBack.frame.size.height));
                make.top.equalTo(@0);
                
            }];
            NSLog(@"2222");
            //            self.tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImageeyt)];
            //
            //            [self.imageView addGestureRecognizer:self.tap];
            //
            self.tap1  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewBackclickOne)];
            //
            [self.viewBack addGestureRecognizer:self.tap1];
            
        }];
        
        //self.b = NO;
        
        return;
        
    }else{
        
        NSLog(@"3333");
        self.imageView.alpha = 0.0;
        button.selected = YES;
        
        return;
    }

}


#pragma mark ----- 下一步返回登录页面完成店铺设置和实名认证走的方法 --------
- (void)NextController:(id)sender{


   LoginController * l = [[LoginController alloc]init];
    
    [self.navigationController pushViewController:l animated:YES];



}

//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
