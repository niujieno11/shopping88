//
//  AddCustomerController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/11.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AddCustomerController.h"
#import "VisitMostCell.h"
#import "AddCustomerModel.h"

#define navH 120
@interface AddCustomerController ()

@end

@implementation AddCustomerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _sifitStr= @"today";
    _sifitStr2= @"time";
    _tableArr = [[NSMutableArray alloc]init];
    
    
    [self createNavbar];
    
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
    [titleLable setText:@"发展客户"];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
    
    UISegmentedControl *topSegment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@" 今日 ",@" 本周 ", @" 本月 ", @" 所有 ", nil]];
    [topSegment setFrame:CGRectMake(Main_Screen_Width/2-120, 75, 233, 30)];
    [topSegment setTintColor:[UIColor whiteColor]];
    [topSegment setBackgroundColor:RGBCOLOR(194, 0, 87)];
    [topSegment.layer setCornerRadius:4];
    [topSegment.layer setBorderWidth:0.5];
    [topSegment.layer setBorderColor:[UIColor whiteColor].CGColor];
    [topSegment addTarget:self action:@selector(topSegmentAction:) forControlEvents:UIControlEventValueChanged];
    [topSegment setSelectedSegmentIndex:0];
    [navView addSubview:topSegment];
    
    NSArray * nameArr = @[@"新增时间", @"浏览最多"];
    for (int i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/2*i, navH, Main_Screen_Width/2, 38)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)backbButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)topSegmentAction:(UISegmentedControl *)topSegment
{
    if (topSegment.selectedSegmentIndex == 0) {
        
        _sifitStr= @"today";
        
    }else  if (topSegment.selectedSegmentIndex == 1) {
        _sifitStr= @"week";
    }else if (topSegment.selectedSegmentIndex == 3){
        _sifitStr= @"month";
    }else {
        _sifitStr= @"all";
        
    }
    [self netWork];
}

-(void)buttonAction:(UIButton *)bt
{
    _currentSelectButton.selected = NO;
    [_currentSelectButton setBackgroundColor:RGBCOLOR(234, 234, 234)];
    
    bt.selected = YES;
    [bt setBackgroundColor:[UIColor whiteColor]];
    
    _currentSelectButton = bt;
    
    if ([bt.titleLabel.text isEqualToString:@"新增时间"]) {
        _sifitStr2= @"time";

    }else {
        _sifitStr2= @"num";

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
    
    [dic setObject:_sifitStr forKey:@"time"];
    [dic setObject:_sifitStr2 forKey:@"mod"];

    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kMy_member Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kMy_member == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            _tableArr = [AddCustomerModel objectArrayWithKeyValuesArray:dic[@"data"]];
            
        }
        
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (_tableArr.count == 0) {

            [self createAlertView:@"未查到相关信息"];
        }
        
        [_tableView reloadData];
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navH+38, Main_Screen_Width, Main_Screen_Height-navH-38) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"CustomerCell" bundle:nil] forCellReuseIdentifier:@"CustomerCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableArr.count > 0) {
        return _tableArr.count;
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"VisitMostCell";
    VisitMostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"VisitMostCell" owner:self options:nil] lastObject];
    }
    
    if (_tableArr.count > 0) {
        
        [cell setModel2:_tableArr[indexPath.row]];
        
    }
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_tableArr.count > 0) {
        
    }
    
}

@end
