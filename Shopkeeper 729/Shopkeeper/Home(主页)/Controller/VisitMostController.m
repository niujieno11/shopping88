//
//  VisitMostController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/29.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "VisitMostController.h"
#import "VisitMostCell.h"
#import "VisitMostModel.h"
#define navH 120
@interface VisitMostController ()

@end

@implementation VisitMostController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _sifitStr= @"today";
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
    [titleLable setText:@"浏览最多"];
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

-(void)transactionViewAction:(UIButton *)bt
{
//    _currentSelectButton.selected = NO;
//    [_currentSelectButton setBackgroundColor:RGBCOLOR(234, 234, 234)];
//    
//    bt.selected = YES;
//    [bt setBackgroundColor:[UIColor whiteColor]];
//    
//    _currentSelectButton = bt;
//    
//    [_tableArr removeAllObjects];
//    if ([bt.titleLabel.text isEqualToString:@"今日"]) {
//        [_tableArr addObjectsFromArray:_firstArr];
//        
//    }else if ([bt.titleLabel.text isEqualToString:@"昨日"]){
//        [_tableArr addObjectsFromArray:_secondArr];
//        
//        
//    }else {
//        [_tableArr addObjectsFromArray:_thirdArr];
//        
//    }
//    [_tableView reloadData];
}


-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"stores_id"];
    }
    
    [dic setObject:_sifitStr forKey:@"day"];

    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsViews Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kGoodsViews == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            _tableArr = [VisitMostModel objectArrayWithKeyValuesArray:dic[@"data"]];
            
        }
        
        if (_tableArr.count == 0) {
            [self createAlertView:@"没有记录"];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH) style:UITableViewStylePlain];
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
        
        [cell setModel: _tableArr[indexPath.row]];
        
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
