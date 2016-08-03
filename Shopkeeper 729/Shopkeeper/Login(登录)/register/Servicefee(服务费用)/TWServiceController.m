//
//  TWServiceController.m
//  TWCompare
//
//  Created by TianView on 16/6/27.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import "TWServiceController.h"
#import <QuartzCore/QuartzCore.h>
#import "Masonry.h"
#import "TWAgreeController.h"
#import "WXApiRequestHandler.h"
#import "WXApi.h"
#import "WXApiObject.h"

#import "MyUtility.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "SimpleApp.h"
#import "AddCustomerModel.h"
#import "HomeController.h"
#import "TWOpenController.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"



@interface TWServiceController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSIndexPath * currentPath;
    
}

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic,strong)AFHTTPSessionManager * sessionmanager;

@property (nonatomic,assign)NSInteger selectCell;
@property (nonatomic,assign)NSInteger selectCompetle;

@end

@implementation TWServiceController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self cgeateView];
    
    self.title = @"费用支付";
    
    self.selectCell = 0;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
    
    [self cgeateView];

    
    //tableview初始化
    self.tableview = [[UITableView alloc]init];
    self.tableview.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.view addSubview:self.tableview];
    
    
    
    headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 64, self.view.frame.size.width, 80);
    headerView.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
    
    self.tableview.tableHeaderView = headerView;
    
    //年费
    NSMutableAttributedString *  str =[[NSMutableAttributedString alloc]initWithString:@"年服务费 ￥1680.00"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:206.0/255.0f green:31.0/255.0f blue:28.0/255.0f alpha:1.0] range:NSMakeRange(4, 9)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:30.0] range:NSMakeRange(4, 9)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(5, 1)];
    
    UILabel * label = [[UILabel alloc]init];
    label.attributedText = str;
    
    [headerView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@60);
        make.top.mas_equalTo(self.view.mas_top).offset(70);
        
    }];
    
    footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, self.view.frame.origin.y - 260, self.view.frame.size.width, 300);
    footerView.backgroundColor = [UIColor colorWithRed:247.0/256.0f green:247.0/256.0f blue:247.0/256.0f alpha:1.0];
    self.tableview.tableFooterView = footerView;
    
    
    //完成按钮
    UIButton * completeButton = [[UIButton alloc]init];
    completeButton.layer.cornerRadius = 5.0;
    completeButton.layer.masksToBounds = YES;
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    completeButton.backgroundColor = [UIColor colorWithRed:227.0/256.0f green:0.0/256.0f blue:127.0/256.0f alpha:1.0];
    [completeButton addTarget:self action:@selector(completeButtoning:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeButton];
    
    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-40, 50));
        make.top.mas_equalTo(self.view.mas_top).offset(300);
    }];
    
    UIButton  * attrLabel = [[UIButton alloc]init];
    [attrLabel setTitle:@"开店热线: 400-0871-347" forState:UIControlStateNormal];
    [attrLabel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [attrLabel addTarget:self action:@selector(ClickPhone) forControlEvents:UIControlEventTouchUpInside];
    attrLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:attrLabel];
    
    [attrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 40));
        
    }];
    
    

    
}
- (void)ClickPhone{
    
    NSString * phone = @"400-0871-347";
    
    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",phone];
    // [[UIApplication sharedApplication] openURL:[NSURLURLWithString:num]]; //拨号
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:num]];
    
}

