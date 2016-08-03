//
//  AddBankCardController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/27.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AddBankCardController.h"

@interface AddBankCardController ()

@end

@implementation AddBankCardController

-(void)createNavbar
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:RGBCOLOR(243, 243, 243)];
    self.title = @"银行卡";
    
    [saveBtutton.layer setCornerRadius:5];
    
    [self creteUi];
}

- (void)creteUi{
    
    NSArray * arr = @[@"       真实姓名", @"       身份证号", @"       开户银行", @"       银行账户"];
    for (int i = 0; i < arr.count; i++) {
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 60+50*i, Main_Screen_Width, 50)];
        [lable setText:arr[i]];
        [lable setFont:[UIFont systemFontOfSize:12]];
        [lable setTextColor:RGBCOLOR(100, 100, 100)];
//        [lable setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:lable];
        
        
        UITextField * text = [[UITextField alloc]initWithFrame:CGRectMake(80, 60+50*i, 250, 50)];
        [text setTextColor:RGBCOLOR(40, 40, 40)];
//        [text setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:text];
        
        if (i == 0) {
            _nameTextField = text;
        }else  if (i == 1) {
            _shenFengTextField = text;
        }else  if (i == 2) {
            _bankNameTextField = text;
        }else if (i == 3) {
            _bankNumTextField = text;
            return;
        }
        
        UILabel * lableline = [[UILabel alloc]initWithFrame:CGRectMake(10, 110+50*i, Main_Screen_Width-20, 0.5)];
        [lableline setBackgroundColor:RGBCOLOR(213, 213, 213)];
        [self.view addSubview:lableline];
        
        
    }  

}

- (IBAction)saveButtonAction:(id)sender {
    
    if (_nameTextField.text.length == 0) {
        [self createAlertView:@"请输入姓名"];
        return;
    }
        
    if (_shenFengTextField.text.length == 0) {
        [self createAlertView:@"请输入身份证号码"];
        return;

    }
    
    if (_bankNameTextField.text.length == 0) {
        
    }
    
    if (_bankNumTextField.text.length == 0) {
        [self createAlertView:@"请输入银行卡号"];
        return;
    }
    
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_code"];
    }
    
    [dic setObject:_nameTextField.text forKey:@"bank_truename"];
    
    [dic setObject:_shenFengTextField.text forKey:@"bank_truename"];

    [dic setObject:_bankNameTextField.text forKey:@"bank_name"];

    [dic setObject:_bankNumTextField.text forKey:@"bank_card_name"];

    
    [LBProgressHUD showHUDto:self.view animated:YES];
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kAddBankCard Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kAddBankCard == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
        }
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];

    
    
    
}


@end
