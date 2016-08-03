//
//  HomeController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "HomeController.h"
#import "UIButton+WebCache.h"
#import "ShopButton.h"
#import "GoodsManageController.h"
#import "OrderManageController.h"
#import "CustomerManageController.h"
#import "FengXiaoController.h"
#import "FinancialManagementController.h"
#import "ShopSettingController.h"

#import "TodayVisitController.h"
#import "VisitMostController.h"
#import "MyRankController.h"
#import "AddCustomerController.h"

#import "NSString+Extension.h"

@interface HomeController ()

@end

#define TopViewH 350

@implementation HomeController

-(void)createNavbar{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;

    [_portraitButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kEnvironmentImage, userDic[@"logo"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user"] options:SDWebImageRetryFailed];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    [self homeMyNetWork];
 
    
}

-(void)homeMyNetWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSLog(@"userDic == %@",userDic);
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    [LBProgressHUD showHUDto:self.view animated:YES];
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kVisitAndOrders Parameters:dic style:kConnectGetType success:^(id dic) {
        NSLog(@"kVisitAndOrders == %@", dic);
        
        
        NSString * errcodeStr = [NSString stringWithFormat:@"%@",dic[@"errcode"]];
        if ([errcodeStr isEqualToString:@"0"]) {
            
            _visitAndOrdersDic = dic;
            [_visitMostImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , _visitAndOrdersDic[@"data"][@"today"][@"g"]]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];

            if (_visitAndOrdersDic[@"data"][@"today"][@"c"]) {
                _visitLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"c"]];
            }else{
                _visitLable.text = @"0";
            }
            if (_visitAndOrdersDic[@"data"][@"today"][@"o"]) {
                _newAddLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"o"]];
            }else{
                _newAddLable.text = @"0";
            }
            if (_visitAndOrdersDic[@"data"][@"today"][@" m"]) {
                _addMemberLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@" m"]];
            }else{
                _addMemberLable.text = @"0";
            }


        }
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"error -- %@",error);
    }];
}



-(void)createUI
{
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.001)];
    [self.view addSubview:l];
    
    _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.001, Main_Screen_Width, Main_Screen_Height)];
    [_baseScrollView setContentSize:CGSizeMake(0, TopViewH+440)];
    [_baseScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_baseScrollView];
    
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    

    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, TopViewH)];
    [topView setBackgroundColor:KMainColor];
    [_baseScrollView addSubview:topView];
    
    
    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-125, 120, 250, 20)];
    [nameLable setTextAlignment:1];
    [nameLable setTextColor:[UIColor whiteColor]];
    [nameLable setFont:[UIFont boldSystemFontOfSize:18]];
    [nameLable setText:userDic[@"stores_name"]];
    [topView addSubview:nameLable];
    
    CGSize size =[userDic[@"stores_name"] sizeWithFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(MAXFLOAT, 20)];

    UIImageView * vImage = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+(size.width/2)+5, 123, 15, 15)];
    [vImage setImage:[UIImage imageNamed:@"Vpng"]];
    [topView addSubview:vImage];
    
    //头像
    UIView *buttonImageView = [[UIView alloc]initWithFrame:CGRectMake( Main_Screen_Width/2-40, 30, 80, 80)];
    [buttonImageView setBackgroundColor:[UIColor whiteColor]];
    [buttonImageView setUserInteractionEnabled:YES];
    buttonImageView.layer.masksToBounds = YES;
    [buttonImageView.layer setCornerRadius:buttonImageView.bounds.size.width/2];
    [buttonImageView.layer setBorderWidth:0.3];
    [buttonImageView.layer setBorderColor:RGBCOLOR(242, 242, 242).CGColor];
    [topView addSubview:buttonImageView];
    
    //头像登陆按钮
    _portraitButton = [[UIButton alloc]initWithFrame:CGRectMake(3, 3, 75, 75)];
    [_portraitButton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kEnvironmentImage, userDic[@"logo"]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user"] options:SDWebImageRetryFailed];
    //    [_portraitButton setBackgroundColor:[UIColor redColor]];
//    [_portraitButton addTarget:self action:@selector(pushTOPersonalDataAction) forControlEvents:UIControlEventTouchUpInside];
    _portraitButton.layer.masksToBounds = YES;
    [_portraitButton.layer setCornerRadius:_portraitButton.bounds.size.width/2];
    [buttonImageView addSubview:_portraitButton];
    
    //是否直营店
    UILabel * zhiyingLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-125, 160, 250, 20)];
    [zhiyingLable setTextAlignment:1];
    [zhiyingLable setTextColor:[UIColor whiteColor]];
    [zhiyingLable setFont:[UIFont boldSystemFontOfSize:13]];
    if ([userDic[@"store_type"] integerValue] == 1) {
        zhiyingLable.text = @"直营店";
    }else {
        zhiyingLable.text = userDic[@"store_type_name"];
    }
    [topView addSubview:zhiyingLable];

    //当前排名
    _currentAuctionBt = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-70, 190, 140, 30)];
    [_currentAuctionBt.titleLabel setTextAlignment:1];
