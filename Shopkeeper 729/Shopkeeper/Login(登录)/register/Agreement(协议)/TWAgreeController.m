//
//  TWAgreeController.m
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWAgreeController.h"
#import "Masonry.h"
#import "TWRegistController.h"
#import "TWCerController.h"
#import "TWInformationController.h"
#import "TWServiceController.h"
#import "TWSweepController.h"
#import "LoginController.h"
#import "TWCerController.h"



@interface TWAgreeController ()<UIWebViewDelegate,UITextViewDelegate>
@property(nonatomic,strong)UIWebView * webview;

@end

@implementation TWAgreeController
@synthesize webview;

-(void)createNavbar
{

}
-(void)setTitleName:(NSString *)titleName{



}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:238.0/256.0f green:238.0/256.0 blue:238.0/256.0f alpha:1.0f];
    self.title = @"开店服务协议";
  
    [self setButton];

    UIScrollView * labView = [[UIScrollView alloc]init];
    labView.backgroundColor = [UIColor colorWithRed:238.0/256.0f green:238.0/256.0 blue:238.0/256.0f alpha:1.0f];
    labView.scrollEnabled = YES;
    labView.showsVerticalScrollIndicator = YES;
    labView.showsHorizontalScrollIndicator = YES;

    
    [self.view addSubview:labView];
    
    [labView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 10, self.view.frame.size.height - 150));
        
    }];
    
    
    NSString * msg = @"一、乙方的义务：\n乙方提供稳定的移动互联网信息平台“易云店”系统；\n乙方提供丰富的产品线，甲方可轻松挑拣产品，形成自己的店铺；\n乙方提供系统使用培训，并配置客户经理对甲方如何进行电子商务及线上线下一体化O2O进行指导；\n乙方可提供代发货服务（并以一定供货价与甲方结算，供货价以甲方后台查询为准）；\n由乙方发货的订单，乙方可完成退换货及售后，并提供七天无理由退换货服务；\n二、甲方的义务  \n  甲方需向乙方支付服务费1680元/年； \n三、乙方的权利  \n 在发现甲方有以下形为时，乙方可取销与甲方的合作 \n以扰乱价格体系进行销售的；\n 违反线下商业道德及国家相关法律的；\n 被取消合作资格的，不退回服务费；\n 为保障服务质量，甲、乙双方进行统一结算，“易云店”订单的付款，先进入乙方的代收款帐户，订单完成后与甲方进行结算，如发生交易纠纷，乙方有权利直接扣款进行赔付。\n 四、甲方的权利  \n 甲方可使用易云店系统，发展分销商，分销商可免费开易云店（分销版），甲方向分销提取一定佣金，如分销独立为直营店，甲方获得开店收益的30%;\n 甲方向乙方支付1680元/年服务费后，乙方可向甲提供易云店使用手册、分销使用手册、产品宣传册等资料。   \n 其它 \n 甲方开店需要真实的开店资料，并保障资料真实可靠。\n 开店需提供以下资料：（真实姓名，身份证号码，身份证正反面照片，手持身份证照片，手机号，自取店名，店铺密码，店铺LOGO图片，店铺背影图片以及微信二维码）共十项；\n 资料要求如有变化，甲方需及时提交准确资料。";
    
    
    
    UITextView * textView = [[UITextView alloc]init];
    
    NSMutableParagraphStyle * stype = [[NSMutableParagraphStyle alloc]init];
    stype.lineSpacing = 10.0;
    NSDictionary * attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSParagraphStyleAttributeName:stype};
    textView.attributedText = [[NSMutableAttributedString alloc]initWithString:msg attributes:attributes];
    
    textView.editable = NO;
    textView.textAlignment = NSTextAlignmentLeft;
    textView.font = [UIFont systemFontOfSize:12.0];
    textView.textColor = [UIColor colorWithRed:98.0/255.0f green:98.0/255.0f blue:98.0/255.0f alpha:1.0];
    textView.backgroundColor = [UIColor colorWithRed:238.0/256.0f green:238.0/256.0 blue:238.0/256.0f alpha:1.0f];
    
    [labView addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 10, self.view.frame.size.height - 150));
        
    }];


    
}

#define mark扫一扫二维码
- (void)Qrcodebutton{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *altC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查设备相机!" preferredStyle:UIAlertControllerStyleAlert];
        [altC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:altC animated:YES completion:nil];
        return;

    }else{

    TWSweepController * sweep = [[TWSweepController alloc]init];
    
    [self presentViewController:sweep animated:YES completion:nil];
        
    }

}

//button协议按钮
- (void)setButton{

    UIButton * Disbutton =[[UIButton alloc]init];
    
    [Disbutton setTitle:@"不同意开店协议" forState:UIControlStateNormal];
    [Disbutton setTitleColor:[UIColor colorWithRed:109.0/256.0f green:109.0/256.0f blue:109.0/256.0f alpha:1.0] forState:UIControlStateNormal];
    Disbutton.backgroundColor = [UIColor  colorWithRed:190.0/256.0f green:190.0/256.0f blue:190.0/256.0f alpha:1.0];
    Disbutton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    [Disbutton addTarget:self action:@selector(DisbuttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    
    Disbutton.layer.cornerRadius = 5;
    [self.view addSubview:Disbutton];
    
    UIButton * Agebutton =[[UIButton alloc]init];
    
    [Agebutton setTitle:@"同意开店协议" forState:UIControlStateNormal];
    [Agebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Agebutton.backgroundColor = [UIColor  colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [Agebutton addTarget:self action:@selector(AgerbuttonReturn:) forControlEvents:UIControlEventTouchUpInside];
    Agebutton.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    
    Agebutton.layer.cornerRadius = 5;
    [self.view addSubview:Agebutton];

    
    
    
    [Disbutton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.height.equalTo(@40);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-20);
        make.width.mas_equalTo(Agebutton.mas_width);
        
    }];
 [Agebutton mas_makeConstraints:^(MASConstraintMaker *make) {
    
     make.left.mas_equalTo(Disbutton.mas_right).offset(20);
     make.width.mas_equalTo(Agebutton.mas_width);
     make.right.mas_equalTo(self.view.mas_right).offset(-20);
     make.height.equalTo(@40);
     make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
     
 }];
    


}
//#define mark4 禁止文本编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

#define mark2  不同意开店协议返回主页面的方法
- (void)DisbuttonReturn:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#define mark3   同意开店协议进入下个页面的方法

- (void)AgerbuttonReturn:(id)sender{

    TWRegistController * regist = [[TWRegistController alloc]init];
    
    regist.story_id_2 = _story_id_1;
    regist.storetype = _storetype;
    
    NSLog(@"regist.storetype:%@",regist.storetype);
    
    NSLog(@"regist.story_id_2:%@",regist.story_id_2);
    
    [self.navigationController pushViewController:regist animated:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

////状态栏颜色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//
//    return UIStatusBarStyleLightContent;
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
