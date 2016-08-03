//
//  AllGoodsView.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AllGoodsView.h"
#import "AllGoodsViewFlowLayout.h"

@implementation AllGoodsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _collectionArr = [[NSMutableArray alloc]init];
        
        [self createCollectionView];
        
        [self createDownView];
        
        [self netWork];
        
    }
    return self;
}



-(void)netWork
{
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
        
    [dic setObject:@"all" forKey:@"type"];
    
    [LBProgressHUD showHUDto:self animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kMyGoods Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kAllGoods == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in dic[@"data"]) {
                    NewGoodsTimeListModel * model = [[NewGoodsTimeListModel alloc]init];
                    [model toModelWithDict:dict];
                    [_collectionArr addObject:model];
                }
                [_collectionView reloadData];
                
            }else {
                
            }
        }
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self animated:YES];
    }];
}

-(void)createCollectionView
{
    AllGoodsViewFlowLayout * layout = [[AllGoodsViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-120-38-44) collectionViewLayout:layout];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"AllGoodsCell" bundle:nil] forCellWithReuseIdentifier:@"AllGoodsCell"];

    [_collectionView registerClass:[AllGoodsTimeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AllGoodsTimeReusableView"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.alwaysBounceVertical = YES;
    
    [self addSubview:_collectionView];
    
//    [_collectionView addHeaderWithTarget:self action:@selector(loadNewData)];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _collectionArr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    NewGoodsTimeListModel *model = _collectionArr[section];
    return model.goodsModelArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//   return CGSizeMake(Main_Screen_Width/2-10, 200.f * [AutoSizeScale autoSizeScaleY]);
    return CGSizeMake(Main_Screen_Width/2-0.00001, 280.f  );

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AllGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AllGoodsCell" forIndexPath:indexPath];
    cell.cellIndexPath = indexPath;
    
//    [cell setBackgroundColor:[UIColor yellowColor]];
    
    NewGoodsTimeListModel *model = _collectionArr[indexPath.section];

    [cell displayWithMode:model.goodsModelArr[indexPath.row]];
    
    [cell.selectBt addTarget:self action:@selector(selectBtAction:) forControlEvents:UIControlEventTouchUpInside];
   
    

    return cell;
}

-(void)selectBtAction:(IndexPathBt *)bt
{
    bt.selected = !bt.selected;
    
    NewGoodsTimeListModel *model = _collectionArr[bt.indexPath.section];
    
    GoodsModel * goodsModel = model.goodsModelArr[bt.indexPath.row];
    
    if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
        goodsModel.ifSelect =  nil;
    }else {
        goodsModel.ifSelect = @"YES";
    }

}

//上架
-(void)upBtAction:(IndexPathBt *)bt
{
    NewGoodsTimeListModel *model = _collectionArr[bt.indexPath.section];
    
    GoodsModel * goodsModel = model.goodsModelArr[bt.indexPath.row];
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    [dic setObject:goodsModel.goods_id forKey:@"goods_id"];
    
    [dic setObject:@"sale" forKey:@"type"];
    
    [LCProgressHUD showLoading:@"上架中"];

    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
        NSLog(@"kGoodsOperate == %@",dic);
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            [LCProgressHUD showSuccess:@"上架成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MyOnSellAllGoodsListView" object:nil];

        }else {
            [LCProgressHUD showFailure:@"上架失败"];

        }
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LCProgressHUD hide];

    }];

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return  CGSizeMake( Main_Screen_Width, 44);
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        AllGoodsTimeReusableView *allGoodsTimeReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AllGoodsTimeReusableView" forIndexPath:indexPath];
        [allGoodsTimeReusableView setModel:_collectionArr[indexPath.section]];
        reusableview = allGoodsTimeReusableView;

    }
    
    return reusableview;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewGoodsTimeListModel *model = _collectionArr[indexPath.section];
    
    GoodsModel * goods = model.goodsModelArr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(allGoodsViewPushWith:)]) {
        [self.delegate allGoodsViewPushWith:goods.goods_id];
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
    
    ShopButton * upButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(18, 18) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [upButton setImage:[UIImage imageNamed:@"shelve_shen"] forState:UIControlStateNormal];
    [upButton setTitle:@"上架" forState:UIControlStateNormal];
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
    
    for (NewGoodsTimeListModel *model in _collectionArr) {
        for (GoodsModel * goodsModel in model.goodsModelArr) {
            goodsModel.ifSelect = @"YES";
        }
    }
    [_collectionView reloadData];
}

#pragma mark - 批量上架
-(void)upButtonAction
{
    NSMutableArray * idArr = [NSMutableArray array];
    for (NewGoodsTimeListModel *model in _collectionArr) {
        for (GoodsModel * goodsModel in model.goodsModelArr) {
            if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
                [idArr addObject:goodsModel.goods_id];
            }
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
        
        [dic setObject:@"sale" forKey:@"type"];
        
        [LCProgressHUD showLoading:@"上架中"];
        
        [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kGoodsOperate Parameters:dic style:kConnectPostType success:^(id dic) {
            NSLog(@"kGoodsOperate == %@",dic);
            if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
                [LCProgressHUD showSuccess:@"上架成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"MyOnSellAllGoodsListView" object:nil];

            }else {
                [LCProgressHUD showFailure:@"上架失败"];
                
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
