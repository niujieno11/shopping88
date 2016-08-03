//
//  MyRankController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/29.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "MyRankController.h"
#import "MyRankCell.h"

@interface MyRankController ()

@end

@implementation MyRankController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    _tableArr = [[NSMutableArray alloc]init];
    
    [self createNavbar];
    
    [self createTable];
    
    [self netWork];

}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 64)];
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
    [titleLable setText:@"我的排名"];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
}

-(void)backbButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"stores_id"];
    }
    
    [LBProgressHUD showHUDto:self.view animated:YES];

    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kMyRank Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kMyRank == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                
                _tableArr = [MyRankModel objectArrayWithKeyValuesArray:dic[@"data"]];
                
                [_tableView reloadData];
                
            }else {
                
                
            }
        }
        
        //        if (_tableArr.count == 0) {
        //            _tableView.hidden = YES;
        //        }else {
        //            _tableView.hidden = NO;
        //        }
        [_tableView reloadData];
        
        
         [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
    
    
}

-(void)createTable
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-kNavBarStatusBarHeight) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TodayVisitCell" bundle:nil] forCellReuseIdentifier:@"TodayVisitCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableArr.count > 0) {
        return _tableArr.count;
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"MyRankCell";
    MyRankCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyRankCell" owner:self options:nil] lastObject];
    }
    
    
    
    if (_tableArr.count > 0) {
        
          [cell setModel: _tableArr[indexPath.row]];
        
    }
    
    return cell;
}




@end
