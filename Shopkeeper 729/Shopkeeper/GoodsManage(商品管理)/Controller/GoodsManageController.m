//
//  GoodsManageController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "GoodsManageController.h"
#import "SearchController.h"
#import "GoodDetailsController.h"

@interface GoodsManageController ()

@end

#define navH 120

@implementation GoodsManageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self createNavbar];
    
    //三个视图
    [self createThreeView];
}

-(void)createNavbar
{
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, navH)];
    [navView setBackgroundColor:KMainColor];
    [self.view addSubview:navView];
    
    //2.返回按钮
    UIButton * backbButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 24, 60, 40)];
    [backbButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbButton addTarget:self action:@selector(backbButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backbButton setBackgroundColor:[UIColor blueColor]];
    [backbButton setImageEdgeInsets:UIEdgeInsetsMake(7, 17, 7, 17)];
    [self.view addSubview:backbButton];
    
    UIButton * searchButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-60, 24, 60, 40)];
    [searchButton setImage:[UIImage imageNamed:@"search2"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //    [backbButton setBackgroundColor:[UIColor blueColor]];
    [searchButton setImageEdgeInsets:UIEdgeInsetsMake(8, 18, 8, 18)];
    [self.view addSubview:searchButton];
    
    
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-50, 35, 100, 20)];
    [titleLable setText:@"商品管理"];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setFont:[UIFont systemFontOfSize:15]];
    [titleLable setTextAlignment:1];
    [navView addSubview:titleLable];
    
    UISegmentedControl *topSegment = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@" 我的在售 ",@" 所有商品 ", @" 下架商品 ", nil]];
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

-(void)searchButtonAction
{
    SearchController * s = [[SearchController alloc]init];
    [self.navigationController pushViewController:s animated:YES];
}

-(void)topSegmentAction:(UISegmentedControl *)topSegment
{
    if (topSegment.selectedSegmentIndex == 0) {

        [_myOnSellView setHidden:NO];
        [_allGoodsView setHidden:YES];
        [_unShelveView setHidden:YES];

    }else  if (topSegment.selectedSegmentIndex == 1) {
        
        [_myOnSellView setHidden:YES];
        [_allGoodsView setHidden:NO];
        [_unShelveView setHidden:YES];

    }else {
        [_myOnSellView setHidden:YES];
        [_allGoodsView setHidden:YES];
        [_unShelveView setHidden:NO];

    }
}

