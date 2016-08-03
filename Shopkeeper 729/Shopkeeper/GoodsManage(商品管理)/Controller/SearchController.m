//
//  SearchController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/15.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "SearchController.h"

@interface SearchController ()

@end

#define navH 64

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _collectionArr = [[NSMutableArray alloc]init];

    [self createNavbar];
    
    [self createCollectionView];
    
    [self createDownView];
    
    [self netWork];
}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, navH)];
    [navView setBackgroundColor:KMainColor];
    [self.view addSubview:navView];
    
    
    UIButton * backbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [backbButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbButton addTarget:self action:@selector(backbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backbButton setBackgroundColor:[UIColor blueColor]];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(7, 17, 7, 17)];
    [navView addSubview:backbButton];
    
    
    UIButton * searchButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-60, 24, 60, 40)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:searchButton];
    
    
    UIButton * bgButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-100, 28, 200, 30)];
    [bgButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [bgButton addTarget:self action:@selector(bgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgButton setBackgroundColor:[UIColor whiteColor]];
    [bgButton setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 175)];
    [bgButton.layer setCornerRadius:4];
    [navView addSubview:bgButton];
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    [img setImage:[UIImage imageNamed:@"search1"]];
    [img setUserInteractionEnabled:YES];
    [bgButton addSubview:img];

    
    _search= [[UITextField alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-160, 0, 160, 30)];
    [_search setPlaceholder:@"请输入要找的商品"];
    [_search setTextColor:RGBCOLOR(80, 80, 80)];
    [_search setFont:[UIFont systemFontOfSize:14]];
    [_search setTextAlignment:1];
    [_search setReturnKeyType:UIReturnKeySearch];
    [_search addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [bgButton addSubview:_search];
    [_search becomeFirstResponder];

}

-(void)backbButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bgButtonAction
{
    [_search becomeFirstResponder];
}

-(void)searchAction
{
    [_search resignFirstResponder];
    
    if (_search.text.length == 0) {
        [self createAlertView:@"关键字不能为空"];
        return;
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
    
    [dic setObject:_search.text forKey:@"keyword"];
    
    [LBProgressHUD showHUDto:self.view animated:YES];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kSearch Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kSearch == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
           
                _collectionArr = [GoodsModel objectArrayWithKeyValuesArray:dic[@"data"]];

                [_collectionView reloadData];
                
            }
        }
        
        if (_collectionArr.count > 0) {
            [_downView setHidden:NO];
        }else {
            [_downView setHidden:YES];

        }
        
        
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)createCollectionView
{
    AllGoodsViewFlowLayout * layout = [[AllGoodsViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH) collectionViewLayout:layout];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"AllGoodsCell" bundle:nil] forCellWithReuseIdentifier:@"AllGoodsCell"];
    
    [_collectionView registerClass:[AllGoodsTimeReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AllGoodsTimeReusableView"];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.alwaysBounceVertical = YES;
    
    [self.view addSubview:_collectionView];
    
    //    [_collectionView addHeaderWithTarget:self action:@selector(loadNewData)];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _collectionArr.count;

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
    
    [cell displayWithMode:_collectionArr[indexPath.row]];
    
    [cell.selectBt addTarget:self action:@selector(selectBtAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

-(void)selectBtAction:(IndexPathBt *)bt
{
    bt.selected = !bt.selected;
    
    GoodsModel * goodsModel = _collectionArr[bt.indexPath.row];
    
    if ([goodsModel.ifSelect isEqualToString:@"YES"]) {
        goodsModel.ifSelect =  nil;
    }else {
        goodsModel.ifSelect = @"YES";
    }
    
}

//上架
-(void)upBtAction:(IndexPathBt *)bt
{
    
    GoodsModel * goodsModel = _collectionArr[bt.indexPath.row];
    
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


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)createDownView
{
     _downView = [[UIView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height -44, Main_Screen_Width, 44)];
    [_downView setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [_downView setHidden:YES];
    [self.view addSubview:_downView];
    
    ShopButton * allSelectButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(20, 20) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [allSelectButton setImage:[UIImage imageNamed:@"allSelect"] forState:UIControlStateNormal];
    [allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [allSelectButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [allSelectButton addTarget:self action:@selector(allSelectButtonAtion) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:allSelectButton];
    
    ShopButton * upButton = [[ShopButton alloc]initWithFrame:CGRectMake(Main_Screen_Width/2+Main_Screen_Width/2/2-30, 0, 60, 44) ImageSize:CGSizeMake(18, 18) ImageProportion:0.1 TextFontSize:10 TextProportion:0.6];
    [upButton setImage:[UIImage imageNamed:@"shelve_shen"] forState:UIControlStateNormal];
    [upButton setTitle:@"上架" forState:UIControlStateNormal];
    [upButton setTitleColor:RGBCOLOR(80, 80, 80) forState:UIControlStateNormal];
    [upButton setBackgroundColor:RGBCOLOR(245, 245, 245)];
    [upButton addTarget:self action:@selector(upButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:upButton];
    
    UILabel * lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    [lineLable setBackgroundColor:RGBCOLOR(220, 220, 220)];
    [_downView addSubview:lineLable];
}

-(void)allSelectButtonAtion
{
    
    for (GoodsModel * goodsModel in _collectionArr) {
        goodsModel.ifSelect = @"YES";
    }
    [_collectionView reloadData];
}

#pragma mark - 批量上架
-(void)upButtonAction
{
    NSMutableArray * idArr = [NSMutableArray array];
    for (GoodsModel * goodsModel in _collectionArr) {
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
