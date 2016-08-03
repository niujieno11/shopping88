//
//  ShopSettingController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/24.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ShopSettingController.h"
#import "UIImageView+WebCache.h"
#import "TemplateController.h"
#import "ShopLogoAndBannerController.h"
#import "ShopInfoController.h"
#import "ShopCodeController.h"
#import "FengXiaoCodeController.h"
#import "WithdrawCashController.h"

@interface ShopSettingController ()

@end

@implementation ShopSettingController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;

    [_shopLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , userDic[@"logo"]]] placeholderImage:nil options:SDWebImageRetryFailed];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"店铺设置";
    
    [self createTable];
}

-(void)createNavbar
{
    
}

-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-kNavBarStatusBarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==  0) {
        if (indexPath.row == 0) {
            return 70;
        }else {
            return 44;
        }
    }else if (indexPath.section ==  1){
        return 44;
    }else {
        return 44;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"1"]) {
        return 6;
    }else {
        return 5;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==  0) {
        return 2;
    }else if (section ==  1){
        return 3;
    }else {
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    [cell.textLabel setTextColor:RGBCOLOR(100, 100, 100)];
    
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5, Main_Screen_Width, 0.5)];
    lineLable.backgroundColor = RGBCOLOR(200, 200, 200);
    [cell.contentView addSubview:lineLable];

    
    if (indexPath.section ==  0) {
        
        NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;

        if (indexPath.row == 0) {
            cell.textLabel.text = @"店铺标志/头像";
            [lineLable setFrame:CGRectMake(0, 69.5, Main_Screen_Width, 0.5)];
            _shopLogo = [[UIImageView alloc]initWithFrame:CGRectMake(Main_Screen_Width - 60, 10, 40, 40)];
            [_shopLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , userDic[@"logo"]]] placeholderImage:nil options:SDWebImageRetryFailed];
            [cell.contentView addSubview:_shopLogo];
            
        }else {
            cell.textLabel.text = @"店铺店铺名称";
            
            UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-170, 0, 150, 44)];
            [nameLable setText:userDic[@"stores_name"]];
            [nameLable setTextAlignment:2];
            [nameLable setFont:[UIFont systemFontOfSize:15]];
            [nameLable setTextColor:RGBCOLOR(50, 50, 50)];
            [cell.contentView addSubview:nameLable];
        }
    }else {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"模板设置";
            }else if (indexPath.row == 1) {
                cell.textLabel.text = @"店铺招牌图设置";
            }else if (indexPath.row == 2) {
                cell.textLabel.text = @"店铺信息";
            }
        }else if (indexPath.section == 2) {
           cell.textLabel.text = @"实名认证";
        }else if (indexPath.section == 3) {
            if ([[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"1"]) {
                cell.textLabel.text = @"年服务费";
            }else {
                cell.textLabel.text = @"店铺二维码";
            }
        }else if (indexPath.section == 4) {
            if ([[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"1"]) {
                cell.textLabel.text = @"店铺二维码";
            }else {
                cell.textLabel.text = @"分销二维码";
            }
        }else {
           cell.textLabel.text = @"分销二维码";
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }

   return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"1"]) {
        if (section == 5) {
            return 0;
        }
    }else {
        if (section == 4) {
            return 0;
        }
    }
    
    return 10;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
    [view setBackgroundColor:RGBCOLOR(245, 245, 245)];
    
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, Main_Screen_Width, 0.5)];
    lineLable.backgroundColor = RGBCOLOR(200, 200, 200);
    [view addSubview:lineLable];

    
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           
            
        }else if (indexPath.row == 1) {
            
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TemplateController * tem = [[TemplateController alloc]init];
            [self.navigationController pushViewController:tem animated:YES];
        }else if (indexPath.row == 1) {
            ShopLogoAndBannerController *logo = [[ShopLogoAndBannerController alloc]init];
            [self.navigationController  pushViewController:logo animated:YES];
        }else if (indexPath.row == 2) {
            ShopInfoController *shopInfo = [[ShopInfoController alloc]init];
            [self.navigationController  pushViewController:shopInfo animated:YES];
        }
    }else if (indexPath.section == 2) {
        //实名认证
       
    }else if (indexPath.section == 3) {
        if ([[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"1"]) {
            //年服务费
            
        }else {
            ShopCodeController *shopCode = [[ShopCodeController alloc]init];
            [self.navigationController  pushViewController:shopCode animated:YES];
        }
        
        
        
    }else if (indexPath.section == 4){
        if ([[UserInfo shareUserInfoSingleton].userDataModel.store_type isEqualToString:@"1"]) {
            ShopCodeController *shopCode = [[ShopCodeController alloc]init];
            [self.navigationController  pushViewController:shopCode animated:YES];
        }else {
            FengXiaoCodeController *fengXiao = [[FengXiaoCodeController alloc]init];
            [self.navigationController  pushViewController:fengXiao animated:YES];
        }
    }else if (indexPath.section == 4){
        FengXiaoCodeController *fengXiao = [[FengXiaoCodeController alloc]init];
        [self.navigationController  pushViewController:fengXiao animated:YES];
    }
    
}

@end
