//
//  SearchController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/7/15.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllGoodsCell.h"
#import "NewGoodsTimeListModel.h"
#import "GoodsModel.h"
#import "AllGoodsTimeReusableView.h"
#import "IndexPathBt.h"
#import "ShopButton.h"
#import "AllGoodsViewFlowLayout.h"

@interface SearchController : BaseController<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UICollectionView * _collectionView;
    NSMutableArray *_collectionArr;
    UITextField * _search;

    UIView * _downView;
}


@end
