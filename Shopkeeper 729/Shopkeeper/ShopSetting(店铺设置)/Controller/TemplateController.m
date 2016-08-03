//
//  TemplateController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/24.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "TemplateController.h"
#import "TemplateModel.h"

@interface TemplateController ()

@end

@implementation TemplateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"店铺设置";
    _tableArr = [[NSMutableArray alloc]init];
    
    [self netWork];
    
    [self createTable];
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
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kTemplateList Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kTemplateList == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                
                _tableArr = [TemplateModel objectArrayWithKeyValuesArray:dic[@"data"]];
                
            }
        }
        
        if (_tableArr.count == 0) {
            _tableView.hidden = YES;
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:RGBCOLOR(245, 245, 245)];
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
    
    static NSString * cellIndentifier = @"celllll";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celllll"];
    }
    
    
    if (_tableArr.count > 0) {
        
        CGSize itemSize = CGSizeMake(15, 15);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [[UIImage imageNamed:@"unselect_qian"] drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        TemplateModel * model = _tableArr[indexPath.row];
        
        [cell.textLabel setText:model.store_tpl_name];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.textLabel setTextColor:RGBCOLOR(100, 100, 100)];
        
        UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 43.5, Main_Screen_Width, 0.5)];
        lineLable.backgroundColor = RGBCOLOR(225, 225, 225);
        [cell.contentView addSubview:lineLable];
    }
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_tableArr.count > 0) {
        TemplateModel * model = _tableArr[indexPath.row];
        
        NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        if (userDic[@"stores_id"]) {
            [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
            [dic setObject:@"63" forKey:@"store_id"];
        }
        [dic setObject:model.store_tpl_id forKey:@"tpl_id"];

        
        [LBProgressHUD showHUDto:self.view animated:YES];
        
        [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kTemplateUpdatet Parameters:dic style:kConnectPostType success:^(id dic) {
            
//            NSLog(@"kTemplateUpdatet == %@",dic);
            
           
            if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
               
                [LCProgressHUD showSuccess:@"修改成功"];
                
            }
            
            [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
        } failure:^(NSError *error) {
            NSLog(@"NSError = %@",error);
            [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];

    }
    
}


@end