//创建 view
- (void)cgeateView{
    
    
    navView = [[UIView alloc]init];
    navView.backgroundColor = [UIColor whiteColor];
    navView.layer.borderWidth = 0.5;
    navView.layer.borderColor = [[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1]CGColor];
    
    [self.view addSubview:navView];
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.centerX.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width + 2, 40));
        
    }];
    
    
    
    zhanghao = [[UILabel alloc]init];
    zhanghao.text = @"1.账号";
    zhanghao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
    zhanghao.textAlignment = NSTextAlignmentCenter;
    zhanghao.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:zhanghao];
    [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_top).offset(5);
        make.left.equalTo(navView.mas_left).offset(30);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        
    }];
    zhiliao = [[UILabel alloc]init];
    zhiliao.text = @"2.资料";
    zhiliao.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
    zhiliao.textAlignment = NSTextAlignmentCenter;
    zhiliao.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:zhiliao];
    [zhiliao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_top).offset(5);
        make.left.equalTo(zhanghao.mas_right).offset(30);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        
    }];
    
    renzheng = [[UILabel alloc]init];
    renzheng.text = @"3.认证";
    renzheng.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
    renzheng.textAlignment = NSTextAlignmentCenter;
    renzheng.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:renzheng];
    [renzheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_top).offset(5);
        make.left.equalTo(zhiliao.mas_right).offset(30);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        
    }];
    
    
    
    pay = [[UILabel alloc]init];
    pay.text = @"4.支付";
    
    pay.textAlignment = NSTextAlignmentCenter;
    pay.font = [UIFont systemFontOfSize:15.0];
    [navView addSubview:pay];
    [pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navView.mas_top).offset(5);
        make.left.equalTo(renzheng.mas_right).offset(30);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
        
    }];
    
    if (_storetype) {
    //    pay.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
       
    }else{
        
        
    pay.textColor = [UIColor colorWithRed:228.0/255.0 green:0.0/255.0 blue:127.0/255.0 alpha:1.0];
    }
    
    
    //  NSArray * arr = [NSArray arrayWithObjects:@"1.账号",@"2.资料",@"3.认证",@"4.支付", nil];
    NSArray * imageArray = [NSArray arrayWithObjects:@"register-12",@"register-13", nil];
    im = [[UIImageView alloc]init];
    UIImage * image = [UIImage imageNamed:imageArray[1]];
    im.image = image;
    [navView addSubview:im];
    
    [im mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(navView.mas_left).offset(85);
        make.size.mas_equalTo(CGSizeMake(10, 15));
        make.top.equalTo(navView.mas_top).offset(13);
        
    }];
    im1 = [[UIImageView alloc]init];
    UIImage * image1 = [UIImage imageNamed:imageArray[1]];
    im1.image = image1;
    [navView addSubview:im1];
    
    [im1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(im.mas_right).offset(80);
        make.size.mas_equalTo(CGSizeMake(10, 15));
        make.top.equalTo(navView.mas_top).offset(13);
        
    }];
    
    im2 = [[UIImageView alloc]init];
    UIImage * image2 = [UIImage imageNamed:imageArray[1]];
    im2.image = image2;
    [navView addSubview:im2];
    
    [im2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(im1.mas_right).offset(70);
        make.size.mas_equalTo(CGSizeMake(10, 15));
        make.top.equalTo(navView.mas_top).offset(13);
        
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"11"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"11"];
    }
    

    NSArray * imageNameArr = @[@"weixin", @"aliPay"];
    NSArray * nameArr = @[@"微信支付", @"支付宝支付"];

        UIImageView * weixinImage = [[UIImageView alloc]init];
        weixinImage.image = [UIImage imageNamed:imageNameArr[indexPath.row]];
        [cell.contentView addSubview:weixinImage];
        [weixinImage mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(cell.contentView.mas_top).offset(17);
            make.height.equalTo(@30);
            make.width.equalTo(@30);
            make.left.mas_equalTo(cell.contentView.mas_left).offset(15);

        }];

        UILabel * weixinLabel = [[UILabel alloc]init];
        weixinLabel.text = nameArr[indexPath.row];
        weixinLabel.font = [UIFont systemFontOfSize:15.0];
        weixinLabel.textColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
        weixinLabel.textAlignment = NSTextAlignmentCenter;

        [cell.contentView addSubview:weixinLabel];

        [weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weixinImage.mas_right).offset(10);
            make.top.equalTo(cell.contentView.mas_top).offset(22);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];


        UIImageView * imageV = [[UIImageView alloc]init];
    if (indexPath.row  == 0) {
        imageV.image = [UIImage imageNamed:@"select_qian"];
        imageV.tag = 100;
    }else {
        
        imageV.image = [UIImage imageNamed:@"unselect_qian"];
        imageV.tag = 101;
    }
    

        [cell.contentView addSubview:imageV];
    
       [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView.mas_right).offset(-30);
            make.top.equalTo(cell.contentView.mas_top).offset(22);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 64;
    }else if (indexPath.row == 1){
        return 64;
    }else{
        return 80;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 200;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    UIImageView * imageView1 = [self.view viewWithTag:100];
    UIImageView * imageView2 = [self.view viewWithTag:101];

    if (indexPath.row == 0) {
        _selectCell = 1;
        imageView1.image = [UIImage imageNamed:@"select_qian"];
        imageView2.image = [UIImage imageNamed:@"unselect_qian"];
    }else {
        _selectCell = 2;
        imageView1.image = [UIImage imageNamed:@"unselect_qian"];
        imageView2.image = [UIImage imageNamed:@"select_qian"];
    }
    
}

