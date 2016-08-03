//
//  GoodsManageController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllGoodsView.h"
#import "ClassifyView.h"
#import "MyOnSellAllGoodsListView.h"
#import "ClassifyListController.h"
#import "UnShelveView.h"

@interface GoodsManageController : BaseController<ClassifyViewDelegate, AllGoodsViewDelegate, UnShelveViewDelegate, MyOnSellAllGoodsListViewDelegate>
{
    
    UIButton * _currentSelectButton;
    UIButton * _currentAllGoodsSelectButton;
    
     //1.我的在售视图
    UIView * _myOnSellView;
    //1.1我的在售视图-全部在售
    MyOnSellAllGoodsListView * _myOnSellAllGoodsListView;
    //1.2我的在售视图-我的所有分类
    ClassifyView * _myCassifyView;
    
   //2.所有商品视图
    UIView * _allGoodsView;
    //2.1 所有商品视图-新款上架
    AllGoodsView * _allGoodsViewNew;
    //2.2我的在售视图-全部分类
    ClassifyView * _cassifyView;
    
    //3.下架商品
    UnShelveView * _unShelveView;
    
    
}
@end
