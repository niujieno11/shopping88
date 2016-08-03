//
//  UnShelveView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/12.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "UnShelveView.h"
#import "UnShelveCell.h"

@implementation UnShelveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDota) name:@"UnShelveView" object:nil];

    
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
    
    [dic setObject:@"2" forKey:@"type"];
    
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
    [_tableView registerNib:[UINib nibWithNibName:@"UnShelveCell" bundle:nil] forCellReuseIdentifier:@"UnShelveCell"];
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
    
    static NSString * cellIndentifier = @"UnShelveCell";
    UnShelveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UnShelveCell" owner:self options:nil] lastObject];
    }
    
    cell.cellIndexPath = indexPath;
    
    if ([_tableArr count]>0) {
        GoodsModel *model = _tableArr[indexPath.row];
        [cell setModel:model];
        [cell.selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.upButton addTarget:self action:@selector(upButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton addTarget:self action:@selector(upButtonAction:) forControlEvents:UIControlEventTouchUpInside];

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

-(void)upButtonAction:(IndexPathBt *)bt
{
    GoodsModel * goodsModel = _tableArr[bt.indexPath.row];
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    [dic setObject:goodsModel.goods_id forKey:@"goods_id"];
    
    if ([bt.titleLabel.text isEqualToString:@"上架"]) {
        [dic setObject:@"sale" forKey:@"type"];
        [LCProgressHUD showLoading:@"上架中"];

    }else {
        [dic setObject:@"dele" forKey:@"type"];
        [LCProgressHUD showLoading:@"删除中"];
    }
    
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
        NSLog(@"kGoodsOperate == %@",dic);
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            if ([bt.titleLabel.text isEqualToString:@"上架"]) {
                [LCProgressHUD showSuccess:@"上架成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MyOnSellAllGoodsListView" object:nil];

            }else {
                [LCProgressHUD showSuccess:@"删除成功"];
            }
            [self netWork];
            
        }else {
            if ([bt.titleLabel.text isEqualToString:@"上架"]) {
                [LCProgressHUD showSuccess:@"上架失败"];
                
            }else {
                [LCProgressHUD showSuccess:@"删除失败"];
                
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LCProgressHUD hide];
        
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([self.delegate respondsToSelector:@selector(unShelveViewPushWith:)]) {
        GoodsModel *model = _tableArr[indexPath.row];
        
        [self.delegate unShelveViewPushWith:model.goods_id];
    }
}

-(void)createDownView
{
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, KSelf_Height-44, Main_Screen_Width, 44)];
    [downView setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [self addSubview:downView];
    
    ShopButton * allSelectButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/3/2-30, 0, 60, 44) ImageSize:CGSizeMake(20, 20) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [allSelectButton setImage:[UIImage imageNamed:@"allSelect"] forState:UIControlStateNormal];
    [allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [allSelectButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [allSelectButton addTarget:self action:@selector(allSelectButtonAtion) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:allSelectButton];
    
    ShopButton * upButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/3+Main_Screen_Width/3/2-30, 0, 60, 44) ImageSize:CGSizeMake(18, 18) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [upButton setImage:[UIImage imageNamed:@"shelve_shen"] forState:UIControlStateNormal];
    [upButton setTitle:@"上架" forState:UIControlStateNormal];
    [upButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [upButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [upButton addTarget:self action:@selector(upButtonAndDelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:upButton];
    
    ShopButton * deleteButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/3*2+Main_Screen_Width/3/2-30, 0, 60, 44) ImageSize:CGSizeMake(18, 18) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [deleteButton setImage:[UIImage imageNamed:@"delete_shen"] forState:UIControlStateNormal];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [deleteButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [deleteButton addTarget:self action:@selector(upButtonAndDelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:deleteButton];
    
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

-(void)upButtonAndDelButtonAction:(UIButton *)bt
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
        
        if ([bt.titleLabel.text isEqualToString:@"上架"]) {
            [dic setObject:@"sale" forKey:@"type"];
            [LCProgressHUD showLoading:@"上架中"];
            
        }else {
            [dic setObject:@"dele" forKey:@"type"];
            [LCProgressHUD showLoading:@"删除中"];
        }
        
        [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
            NSLog(@"kGoodsOperate == %@",dic);
            if ([[dic objectForKey:@"errcode"] integerValue] == 0) {

                if ([bt.titleLabel.text isEqualToString:@"上架"]) {
                    [LCProgressHUD showSuccess:@"上架成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyOnSellAllGoodsListView" object:nil];
                    
                }else {
                    [LCProgressHUD showSuccess:@"删除成功"];
                }
                
                [self netWork];
                
            }else {
                if ([bt.titleLabel.text isEqualToString:@"上架"]) {
                    [LCProgressHUD showSuccess:@"上架失败"];
                    
                }else {
                    [LCProgressHUD showSuccess:@"删除失败"];
                    
                }
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
