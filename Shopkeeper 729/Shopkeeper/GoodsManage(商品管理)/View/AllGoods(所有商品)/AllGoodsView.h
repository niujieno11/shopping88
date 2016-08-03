//
//  AllGoodsView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllGoodsCell.h"
#import "NewGoodsTimeListModel.h"
#import "GoodsModel.h"
#import "AllGoodsTimeReusableView.h"
#import "IndexPathBt.h"
#import "ShopButton.h"

@protocol AllGoodsViewDelegate <NSObject>

-(void)allGoodsViewPushWith:(NSString *)goodsID;

@end

@interface AllGoodsView : UIView<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UICollectionView * _collectionView;
    NSMutableArray *_collectionArr;
}

@property(nonatomic, assign) id<AllGoodsViewDelegate>delegate;

@end