//    [_currentAuctionBt setBackgroundColor:[UIColor yellowColor]];
    [_currentAuctionBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_currentAuctionBt.titleLabel setFont:[UIFont systemFontOfSize:13]];
    if (userDic[@"paiming"]) {
        [_currentAuctionBt setTitle:[NSString stringWithFormat:@"当前排名：%@", userDic[@"paiming"]] forState:UIControlStateNormal];
    }
    [_currentAuctionBt addTarget:self action:@selector(currentAuctionBtAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_currentAuctionBt];
    
    //白色块
    UIView * aview = [[UIView alloc]initWithFrame:CGRectMake(30, 230, Main_Screen_Width-60, 50)];
    [aview setBackgroundColor:[UIColor whiteColor]];
    [aview.layer setCornerRadius:25];
    [topView addSubview:aview];
    
    //我的余额/可提现余额
    NSArray * arr = @[@"我的余额", @"可提现余额"];
    for (int i = 0; i < 2; i++) {
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake( (Main_Screen_Width-60)/2*i, 25, (Main_Screen_Width-60)/2, 20)];
        [lable setTextAlignment:1];
        [lable setTextColor:KMainColor];
        [lable setText:arr[i]];
        [lable setFont:[UIFont systemFontOfSize:13]];
        [aview addSubview:lable];
    }
   
    
    
    //我的余额
    _myBalanceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, (Main_Screen_Width-60)/2, 25)];
    [_myBalanceLable setTextAlignment:1];
//    [_myBalanceLable setBackgroundColor:[UIColor redColor]];
    [_myBalanceLable setTextColor:RGBCOLOR(227, 0, 125)];
    [_myBalanceLable setFont:[UIFont boldSystemFontOfSize:15]];
    if (userDic[@"acc_all"]) {
        _myBalanceLable.text = [NSString stringWithFormat:@"￥%@",userDic[@"acc_all"]];
    }else{
        _myBalanceLable.text = @"￥0";
    }
    [aview addSubview:_myBalanceLable];

    //可提现余额
    _availableBalanceLable = [[UILabel alloc]initWithFrame:CGRectMake( (Main_Screen_Width-60)/2, 5, (Main_Screen_Width-60)/2, 25)];
    [_availableBalanceLable setTextAlignment:1];
    [_availableBalanceLable setTextColor:RGBCOLOR(227, 0, 125)];
    [_availableBalanceLable setFont:[UIFont boldSystemFontOfSize:15]];
    if (userDic[@"acc_use"]) {
        _availableBalanceLable.text = [NSString stringWithFormat:@"￥%@",userDic[@"acc_use"]];
    }else{
        _availableBalanceLable.text = @"￥0";
    }
    [aview addSubview:_availableBalanceLable];
    
    UILabel * lineLable= [[UILabel alloc]initWithFrame:CGRectMake( (Main_Screen_Width-60)/2, 5, 1, 40)];
    [lineLable setBackgroundColor:KMainColor];
    [aview addSubview:lineLable];
    
