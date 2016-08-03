//
//  FengXiaoController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/23.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FengXiaoController.h"
#import "CustomerCell.h"
#import "CustomerModel.h"
#import "DistributionDetailsController.h"

@interface FengXiaoController ()

@end

#define navH 120

@implementation FengXiaoController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     
    _siftStr = @"1";
    _siftStr2 = @"add_time";

    _tableArr = [[NSMutableArray alloc]init];

    
    [self createNavbar];
    
    [self createThreeButton];
    
    [self createTable];

    [self netWork];
    
}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, navH)];
    [navView setBackgroundColor:KMainColor];
    [self.view addSubview:navView];
    
    //2.登录按钮
    UIButton * backbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [backbButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbButton addTarget:self action:@selector(backbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backbButton setBackgroundColor:[UIColor blueColor]];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(7, 17, 7, 17)];
    [self.view addSubview:backbButton];
    
    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-50, 35, 100, 20)];
    [titleLable setText:@"分销管理"];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
    
    UISegmentedControl *topSegment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@" 一级分销 ",@" 二级分销 ", @" 三级分销 ", nil]];
    [topSegment setFrame:CGRectMake(Main_Screen_Width/2-120, 75, 233, 30)];
    [topSegment setTintColor:[UIColor whiteColor]];
    [topSegment setBackgroundColor:RGBCOLOR(194, 0, 87)];
    [topSegment.layer setCornerRadius:4];
    [topSegment.layer setBorderWidth:0.5];
    [topSegment.layer setBorderColor:[UIColor whiteColor].CGColor];
    [topSegment addTarget:self action:@selector(topSegmentAction:) forControlEvents:UIControlEventValueChanged];
    [topSegment setSelectedSegmentIndex:0];
    [navView addSubview:topSegment];
}

-(void)topSegmentAction:(UISegmentedControl *)topSegment
{
    if (topSegment.selectedSegmentIndex == 0) {
        
        _siftStr = @"1";
        
    }else  if (topSegment.selectedSegmentIndex == 1) {
        
        _siftStr = @"2";
        
    }else {
        _siftStr = @"3";
    }
    [self netWork];
}


-(void)backbButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)createThreeButton
{
    NSArray * nameArr = @[@"注册时间", @"销售额度"];
    for (int i = 0; i < nameArr.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/nameArr.count*i, navH, Main_Screen_Width/nameArr.count, 38)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(transactionViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBCOLOR(234, 234, 234)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton = button;
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

-(void)transactionViewAction:(UIButton *)bt
{
    _currentSelectButton.selected = NO;
    [_currentSelectButton setBackgroundColor:RGBCOLOR(234, 234, 234)];
    
    bt.selected = YES;
    [bt setBackgroundColor:[UIColor whiteColor]];
    
    _currentSelectButton = bt;
    
    [_tableArr removeAllObjects];
    if ([bt.titleLabel.text isEqualToString:@"一级分销"]) {
        _siftStr2 = @"add_time";

    }else {
       _siftStr2 = @"money";
    }
    [self netWork];
}


-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    [dic setObject:_siftStr forKey:@"level"];

    [dic setObject:_siftStr2 forKey:@"mod"];

    
    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kFenxiaor Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kFenxiaor == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            _tableArr = [CustomerModel objectArrayWithKeyValuesArray:dic[@"data"]];

        }
        
        if (_tableArr.count == 0) {
            _tableView.hidden = YES;
            [self createAlertView:@"没有下级分销"];
        }else {
            _tableView.hidden = NO;
        }
        [_tableView reloadData];
        
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
    
}

-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navH+38, Main_Screen_Width, Main_Screen_Height-38-navH) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"CustomerCell" bundle:nil] forCellReuseIdentifier:@"CustomerCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableArr.count > 0) {
        return _tableArr.count;
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"CustomerCell";
    CustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomerCell" owner:self options:nil] lastObject];
    }
    
    
    if (_tableArr.count > 0) {
        cell.type = @"fenxiao";
        [cell setModel: _tableArr[indexPath.row]];
    }
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_tableArr.count > 0) {
        CustomerModel * model = _tableArr[indexPath.row];
        
        DistributionDetailsController * detail = [[DistributionDetailsController alloc]init];
        detail.numberID = [model.member_id integerValue];
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

@end