#define mark 点击完成按钮完成支付事件 ---------
- (void)completeButtoning:(UIButton *)sender{

    if ((_selectCell == 1) || !(_selectCell == 2)) {
        
        NSString *res = [WXApiRequestHandler jumpToBizPay];
        
        if( ![@"" isEqual:res] ){
            
            UIAlertController * a  =[UIAlertController alertControllerWithTitle:nil message:@"支付失败" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction * act = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [a addAction:act];
            
            [self presentViewController:a animated:YES completion:nil];
            
        }

        
        NSLog(@"您点击了微信支付-------完成");

    }else if(_selectCell == 2){
        
        
//        NSURL * myURL_APP_A = [NSURL URLWithString:@"alipay:"];
//        if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
//            //如果没有安装支付宝客户端那么需要安装
//            UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"点击确定安装支付宝钱包!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [message show];
//            return;
//        }
    
    
        /**
         *  1. 生成订单信息
         */
        Order *order = [[Order alloc] init];
        order.partner = PartnerID; //支付宝分配给商户的ID
        order.seller = SellerID; //收款支付宝账号（用于收💰）
        order.tradeNO = [self generateTradeNO]; //订单ID(由商家自行制定)
        NSLog(@"%@", order.tradeNO);
        order.productName = @"易简大观年服务费"; //商品标题
        order.productDescription = @"MacBook Air"; //商品描述
        order.amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
        
        //：http://www.tianview.com/api-ydz_register.html?m=register&mobile=18213561340&password=123456  ydz_guarantee_update
        //回调 URL  http://www.tianview.com/ydz_guarantee_update.html?store_id=%@
        
        NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
        
        NSString * praStr;
        
        if (userDic[@"stores_id"]) {
            praStr = [NSString stringWithFormat:@"store_id=%@",userDic[@"stores_id"]];
        }else{
            if (_useriphone) {
                praStr = [NSString stringWithFormat:@"store_id=%@",_useriphone];
            }
        }
      
        NSLog(@"_useriphone:%@   stroes:%@",_useriphone,userDic[@"store_id"]);
      
        order.notifyURL =  [NSString stringWithFormat:@"http://www.tianview.com/api-ydz_guarantee_update.html?%@",praStr]; //回调URL（通知服务器端交易结果）(重要)

        SimpleApp * sim =[SimpleApp danliPassValue];
        sim.backmeath = order.notifyURL;
        
        
        // 接口名称要如何修改
        order.service = @"mobile.securitypay.pay"; //接口名称, 固定值, 不可空
        order.paymentType = @"1"; //支付类型 默认值为1(商品购买), 不可空
        order.inputCharset = @"utf-8"; //参数编码字符集: 商户网站使用的编码格式, 固定为utf-8, 不可空
        order.itBPay = @"30m"; //未付款交易的超时时间 取值范围:1m-15d, 可空
        
        // 应用注册scheme,在当前项目的Info.plist定义URL types
        NSString *appScheme = @"Shopkeeper";
        // 将订单信息拼接成字符串
        NSString *orderSpec = [order description];
        NSLog(@"订单信息orderSpec = %@", orderSpec);
        
        /**
         *  2. 签名加密
         *  获取私钥并将商户信息签名, 外部商户可以根据情况存放私钥和签名, 只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
         */
        id <DataSigner> signer = CreateRSADataSigner(PartnerPrivKey);
        NSString *signedString = [signer signString:orderSpec];
        
        /**
         *  3. 将签名成功字符串格式化为订单字符串,请严格按照该格式
         */
        NSString *orderString = nil;
        if (signedString != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                
                if ([resultDic[@"resultStatus"] integerValue] == 9000) {
                    TWOpenController * open = [[TWOpenController alloc]init];
                    
                    open.iphoneNumber = _useriphone;
                    open.stroye_ID = _storyIDL;
                    
                    NSLog(@"open.iphoneNumber:%@",open.iphoneNumber);
                    
                    [self.navigationController pushViewController:open animated:YES];
                }else {
                    
                    UIAlertView * a =[[UIAlertView alloc]initWithTitle:@"提示"message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [a show];
                }
                
            }];
        }
        
        NSLog(@"您点击了支付宝支付--------完成");

    
    }
}

/**
 *  产生随机订单号
 *
 *  @return 订单号字符串
 */
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    
    /*
     支付宝官方给出的 Demo 中加入了这句生成种子的代码, 但是 arc4random 似乎并不需要生成随机种子(引用网上: arc4random() 是一个真正的伪随机算法，不需要生成随机种子，因为第一次调用的时候就会自动生成)
     srand((unsigned)time(0));
     */
    
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index =  arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    NSLog(@"随机生成的订单号->%@", resultStr);
    return resultStr;
}


//状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