#pragma mark - 中间三个按钮
    NSArray * nameArr = @[@"今日", @"本周", @"本月"];
    for (int i = 0; i < 3; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/3*i, TopViewH-33, Main_Screen_Width/3, 33)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(103, 0, 7) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(threadDayInfoAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBACOLOR(203, 0, 107, 0.5)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [topView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton = button;
        }
        
        UILabel *shuLineLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/3-0.5, 5, 0.5, 25)];
        [shuLineLable setBackgroundColor:[UIColor blackColor]];
        [button addSubview:shuLineLable];
    }
    
    // 滑块
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width/3/2-7.5, TopViewH-7, 15, 8)];
    [_imageview setImage:[UIImage imageNamed:@"slider"]];
    [_baseScrollView addSubview:_imageview];
    
    NSArray * inffoNameArr = @[@"今日浏览", @"新增订单", @"浏览最多", @"发展会员"];
    static NSInteger index = 0;
    for (int i = 0; i  < 2; i++) {
        for (int j = 0; j< 2; j++) {
            
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2*i, TopViewH+88*j, Main_Screen_Width/2, 88)];
//            [button setBackgroundColor:[UIColor yellowColor]];
            [button setTag:400+index];
            [button addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_baseScrollView addSubview:button];

             UILabel * midInfoLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2*i, TopViewH+63+80*j, Main_Screen_Width/2, 15)];
            [midInfoLable setText:inffoNameArr[index]];
            [midInfoLable setFont:[UIFont systemFontOfSize:12]];
            [midInfoLable setTextAlignment:1];
            [midInfoLable setTextColor:RGBCOLOR(100, 100, 100)];
            [_baseScrollView addSubview:midInfoLable];
            
            UILabel * infoLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2*i, TopViewH+20+84*j, Main_Screen_Width/2, 30)];
            [infoLable setFont:[UIFont boldSystemFontOfSize:30]];
            [infoLable setTextAlignment:1];
            [infoLable setTextColor:RGBCOLOR(100, 100, 100)];
            [_baseScrollView addSubview:infoLable];
            
            if (index == 0) {
                _visitLable = infoLable;
                if (_visitAndOrdersDic[@"data"][@"today"][@"c"]) {
                    _visitLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"c"]];
                }else{
                    _visitLable.text = @"0";
                }
            }else if (index == 1) {
                _newAddLable = infoLable;
                if (_visitAndOrdersDic[@"data"][@"today"][@"o"]) {
                    _newAddLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"o"]];
                }else{
                    _newAddLable.text = @"0";
                }
            }else if (index == 2) {
                
                // 浏览最多的图片
                _visitMostImageview = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2/2-25, 10, 50, 50)];
                [_visitMostImageview.layer setCornerRadius:25];
                _visitMostImageview.clipsToBounds = YES;
                [_visitMostImageview setUserInteractionEnabled:YES];
                [_visitMostImageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(visitMostImageviewClick)]];
                [_visitMostImageview setBackgroundColor:[UIColor redColor]];
                [button addSubview:_visitMostImageview];
 

            }else if (index == 3){
                _addMemberLable = infoLable;
//                _addMemberLable.backgroundColor = [UIColor redColor];
                if (_visitAndOrdersDic[@"data"][@"today"][@" m"]) {
                    _addMemberLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@" m"]];
                }else{
                    _addMemberLable.text = @"0";
                }
            }
             index++;
            if (index > 3) {
                index = 0;
            }
        }
    }
    
    UILabel * speLable = [[UILabel alloc]initWithFrame:CGRectMake(0, TopViewH+88+88, Main_Screen_Width, 10)];
    [speLable setBackgroundColor:RGBCOLOR(244, 244, 244)];
    [speLable.layer setBorderColor:RGBCOLOR(209, 209, 209).CGColor];
    [speLable.layer setBorderWidth:0.5];
    [_baseScrollView addSubview:speLable];
    
    NSLog(@"Main_Screen_Height == %f",Main_Screen_Height);
    
    NSArray * inffoNameArr2 = @[@"商品管理", @"订单管理" ,@"客户管理", @"分销管理", @"财务管理", @"店铺管理"];
    static NSInteger index2 = 0;
    for (int i = 0; i  < 2; i++) {
        for (int j = 0; j< 3; j++) {
            
            ShopButton *button = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/3*j, (TopViewH+88+88+10)+125*i, Main_Screen_Width/3, 125) ImageSize:CGSizeMake(37, 37) ImageProportion:0.3 TextFontSize:12 TextProportion:0.7 ];
            [button setTitle:inffoNameArr2[index2] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"homebt_%ld",(long)index2]] forState:UIControlStateNormal];
            [button.layer setBorderWidth:0.3];
            [button.layer setBorderColor:RGBCOLOR(220, 220, 220).CGColor];
            [button addTarget:self action:@selector(sixBtAction:) forControlEvents:UIControlEventTouchUpInside];
            [_baseScrollView addSubview:button];
            index2++;
            if (index2 > 5) {
                index2 = 0;
            }
        }
    }

}

-(void)visitMostImageviewClick
{
    VisitMostController * visitMostController = [[VisitMostController alloc]init];
    [self.navigationController pushViewController:visitMostController animated:YES];
}
-(void)fourButtonAction:(UIButton *)bt
{
    if (bt.tag == 400) {
        TodayVisitController * todayVisitController = [[TodayVisitController alloc]init];
        [self.navigationController pushViewController:todayVisitController animated:YES];
    }else if (bt.tag == 401) {
        OrderManageController * order = [[OrderManageController alloc]init];
        [self.navigationController pushViewController:order animated:YES];
    }else if (bt.tag == 402) {
        VisitMostController * visitMostController = [[VisitMostController alloc]init];
        [self.navigationController pushViewController:visitMostController animated:YES];
    }else{
        AddCustomerController * addCustomerController = [[AddCustomerController alloc]init];
        [self.navigationController pushViewController:addCustomerController animated:YES];
    }
    

}

