//
//  FinancialFlowController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/18.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "FinancialFlowController.h"
#import "FinancialModel.h"
#import "FinancialManagementCell.h"

@interface FinancialFlowController ()

@end

@implementation FinancialFlowController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"财务流水";
    _tableArr = [[NSMutableArray alloc]init];
    
    [self createTable];
    
    [self netWork];
}

-(void)createNavbar
{
    
}
-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kFinancial Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kFinancial == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                
                _tableArr = [FinancialModel objectArrayWithKeyValuesArray:dic[@"data"]];
                
                
                [_tableView reloadData];
                
            }else {
                
                
            }
        }
        
        if (_tableArr.count == 0) {
            _tableView.hidden = YES;
            [self createAlertView:@"未查询到相关记录！"];
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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-kNavBarStatusBarHeight) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"FinancialManagementCell" bundle:nil] forCellReuseIdentifier:@"FinancialManagementCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableArr.count > 0) {
        return _tableArr.count;
    }else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"FinancialManagementCell";
    FinancialManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FinancialManagementCell" owner:self options:nil] lastObject];
    }
    
    
    
    if (_tableArr.count > 0) {
        
        [cell setModel: _tableArr[indexPath.section]];
        
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
