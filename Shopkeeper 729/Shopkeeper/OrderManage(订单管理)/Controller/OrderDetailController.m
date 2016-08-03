//
//  OrderDetailController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/17.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "OrderDetailController.h"
#import "LogisticsInformController.h"
#import "NSString+Extension.h"

@interface OrderDetailController ()

@end

@implementation OrderDetailController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_flg) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    _flg = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = RGBCOLOR(247, 247, 247);
    self.title = @"订单详情";
    _flg = YES;
    
    [self createSiftView];
    
    [self createTable];
    
    [self createDownView];
    
//    [self netWork];

}

-(void)createNavbar
{
    
}

-(void)backbButtonAction
{
    [_changePriceView viewDisapper];
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    if (_orderListModel.order_sn) {
        [dic setObject:_orderListModel.order_sn forKey:@"order_sn"];
    }

    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kOrderdetail Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kOrderdetail == %@",dic);
        
        
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            OrderListModel * model = [[OrderListModel alloc]init];
            model = [OrderListModel objectWithKeyValues:dic[@"data"]];
            if ([dic[@"data"][@"goods_info"]isKindOfClass:[NSArray class]]) {
                model.goods_info  = [GoodsModel objectArrayWithKeyValuesArray:dic[@"data"][@"goods_info"]];
                
            }
            if ([dic[@"data"][@"op_logs"]isKindOfClass:[NSArray class]]) {
                model.op_logs  = [GoodsModel objectArrayWithKeyValuesArray:dic[@"data"][@"op_logs"]];
            }
            _orderListModel = model;
            [_amountLable setText:[NSString stringWithFormat:@"￥%@",_orderListModel.amount]];

            [_tableView reloadData];
        }
        
        

        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
    
}

