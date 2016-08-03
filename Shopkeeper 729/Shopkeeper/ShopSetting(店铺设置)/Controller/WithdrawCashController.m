//
//  WithdrawCashController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "WithdrawCashController.h"
#import "AddBankCardController.h"

@interface WithdrawCashController ()

@end

@implementation WithdrawCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(243, 243, 243);
    self.title = @"提现设置";
    
 
    [self createTable];
}


-(void)createTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-kNavBarStatusBarHeight) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"WithdrawCashCell" bundle:nil] forCellReuseIdentifier:@"WithdrawCashCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:RGBCOLOR(243, 243, 243)];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"WithdrawCashCell";
    WithdrawCashCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WithdrawCashCell" owner:self options:nil] lastObject];
    }
    
    NSArray * arr = @[@"银行", @"支付宝"];
    
    NSArray * imageNameArr = @[@"yinLiang", @"aliPay"];

    
    cell.payNameLable.text = arr[indexPath.section];
    
    UIImageView * logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 20)];
    
    if (indexPath.section == 0) {
        
    }else {
        [logoImage setFrame:CGRectMake(15, 10, 25, 25)];
    }
    logoImage.image = [UIImage imageNamed: imageNameArr[indexPath.section]];
    [cell.contentView addSubview:logoImage];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5, Main_Screen_Width, 0.5)];
    [lable setBackgroundColor:RGBCOLOR(213, 213, 213)];
    [cell.contentView addSubview:lable];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
    [view setBackgroundColor:RGBCOLOR(243, 243, 243)];
    
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, Main_Screen_Width, 0.5)];
    [lable setBackgroundColor:RGBCOLOR(213, 213, 213)];
    [view addSubview:lable];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AddBankCardController * add = [[AddBankCardController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
    
}



@end
