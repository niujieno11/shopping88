//
//  LogisticsInformController.m
//  YunNanBuy
//
//  Created by 张耀文 on 15/11/26.
//  Copyright © 2015年 张耀文. All rights reserved.
//

#import "LogisticsInformController.h"
#import "LogisticsInformCell.h"

@interface LogisticsInformController ()

@end

@implementation LogisticsInformController
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    
//}

-(void)createNavbar{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"物流信息";
    
    _tableArr = [NSMutableArray array];
    
    [self createTable];
    
    [self netWork];
    
    
}



-(void)netWork
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //@"201605182224457621011"
    [dic setObject:_order_bh forKey:@"order_sn"];
    
    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kCheckLogistics Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kCheckLogistics == %@",dic);
        
        [_tableArr removeAllObjects];

        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"][@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                
                _tableArr  = [DeliveryModel objectArrayWithKeyValuesArray:dic[@"data"][@"data"]];

                [_tableView reloadData];

            }
            
        }

        if (_tableArr.count == 0) {
            [self createAlertView:@"没有查到物流信息"];
        }
        
      
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
    
}


-(void)createTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:RGBCOLOR(234, 234, 234)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"logisticsInformCell";
    
    LogisticsInformCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LogisticsInformCell" owner:self options:nil] lastObject];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([_tableArr count]>0) {
        if (indexPath.row == 0) {
            [cell.instructionsLineImageView setHidden:YES];
            
            [cell.instru2Image setHidden:NO];
            [cell.instru2Image setFrame:CGRectMake(15, 20, 20, 80)];
            
        }else {
            [cell.instructionsLineImageView setImage:[UIImage imageNamed:@"line1"]];
            [cell.instructionsLineImageView setHidden:NO];
            [cell.instru2Image setHidden:YES];

        }
        [cell setDeliveryModel:_tableArr[indexPath.row]];
    }
    return cell;
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 100)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *arr = @[@"物流状态：", @"快递公司：", @"运单编号：", @"官方电话："];

    
    for (int i = 0; i<4; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(60, 5+21*i, 70, 15)];
        [lable setText:arr[i]];
        [lable setFont:[UIFont systemFontOfSize:13]];
        [lable setTextColor:RGBCOLOR(90, 90, 90)];
        [view addSubview:lable];
        
        UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(130, 5+21*i, 150, 15)];
        if (i == 0) {
            [lable2 setText:[NSString stringWithFormat:@"%@",@"运输中"]];
        }else if (i == 1) {
            [lable2 setText:[NSString stringWithFormat:@"%@",_deliveryModel.com]];
        }else if (i == 2) {
            [lable2 setText:[NSString stringWithFormat:@"%@",_deliveryModel.codenumber]];
        }else {
            
        }
        [lable2 setTextAlignment:0];
        [lable2 setFont:[UIFont systemFontOfSize:13]];
        [lable2 setTextColor:RGBCOLOR(90, 90, 90)];
        [view addSubview:lable2];
    }
    
    UIButton *phoneButon = [[UIButton alloc]initWithFrame:CGRectMake(130, 65, 150, 20)];
    [phoneButon setTitle:_deliveryModel.comcontact forState:UIControlStateNormal];
    [phoneButon.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [phoneButon setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    phoneButon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [phoneButon addTarget:self action:@selector(phoneButonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:phoneButon];
    
    
    UIView *speView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(view.frame)-10,  self.view.frame.size.width, 10)];
    [speView setBackgroundColor:RGBCOLOR(243, 243, 243)];
    [speView.layer setBorderColor:RGBCOLOR(220, 220, 220).CGColor];
    [speView.layer setBorderWidth:0.5];
    [view addSubview:speView];
    
    return view;
}

-(void)phoneButonAction:(UIButton *)button
{
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", button.titleLabel.text]];
    [[UIApplication sharedApplication] openURL:telURL];
}



@end