//当前排名
-(void)currentAuctionBtAction
{
    MyRankController * myRank = [[MyRankController alloc]init];
    [self.navigationController pushViewController:myRank animated:YES];
}


#pragma mark - 六个按钮点击
-(void)sixBtAction:(UIButton *)bt
{
    if ([bt.titleLabel.text isEqualToString:@"商品管理"]) {
        GoodsManageController * goods = [[GoodsManageController alloc]init];
        [self.navigationController pushViewController:goods animated:YES];
    }else if ([bt.titleLabel.text isEqualToString:@"分销管理"]) {
        FengXiaoController * fenxiao = [[FengXiaoController alloc]init];
        [self.navigationController pushViewController:fenxiao animated:YES];
    }else if ([bt.titleLabel.text isEqualToString:@"订单管理"]) {
        OrderManageController * order = [[OrderManageController alloc]init];
        [self.navigationController pushViewController:order animated:YES];
    }else if ([bt.titleLabel.text isEqualToString:@"财务管理"]) {
        FinancialManagementController * financial = [[FinancialManagementController alloc]init];
        [self.navigationController pushViewController:financial animated:YES];
    }else if ([bt.titleLabel.text isEqualToString:@"客户管理"]) {
        CustomerManageController * customer = [[CustomerManageController alloc]init];
        [self.navigationController pushViewController:customer animated:YES];
    }else {
        ShopSettingController * shop = [[ShopSettingController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }
}

-(void)threadDayInfoAction:(UIButton *)button
{
    _currentSelectButton.selected = NO;
    
    button.selected = YES;
    
    _currentSelectButton = button;
    
 
    if ([button.titleLabel.text isEqualToString:@"今日"]) {
        [_visitMostImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , _visitAndOrdersDic[@"data"][@"today"][@"g"]]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
        [_imageview setFrame:CGRectMake(Main_Screen_Width/3/2-7.5, TopViewH-7, 15, 8)];
        if (_visitAndOrdersDic[@"data"][@"today"][@"c"]) {
            _visitLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"c"]];
        }else{
            _visitLable.text = @"0";
        }
        if (_visitAndOrdersDic[@"data"][@"today"][@"o"]) {
            _newAddLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"o"]];
        }else{
            _newAddLable.text = @"0";
        }
        if (_visitAndOrdersDic[@"data"][@"today"][@"m"]) {
            _addMemberLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"today"][@"m"]];
        }else{
            _addMemberLable.text = @"0";
        }

    }else if ([button.titleLabel.text isEqualToString:@"本周"]) {
        [_imageview setFrame:CGRectMake(Main_Screen_Width/3/2-7.5+Main_Screen_Width/3, TopViewH-7, 15, 8)];
        [_visitMostImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , _visitAndOrdersDic[@"data"][@"week"][@"g"]]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
        if (_visitAndOrdersDic[@"data"][@"week"][@"c"]) {
            _visitLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"week"][@"c"]];
        }else{
            _visitLable.text = @"0";
        }
        if (_visitAndOrdersDic[@"data"][@"week"][@"o"]) {
            _newAddLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"week"][@"o"]];
        }else{
            _newAddLable.text = @"0";
        }
        if (_visitAndOrdersDic[@"data"][@"week"][@" m"]) {
            _addMemberLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"week"][@" m"]];
        }else{
            _addMemberLable.text = @"0";
        }


    }else  if ([button.titleLabel.text isEqualToString:@"本月"]){
        [_imageview setFrame:CGRectMake(Main_Screen_Width/3/2-7.5+Main_Screen_Width/3*2, TopViewH-7, 15, 8)];

        [_visitMostImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , _visitAndOrdersDic[@"data"][@"month"][@"g"]]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRetryFailed];
        if (_visitAndOrdersDic[@"data"][@"month"][@"c"]) {
            _visitLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"month"][@"c"]];
        }else{
            _visitLable.text = @"0";
        }
        if (_visitAndOrdersDic[@"data"][@"month"][@"o"]) {
            _newAddLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"month"][@"o"]];
        }else{
            _newAddLable.text = @"0";
        }
        if (_visitAndOrdersDic[@"data"][@"month"][@"m"]) {
            _addMemberLable.text = [NSString stringWithFormat:@"%@",_visitAndOrdersDic[@"data"][@"month"][@"m"]];
        }else{
            _addMemberLable.text = @"0";
        }
    }

    
}

@end