-(void)createThreeView
{
    //1.我的在售视图
    _myOnSellView = [[UIView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH)];
    [self.view addSubview:_myOnSellView];
    
    NSArray * nameArr = @[@"全部在售", @"查看分类"];
    for (int i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/2*i, 0, Main_Screen_Width/2, 38)];
        [button setTitle:nameArr[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(myOnSellViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBCOLOR(234, 234, 234)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_myOnSellView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentSelectButton = button;
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
    //1.1我的在售视图-全部在售
    _myOnSellAllGoodsListView = [[MyOnSellAllGoodsListView alloc]initWithFrame:CGRectMake(0, 38, Main_Screen_Width, Main_Screen_Height-navH-38)];
    [_myOnSellAllGoodsListView setDelegate:self];
    [_myOnSellView addSubview:_myOnSellAllGoodsListView];
    
    //1.2我的在售视图-全部在售
    _myCassifyView = [[ClassifyView alloc]initWithFrame:CGRectMake(0, 38, Main_Screen_Width, Main_Screen_Height-navH-38) ifMy:@"My"];
    [_myCassifyView setHidden:YES];
    [_myCassifyView setDelegate:self];
    [_myOnSellView addSubview:_myCassifyView];
    
    
    //2.所有商品视图
    _allGoodsView = [[UIView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH)];
    [_allGoodsView setHidden:YES];
    [self.view addSubview:_allGoodsView];
    
    
    NSArray * nameArr2 = @[@"新款上架", @"查看分类"];

    for (int i = 0; i < 2; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0+Main_Screen_Width/2*i, 0, Main_Screen_Width/2, 38)];
        [button setTitle:nameArr2[i] forState:UIControlStateNormal];
        [button setTitleColor:KMainColor forState:UIControlStateSelected];
        [button setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(allGoodsViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:RGBCOLOR(234, 234, 234)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_allGoodsView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            _currentAllGoodsSelectButton = button;
            [button setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
    //2.1 所有商品视图-新款上架
    _allGoodsViewNew = [[AllGoodsView alloc]initWithFrame:CGRectMake(0, 38, Main_Screen_Width, Main_Screen_Height-navH-38)];
    _allGoodsViewNew.delegate = self;
    [_allGoodsView addSubview:_allGoodsViewNew];
    //2.2我的在售视图-全部在售
    _cassifyView = [[ClassifyView alloc]initWithFrame:CGRectMake(0, 38, Main_Screen_Width, Main_Screen_Height-navH-38) ifMy:nil];
    [_cassifyView setHidden:YES];
    [_cassifyView setDelegate:self];
    [_allGoodsView addSubview:_cassifyView];
    
    //3.下架商品
    _unShelveView = [[UnShelveView alloc]initWithFrame:CGRectMake(0, navH, Main_Screen_Width, Main_Screen_Height-navH)];
    [_unShelveView setHidden:YES];
     [_unShelveView setDelegate:self];
    [self.view addSubview:_unShelveView];

}

-(void)myOnSellViewAction:(UIButton *)bt
{
    _currentSelectButton.selected = NO;
    [_currentSelectButton setBackgroundColor:RGBCOLOR(234, 234, 234)];

    bt.selected = YES;
    [bt setBackgroundColor:[UIColor whiteColor]];

    _currentSelectButton = bt;
    
    if ([bt.titleLabel.text isEqualToString:@"全部在售"]) {
        [_myOnSellAllGoodsListView setHidden:NO];
        [_myCassifyView setHidden:YES];
    }else {
        [_myOnSellAllGoodsListView setHidden:YES];
        [_myCassifyView setHidden:NO];
    }
    
    
    
}
-(void)allGoodsViewAction:(UIButton *)bt
{
    _currentAllGoodsSelectButton.selected = NO;
    [_currentAllGoodsSelectButton setBackgroundColor:RGBCOLOR(234, 234, 234)];

    bt.selected = YES;
    [bt setBackgroundColor:[UIColor whiteColor]];
    
    _currentAllGoodsSelectButton = bt;
    
    if ([bt.titleLabel.text isEqualToString:@"新款上架"]) {
        [_allGoodsViewNew setHidden:NO];
        [_cassifyView setHidden:YES];
    }else {
        [_allGoodsViewNew setHidden:YES];
        [_cassifyView setHidden:NO];
    }
}

#pragma mark - 代理协议
-(void)classifyViewPushToListWithClassID:(NSString *)classID ClassName:(NSString *)className ifMy:(NSString *)IfMy
{
    ClassifyListController * list = [[ClassifyListController alloc]init];
    list.classID = classID;
    list.className = className;
    list.ifMy = IfMy;

    [self.navigationController pushViewController:list animated:YES];
}

-(void)allGoodsViewPushWith:(NSString *)goodsID
{
    [self pushToGoodsDetailWith:goodsID];
}

-(void)myOnSellAllGoodsListViewPushWith:(NSString *)goods_id
{
    [self pushToGoodsDetailWith:goods_id];
}

-(void)unShelveViewPushWith:(NSString *)goods_id
{
    [self pushToGoodsDetailWith:goods_id];
}


-(void)pushToGoodsDetailWith:(NSString *)goodsID
{
    GoodDetailsController * g = [[GoodDetailsController alloc]init];
    g.ID = goodsID;
    [self.navigationController pushViewController:g animated:YES];

}
@end