-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64-50) style:UITableViewStyleGrouped];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderListCell" bundle:nil] forCellReuseIdentifier:@"OrderListCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.backgroundColor = RGBCOLOR(247, 247, 247);

    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        if (_orderListModel.goods_info.count > 0) {
            return _orderListModel.goods_info.count;
        }else {
            return 0;
        }
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"OrderListCell";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil] lastObject];
    }
    
    
    
    
    if (_orderListModel.goods_info.count > 0) {
        
        if ([_orderListModel.statu isEqualToString:@"待付款"] || _currentViewType == WaitPayViewType) {
            [cell.changePriceBt setHidden:NO];
        }

        GoodsModel * goodsModel = _orderListModel.goods_info[indexPath.row];
        goodsModel.cellIndexPath = indexPath;
        [cell setModel:goodsModel];
        [cell.changePriceBt addTarget:self action:@selector(changePriceBtAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
       return nil;
    }else {
        
      UIView *view = [[UIView alloc]initWithFrame:CGRectMake( 0 , 0, Main_Screen_Width, 10)];
      [view.layer setBorderColor:RGBCOLOR(217, 217, 217).CGColor];
      [view.layer setBorderWidth:0.5];
      [view setBackgroundColor:RGBCOLOR(247, 247, 247)];
      return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
         if ([_orderListModel.statu isEqualToString:@"待收货"] || [_orderListModel.statu isEqualToString:@"待评价"] || [_orderListModel.statu isEqualToString:@"已完成"] || _currentViewType == WaitReceivedViewType || _currentViewType == WaitEvaluateViewType || _currentViewType == FinishViewType) {
             
             return 150;
         }else {
             return 120;
         }
        
    }else if (section == 1) {
        return 50;
    }else if (section == 2){
        return 100;
    }else {
        return 132;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 130)];
    [header setBackgroundColor:[UIColor whiteColor]];
    if (section == 0) {
        UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 130, 40)];
        [faLable setTextColor:RGBCOLOR(100, 100, 100)];
        [faLable setFont:[UIFont systemFontOfSize:11]];
        [faLable setText:@"发货信息"];
        [header addSubview:faLable];
        
        UILabel * xiLineLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 40, Main_Screen_Width-30, 0.5)];
        [xiLineLable setBackgroundColor:RGBCOLOR(230, 230, 230)];
        [header addSubview:xiLineLable];
        
        
        if ([_orderListModel.statu isEqualToString:@"待收货"] || [_orderListModel.statu isEqualToString:@"待评价"] || [_orderListModel.statu isEqualToString:@"已完成"] || _currentViewType == WaitReceivedViewType || _currentViewType == WaitEvaluateViewType || _currentViewType == FinishViewType) {
            NSArray *arr = @[@"快递公司：", @"快递单号："];

            NSMutableArray * arr2 = [[NSMutableArray alloc]init];
            if (_orderListModel.compty) {
                [arr2 addObject:_orderListModel.compty];
            }else {
                [arr2 addObject:@""];
            }
            if (_orderListModel.post_num) {
                [arr2 addObject:_orderListModel.post_num];
            }else {
                [arr2 addObject:@""];
            }
            
            for (int i = 0; i < 2; i++) {
                UILabel * Lable = [[UILabel alloc]initWithFrame:CGRectMake(18+i*(Main_Screen_Width/2-20), 40, 70, 40)];
                [Lable setTextColor:RGBCOLOR(100, 100, 100)];
                [Lable setFont:[UIFont systemFontOfSize:10]];
                [Lable setText:arr[i]];
                [header addSubview:Lable];
                
                UILabel * Lable2 = [[UILabel alloc]initWithFrame:CGRectMake(70+i*(Main_Screen_Width/2-20), 40, 230, 40)];
                [Lable2 setTextColor:RGBCOLOR(40, 40, 40)];
                [Lable2 setFont:[UIFont systemFontOfSize:11]];
                [Lable2 setText:arr2[i]];
                [header addSubview:Lable2];
            }

            UILabel * Lable = [[UILabel alloc]initWithFrame:CGRectMake(18, 70, 70, 40)];
            [Lable setTextColor:RGBCOLOR(100, 100, 100)];
            [Lable setFont:[UIFont systemFontOfSize:10]];
            [Lable setText:@"发货备注:"];
            [header addSubview:Lable];
            
            UILabel * xiLineLable2 = [[UILabel alloc]initWithFrame:CGRectMake(18, 110, Main_Screen_Width-30, 0.5)];
            [xiLineLable2 setBackgroundColor:RGBCOLOR(230, 230, 230)];
            [header addSubview:xiLineLable2];
            
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
            [formatter1 setDateFormat:@"YYYY年MM月dd日"];
            //时间戳转时间
            NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970: [_orderListModel.add_time doubleValue]];
            //时间按格式转字符串
            NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
            
            
            NSString * opNameStr = @"";
            
            if (_orderListModel.op_logs.count > 0) {
                GoodsModel * opLog = _orderListModel.op_logs[0];
                opNameStr = opLog.remark;
            }
            
            
            UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 120, 260, 20)];
            [faLable setTextColor:[UIColor greenColor]];
            [faLable setFont:[UIFont systemFontOfSize:11]];
            [faLable setText:[NSString stringWithFormat:@"%@%@", confromTimespStr1, opNameStr]];
            [header addSubview:faLable];
            
            UIButton * cheakLogisticsInform = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-80, 120, 70, 22)];
            [cheakLogisticsInform.layer setCornerRadius:4];
            [cheakLogisticsInform setTitleColor:KMainColor forState:UIControlStateNormal];
            [cheakLogisticsInform.layer setBorderWidth:0.5];
            [cheakLogisticsInform.layer setBorderColor:KMainColor.CGColor];
            [cheakLogisticsInform addTarget:self action:@selector(CheakLogisticsInformAction) forControlEvents:UIControlEventTouchUpInside];
            [cheakLogisticsInform.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [cheakLogisticsInform setTitle:@"查看物流" forState:UIControlStateNormal];
            [header addSubview:cheakLogisticsInform];
            
        }else {
            UILabel * orderSN = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 130, 40)];
            [orderSN setTextColor:RGBCOLOR(100, 100, 100)];
            [orderSN setFont:[UIFont systemFontOfSize:12]];
            [header addSubview:orderSN];
            
            NSArray *arr = @[@"发货地址：", @"收货人：", @"收货人电话："];
            
            NSMutableArray * arr2 = [[NSMutableArray alloc]init];
            if (_orderListModel.receive_address) {
                [arr2 addObject:_orderListModel.receive_address];
            }else {
                [arr2 addObject:@""];
            }
            if (_orderListModel.receive_name) {
                [arr2 addObject:_orderListModel.receive_name];
            }else {
                [arr2 addObject:@""];
            }
            if (_orderListModel.receive_mobile) {
                [arr2 addObject:_orderListModel.receive_mobile];
            }else {
                [arr2 addObject:@""];
            }
            
            
            for (int i = 0; i < 3; i++) {
                UILabel * Lable = [[UILabel alloc]initWithFrame:CGRectMake(18, 40+i*20, 70, 40)];
                [Lable setTextColor:RGBCOLOR(100, 100, 100)];
                [Lable setFont:[UIFont systemFontOfSize:11]];
                [Lable setText:arr[i]];
                [header addSubview:Lable];
                
                UILabel * Lable2 = [[UILabel alloc]initWithFrame:CGRectMake(88, 40+i*20, 230, 40)];
                [Lable2 setTextColor:RGBCOLOR(40, 40, 40)];
                [Lable2 setFont:[UIFont systemFontOfSize:12]];
                [Lable2 setText:arr2[i]];
                [header addSubview:Lable2];
            }
        }
       
        
    }else if (section == 1){
        UILabel * snLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 10, 260, 40)];
        [snLable setTextColor:RGBCOLOR(100, 100, 100)];
        [snLable setFont:[UIFont systemFontOfSize:12]];
        [snLable setText:[NSString stringWithFormat:@"订单号：%@",_orderListModel.order_sn]];
        [header addSubview:snLable];
        
        UILabel * snnLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width-18-70, 10, 70, 40)];
        [snnLable setTextColor:KMainColor];
        [snnLable setFont:[UIFont systemFontOfSize:13]];
        [snnLable setText:_orderListModel.statu];
        [snnLable setTextAlignment:2];
        [header addSubview:snnLable];
        
        UILabel * xiLineLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 50, Main_Screen_Width-30, 0.5)];
        [xiLineLable setBackgroundColor:RGBCOLOR(247, 247, 247)];
        [header addSubview:xiLineLable];
    }else if (section == 2){
        UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 130, 40)];
        [faLable setTextColor:RGBCOLOR(100, 100, 100)];
        [faLable setFont:[UIFont systemFontOfSize:11]];
        [faLable setText:@"买家留言"];
        [header addSubview:faLable];
        
        UILabel * xiLineLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 40, Main_Screen_Width-30, 0.5)];
        [xiLineLable setBackgroundColor:RGBCOLOR(230, 230, 230)];
        [header addSubview:xiLineLable];
        
        CGSize size =[_orderListModel.remark sizeWithFont:[UIFont systemFontOfSize:11] maxSize:CGSizeMake( Main_Screen_Width-20, MAXFLOAT)];
        
        UILabel * liuLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Main_Screen_Width-20, size.height)];
        [liuLable setTextColor:RGBCOLOR(100, 100, 100)];
        [liuLable setFont:[UIFont systemFontOfSize:11]];
        [liuLable setText:_orderListModel.remark];
        [header addSubview:liuLable];
        
    }else {
        NSArray *arr = @[@"商品金额：", @"积分抵扣：", @"运费："];
        
         NSString * jifeng;
        if ([_orderListModel.credit integerValue] == 0) {
            jifeng = [NSString stringWithFormat:@"¥%@",_orderListModel.credit];
        }else {
            jifeng = [NSString stringWithFormat:@"-¥%@",_orderListModel.credit];
        }
       
        
        NSArray * arr2 = @[[NSString stringWithFormat:@"¥%@",_orderListModel.amount], jifeng, [NSString stringWithFormat:@"¥%@",_orderListModel.youfei]];
        
        for (int i = 0; i < 3; i++) {
            UILabel * Lable = [[UILabel alloc]initWithFrame:CGRectMake(18, i*44, 70, 44)];
            [Lable setTextColor:RGBCOLOR(100, 100, 100)];
            [Lable setFont:[UIFont systemFontOfSize:11]];
            [Lable setText:arr[i]];
            [header addSubview:Lable];
            
            UILabel * Lable2 = [[UILabel alloc]initWithFrame:CGRectMake(88, i*44, Main_Screen_Width-88-15, 44)];
            [Lable2 setTextColor:RGBCOLOR(218, 18, 43)];
            [Lable2 setFont:[UIFont systemFontOfSize:15]];
            [Lable2 setText:arr2[i]];
            [Lable2 setTextAlignment:2];
            [header addSubview:Lable2];
            
            
            UILabel * xiLineLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 44+i*44, Main_Screen_Width-30, 0.5)];
            [xiLineLable setBackgroundColor:RGBCOLOR(230, 230, 230)];
            [header addSubview:xiLineLable];
        }

    }
    return header;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)createDownView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-50-64, Main_Screen_Width, 50)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    
    UILabel * xiLineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    [xiLineLable setBackgroundColor:RGBCOLOR(226, 226, 226)];
    [view addSubview:xiLineLable];
    
 
    
    if (_currentViewType == AllStatesViewType) {
        
        if ([_orderListModel.statu isEqualToString:@"待付款"] || [_orderListModel.statu isEqualToString:@"待发货"]) {
            UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 5, 50, 45)];
            [faLable setTextColor:[UIColor blackColor]];
            [faLable setFont:[UIFont systemFontOfSize:14]];
            [faLable setText:@"合计："];
            [view addSubview:faLable];
            
            UILabel * faaLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 130, 50)];
            [faaLable setTextColor:[UIColor redColor]];
            [faaLable setFont:[UIFont systemFontOfSize:25]];
            [faaLable setText:[NSString stringWithFormat:@"￥%@",_orderListModel.amount]];
            [view addSubview:faaLable];
            _amountLable = faaLable;
        }else if ([_orderListModel.statu isEqualToString:@"待收货"] || [_orderListModel.statu isEqualToString:@"待评价"] || [_orderListModel.statu isEqualToString:@"已完成"]) {
            [view setHidden:YES];
            [_tableView setFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64)];
            
        }else {
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
            [formatter1 setDateFormat:@"YYYY/MM/dd"];
            //时间戳转时间
            NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970: [_orderListModel.add_time doubleValue]];
            //时间按格式转字符串
            NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
            //            _lastVistTimeLable.text = [NSString stringWithFormat:@"注册时间:%@", confromTimespStr1];
            
            NSString * opNameStr;
            
            if (_orderListModel.op_logs.count > 0) {
                GoodsModel * opLog = _orderListModel.op_logs[0];
                opNameStr = opLog.remark;
            }
            
            
            UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 260, 50)];
            [faLable setTextColor:RGBCOLOR(211, 13, 37)];
            [faLable setFont:[UIFont systemFontOfSize:14]];
            [faLable setText:[NSString stringWithFormat:@"%@ %@", confromTimespStr1, opNameStr]];
            [view addSubview:faLable];
            
        }
        
    //待付款 && 待发货
    }else if (_currentViewType == WaitPayViewType || _currentViewType == WaitSendViewType) {
        UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 5, 50, 45)];
        [faLable setTextColor:[UIColor blackColor]];
        [faLable setFont:[UIFont systemFontOfSize:14]];
        [faLable setText:@"合计："];
        [view addSubview:faLable];
        
        UILabel * faaLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 130, 50)];
        [faaLable setTextColor:[UIColor redColor]];
        [faaLable setFont:[UIFont systemFontOfSize:25]];
        [faaLable setText:[NSString stringWithFormat:@"￥%@",_orderListModel.amount]];
        [view addSubview:faaLable];
        _amountLable = faaLable;
    //待收货 && 待评价 && 已完成
    }else if (_currentViewType == WaitReceivedViewType || _currentViewType == WaitEvaluateViewType ||_currentViewType == FinishViewType) {
        [view setHidden:YES];
        [_tableView setFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64)];
    
    //退款订单 && 取消
    }else if (_currentViewType == RefundMoneyViewType || _currentViewType == FailureViewType) {
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init] ;
        [formatter1 setDateFormat:@"YYYY/MM/dd"];
        //时间戳转时间
        NSDate *confromTimesp1 = [NSDate dateWithTimeIntervalSince1970: [_orderListModel.add_time doubleValue]];
        //时间按格式转字符串
        NSString *confromTimespStr1 = [formatter1 stringFromDate:confromTimesp1];
        
        
        NSString * opNameStr = @"";
        
        if (_orderListModel.op_logs.count > 0) {
            GoodsModel * opLog = _orderListModel.op_logs[0];
            opNameStr = opLog.remark;
        }
        
        
        UILabel * faLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 260, 50)];
        [faLable setTextColor:RGBCOLOR(211, 13, 37)];
        [faLable setFont:[UIFont systemFontOfSize:14]];
        [faLable setText:[NSString stringWithFormat:@"%@ %@", confromTimespStr1, opNameStr]];
        [view addSubview:faLable];
    }
    
}




//修改价格
-(void)changePriceBtAction:(IndexPathBt *)bt
{
    if (_orderListModel.goods_info.count > 0) {
        
        GoodsModel * goodsModel = _orderListModel.goods_info[bt.indexPath.row];
        
        [_changePriceView setGoodsModel:goodsModel];
    }
    
    _currentSelectIndexPath = bt.indexPath;
    
    [_changePriceView viewApper];
}

-(ChangePriceView *)createSiftView
{
    
    if (!_changePriceView) {
        _changePriceView = [[ChangePriceView alloc]initWithFrame:CGRectMake(0, 64.5, Main_Screen_Width, Main_Screen_Height)];
        _changePriceView.delegete = self;
        [_changePriceView setHidden:YES];
        [[UIApplication sharedApplication].keyWindow addSubview:_changePriceView];
    }
    return _changePriceView;
}

 
#pragma mark - 修改价格成功
-(void)changePriceViewChangeSuccess
{
    [self netWork];
}


#pragma mark - 物流查询
-(void)CheakLogisticsInformAction
{
    _flg = NO;
    LogisticsInformController * l = [[LogisticsInformController alloc]init];
    l.order_bh = _orderListModel.order_sn;
    [self.navigationController pushViewController:l animated:YES];
    
}

@end
