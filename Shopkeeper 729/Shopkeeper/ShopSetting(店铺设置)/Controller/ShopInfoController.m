//
//  ShopInfoController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ShopInfoController.h"
#import "NSString+Extension.h"

@interface ShopInfoController ()

@end

@implementation ShopInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    self.title = @"店铺信息";
    
    [self creaetTiShiLable];
}

-(void)createNavbar
{
    
}

-(void)creaetTiShiLable
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;

    NSArray * arr;
    NSArray * arr2;

    //地区
    NSString  * area = [NSString stringWithFormat:@"%@ %@",userDic[@"province_name"], userDic[@"city_name"]];
    
    //地址
    NSString * address = userDic[@"address"];
    
    
    if ([userDic[@"store_type"] isEqualToString:@"1"]) {
        arr = @[@"店铺名称", @"店铺编号", @"所在地区", @"联系地址", @"是否发货", @"库存管理", @"店铺类型", @"保证金", @"是否支持假货赔付"];
        arr2 = @[userDic[@"stores_name"], userDic[@"store_code"], area, address, userDic[@"is_shipping_name"],userDic[@"store_tools_name"], userDic[@"store_type_name"],
                 userDic[@"is_guarantee_name"], userDic[@"is_guarantee_name"]];
        
        
        
    }else {
        arr = @[@"店铺名称", @"店铺编号", @"上级", @"所在地区", @"联系地址", @"是否发货", @"库存管理", @"店铺类型", @"保证金", @"是否支持假货赔付"];
        arr2 = @[userDic[@"stores_name"], userDic[@"store_code"], userDic[@"store_code"], area, address, userDic[@"is_shipping_name"], userDic[@"store_tools_name"],userDic[@"store_type_name"],  userDic[@"is_guarantee_name"], userDic[@"is_guarantee_name"]];

    }
    
    CGSize size =[address sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(100, MAXFLOAT)];

    _baseview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Height, Main_Screen_Height-kNavBarStatusBarHeight)];
    [_baseview setContentSize:CGSizeMake(0, arr.count*50+size.height)];
    [_baseview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_baseview];
    

    CGFloat addresslableH = 50;
    CGFloat lineMoreCellSpace = 0;
    CGFloat moreCellSpace = 0;

    for (int i = 0; i <  arr.count; i++) {
        if (arr.count == 9) {
            if (i == 3) {
                addresslableH = size.height+50;
                lineMoreCellSpace = size.height;
            }else if (i > 3) {
                moreCellSpace = size.height;
                addresslableH = 50;
            }
        }else {
            if (i == 4) {
                addresslableH = size.height+50;
                lineMoreCellSpace = size.height;
            }else if (i > 4) {
                moreCellSpace = size.height;
                addresslableH = 50;
            }
        }
        
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0+50*i+moreCellSpace, 100, 50)];
        [lable setText:arr[i]];
        [lable setFont:[UIFont systemFontOfSize:12]];
        [lable setTextColor:RGBCOLOR(80, 80, 80)];
        [_baseview addSubview:lable];
        
        UILabel * lable2 = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-150, 0+50*i+moreCellSpace, 130, addresslableH)];
        [lable2 setNumberOfLines:0];
        [lable2 setTextAlignment:2];
        [lable2 setText:arr2[i]];
        [lable2 setFont:[UIFont systemFontOfSize:12]];
        [lable2 setTextColor:RGBCOLOR(80, 80, 80)];
//        if (i == 4) {
//            [lable2 setBackgroundColor:[UIColor redColor]];
//        }
        [_baseview addSubview:lable2];
        
        
        UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 50+50*i+lineMoreCellSpace, Main_Screen_Height, 0.5)];
        [lineLable setBackgroundColor:RGBCOLOR(235, 235, 235)];
        [_baseview addSubview:lineLable];
    }
}
@end
