//
//  ChangePriceView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/16.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ChangePriceView.h"

@implementation ChangePriceView

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:RGBACOLOR(0, 0, 0, 0)];

        [self creaetUI];
        
    }
    return self;
}


-(void)creaetUI
{
    _changeView = [[UITableView alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-125, Main_Screen_Height/2-150, 250, 200)];
    [_changeView setBackgroundColor:[UIColor whiteColor]];
    [_changeView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_changeView];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, Main_Screen_Width-60, 20)];
    [lable setText:@"修改此订单的价格"];
    [lable setTextAlignment:1];
    [lable setFont:[UIFont systemFontOfSize:15]];
    [_changeView addSubview:lable];
    
    
     _text= [[UITextField alloc]initWithFrame:CGRectMake(20, 70, Main_Screen_Width-60-40, 40)];
    [_text.layer setCornerRadius:5];
    [_text.layer setBorderWidth:1];
    [_text.layer setBorderColor:RGBCOLOR(234, 234, 234).CGColor];
    [_text setFont:[UIFont systemFontOfSize:14]];
    [_text setPlaceholder:@"请输入价格"];
//    [text setBackgroundColor:[UIColor redColor]];
    [_changeView addSubview:_text];

    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake((Main_Screen_Width-60)/2-50, 150, 100, 35)];
    [button setBackgroundColor:KMainColor];
    [button.layer setCornerRadius:5];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [_changeView addSubview:button];
}

-(void)buttonAction
{
    if (_text.text.length == 0) {
        [LCProgressHUD showInfoMsg:@"请输入修改金额"];
        return;
    }
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    if (_goodsModel.order_sn) {
        [dic setObject:_goodsModel.order_sn forKey:@"order_sn"];
    }
    
    if (_goodsModel.goods_id) {
        [dic setObject:_goodsModel.goods_id forKey:@"goods_id"];
    }
    
    [dic setObject:_text.text forKey:@"new_price"];
  
    if (userDic[@"ID"]) {
        [dic setObject:userDic[@"ID"] forKey:@"member_id"];
    }
    

    
    [LBProgressHUD showHUDto:self animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kchangeGoodsPrice Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kchangeGoodsPrice == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            if ([self.delegete respondsToSelector:@selector(changePriceViewChangeSuccess)]) {
                [self.delegete changePriceViewChangeSuccess];
                
            }
           [self viewDisapper];
            
        }else {
            [LCProgressHUD showInfoMsg:dic[@"errmsg"]];
        }
        
        
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
    }];

    
}

-(void)viewApper
{
    _ifShow = YES;
    [self setHidden:NO];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_changeView setFrame:CGRectMake(30, Main_Screen_Height/2-150, Main_Screen_Width-60,  200)];
        [self setBackgroundColor:RGBACOLOR(0, 0, 0, 0.5)];
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewDisapper
{
    _ifShow = NO;

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_changeView setFrame:CGRectMake(30, Main_Screen_Height, Main_Screen_Width-60,  200)];
        [self setBackgroundColor:RGBACOLOR(0, 0, 0, 0)];
    } completion:^(BOOL finished) {
        [_changeView setFrame:CGRectMake(Main_Screen_Width, Main_Screen_Height/2-150, Main_Screen_Width-60,  200)];
        [self setHidden:YES];
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self viewDisapper];
    
}

-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
}

@end
