//
//  MyOnSellAllGoodsListView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "MyOnSellAllGoodsListView.h"
#import "MyOnSellAllGoodsListCell.h"

@implementation MyOnSellAllGoodsListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDota) name:@"MyOnSellAllGoodsListView" object:nil];
        
        _tableArr = [NSMutableArray array];
        
        [self createTable];
        
        [self createDownView];
        
        [self netWork];
        
    }
    return self;
}

-(void)reloadDota
{
    [self netWork];
}

-(void)netWork
{
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }

    [dic setObject:@"1" forKey:@"type"];

    [LBProgressHUD showHUDto:self animated:YES];

    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kMyGoods Parameters:dic style:kConnectPostType success:^(id dic) {
        
//        NSLog(@"kMyGoods == %@",dic);
        
        [_tableArr removeAllObjects];
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                [_tableArr removeAllObjects];
                [_tableArr addObjectsFromArray:[GoodsModel objectArrayWithKeyValuesArray:[dic objectForKey:@"data"]]];
                
                
            }else {
                
                
            }
        }
        
        if (_tableArr.count == 0) {
            _tableView.hidden = YES;
        }else {
            _tableView.hidden = NO;
        }
        [_tableView reloadData];
        
        
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
    }];
    
    
    
}

-(void)createTable
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.frame.size.height-44) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TravelAgencyListCell" bundle:nil] forCellReuseIdentifier:@"TravelAgencyListCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_tableView];
    
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
    GoodsModel * goodsModel = _tableArr[bt.indexPath.row];
    
    if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
        goodsModel.ifSelect =  nil;
    }else {
        goodsModel.ifSelect = @"YES";
    }
    [_tableView reloadData];
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
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UnShelveView" object:nil];

        }else {
            [LCProgressHUD showFailure:@"下架失败"];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LCProgressHUD hide];
        
    }];

}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.delegate respondsToSelector:@selector(myOnSellAllGoodsListViewPushWith:)]) {
        GoodsModel *model = _tableArr[indexPath.row];

        [self.delegate myOnSellAllGoodsListViewPushWith:model.goods_id];
    }


}

-(void)createDownView
{
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, KSelf_Height-44, Main_Screen_Width, 44)];
    [downView setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [self addSubview:downView];
    
    ShopButton * allSelectButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(20, 20) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [allSelectButton setImage:[UIImage imageNamed:@"allSelect"] forState:UIControlStateNormal];
    [allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [allSelectButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [allSelectButton addTarget:self action:@selector(allSelectButtonAtion) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:allSelectButton];
    
    ShopButton * downButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(18, 18) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [downButton setImage:[UIImage imageNamed:@"unShelve_shen"] forState:UIControlStateNormal];
    [downButton setTitle:@"下架" forState:UIControlStateNormal];
    [downButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [downButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [downButton addTarget:self action:@selector(downButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:downButton];
    
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

-(void)downButtonAction
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
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UnShelveView" object:nil];
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
