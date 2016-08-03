//
//  ClassifyListController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ClassifyListController.h"
#import "MyOnSellAllGoodsListCell.h"

@interface ClassifyListController ()

@end

@implementation ClassifyListController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = [NSString stringWithFormat:@"分类查看-%@",self.className];
    
    _urlTyleStr = kXinpin;

    _tableArr = [NSMutableArray array];
    
    [self createThreeBt];
    
    [self createTable];
    
    [self createDownView];
    
    [self netWork];
}

-(void)createNavbar
{
    
}



-(void)netWork
{
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if ([_ifMy isEqualToString:@"My"]) {
        if (userDic[@"stores_id"]) {
            [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
        }
        [dic setObject:@"1" forKey:@"type"];

    }else {
        [dic setObject:@"all" forKey:@"type"];

    }
    
    [dic setObject:_classID forKey:@"goods_class_id"];
    
    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:_urlTyleStr Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"%@ == %@", _urlTyleStr,dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                [_tableArr addObjectsFromArray:[GoodsModel objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]]];
                
            }else {
                
                
            }
        }
        
        
        [_tableView reloadData];
        
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)createThreeBt
{
    NSArray * nameArr = @[@"新品", @"热销", @"利润"];
    for (int i = 0; i < nameArr.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/nameArr.count*i, 0, Main_Screen_Width/nameArr.count, 44)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(myOnSellViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBCOLOR(234, 234, 234)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTag:(30+i)];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton = button;
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
    _sliderLable = [[UILabel alloc]initWithFrame:CGRectMake(+Main_Screen_Width/3*2, 4, 1, 36)];
    [_sliderLable setBackgroundColor:RGBCOLOR(215, 215, 215)];
    [self.view addSubview:_sliderLable];
}

-(void)myOnSellViewAction:(UIButton *)bt
{
    _currentSelectButton.selected = NO;
    
    bt.selected = YES;
    
    _currentSelectButton = bt;
    
    if ([bt.titleLabel.text isEqualToString:@"新品"]) {
        
        [bt setBackgroundColor:[UIColor whiteColor]];
        
        for (int i = 0; i< 2; i++) {
            UIButton *btt = [self.view viewWithTag:(31+i)];
            [btt setBackgroundColor:RGBCOLOR(234, 234, 234)];
        }
        _urlTyleStr = kXinpin;
        [_sliderLable setFrame:CGRectMake(Main_Screen_Width/3*2, 4, 1, 36)];

        
    }else if ([bt.titleLabel.text isEqualToString:@"热销"]){

        [bt setBackgroundColor:[UIColor whiteColor]];

        UIButton *btt = [self.view viewWithTag:30];
        [btt setBackgroundColor:RGBCOLOR(234, 234, 234)];
        UIButton *bttt = [self.view viewWithTag:32];
        [bttt setBackgroundColor:RGBCOLOR(234, 234, 234)];
        _urlTyleStr = kRexiao;
        [_sliderLable setFrame:CGRectMake(Main_Screen_Width/3*4, 4, 1, 36)];

    }else {
        [bt setBackgroundColor:[UIColor whiteColor]];
        for (int i = 0; i< 2; i++) {
            UIButton *btt = [self.view viewWithTag:(30+i)];
            [btt setBackgroundColor:RGBCOLOR(234, 234, 234)];
        }
        _urlTyleStr = kLirun;
        [_sliderLable setFrame:CGRectMake(Main_Screen_Width/3, 4, 1, 36)];

    }
    [self netWork];
    
    
}


-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, Main_Screen_Width, self.view.frame.size.height-kNavBarStatusBarHeight-44-44) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TravelAgencyListCell" bundle:nil] forCellReuseIdentifier:@"TravelAgencyListCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIndentifier = @"MyOnSellAllGoodsListCell";
    MyOnSellAllGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyOnSellAllGoodsListCell" owner:self options:nil] lastObject];
    }
    
    cell.cellIndexPath = indexPath;
    
    if ([_tableArr count]>0) {
        GoodsModel *model = _tableArr[indexPath.row];
        [cell setModel:model];
        [cell.selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.downButton addTarget:self action:@selector(downButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

-(void)selectButtonAction:(IndexPathBt *)bt
{
    bt.selected = !bt.selected;
    
    GoodsModel * goodsModel = _tableArr[bt.indexPath.row];
    
    if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
        goodsModel.ifSelect =  nil;
    }else {
        goodsModel.ifSelect = @"YES";
    }
}

-(void)downButtonAction:(IndexPathBt *)bt
{
    GoodsModel * goodsModel = _tableArr[bt.indexPath.row];
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    [dic setObject:goodsModel.goods_id forKey:@"goods_id"];
    
    [dic setObject:@"nosale" forKey:@"type"];
    
    [LCProgressHUD showLoading:@"下架中"];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
        NSLog(@"kGoodsOperate == %@",dic);
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            [LCProgressHUD showSuccess:@"下架成功"];
            [self netWork];
            
        }else {
            [LCProgressHUD showFailure:@"下架失败"];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LCProgressHUD hide];
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)createDownView
{
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, KSelf_View_Height-kNavBarStatusBarHeight-44, Main_Screen_Width, 44)];
    [downView setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [self.view addSubview:downView];
    
    ShopButton * allSelectButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(20, 20) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [allSelectButton setImage:[UIImage imageNamed:@"allSelect"] forState:UIControlStateNormal];
    [allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [allSelectButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [allSelectButton addTarget:self action:@selector(allSelectButtonAtion) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:allSelectButton];
    
    ShopButton * upButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(18, 18) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [upButton setImage:[UIImage imageNamed:@"unShelve_shen"] forState:UIControlStateNormal];
    [upButton setTitle:@"下架" forState:UIControlStateNormal];
    [upButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [upButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [upButton addTarget:self action:@selector(upButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:upButton];
    
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    [lineLable setBackgroundColor:RGBCOLOR(220, 220, 220)];
    [downView addSubview:lineLable];
}

-(void)allSelectButtonAtion
{
    
    for (GoodsModel * goodsModel in _tableArr) {
        goodsModel.ifSelect = @"YES";
    }
    [_tableView reloadData];
}

-(void)upButtonAction
{
    NSMutableArray * idArr = [NSMutableArray array];
    for (GoodsModel * goodsModel in _tableArr) {
        if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
            [idArr addObject:goodsModel.goods_id];
        }
    }
    
    if (idArr.count > 0) {
        
        //        NSLog(@"idStrArr == %@",[idArr componentsJoinedByString:@","]);
        
        NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        if (userDic[@"stores_id"]) {
            [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
        }
        
        [dic setObject:[idArr componentsJoinedByString:@","] forKey:@"goods_id"];
        
        [dic setObject:@"nosale" forKey:@"type"];
        
        [LCProgressHUD showLoading:@"下架中"];
        
        [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
            NSLog(@"kGoodsOperate == %@",dic);
            if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
                [LCProgressHUD showSuccess:@"下架成功"];
                [self netWork];
            }else {
                [LCProgressHUD showFailure:@"下架失败"];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"NSError = %@",error);
            [LCProgressHUD hide];
            
        }];
        
        
    }else {
        [LCProgressHUD showMessage:@"请至少选择一款商品"];
        
    }
    
}

@end
