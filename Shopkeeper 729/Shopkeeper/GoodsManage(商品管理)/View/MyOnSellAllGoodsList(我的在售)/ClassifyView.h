//
//  ClassifyView.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/11.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsClassifyModel.h"

@protocol ClassifyViewDelegate <NSObject>

-(void)classifyViewPushToListWithClassID:(NSString *)classID ClassName:(NSString *)className ifMy:(NSString *)IfMy;

@end

@interface ClassifyView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

{
    NSMutableArray * _collectionArr;
    UICollectionView * _collectionView;
    
    NSString * _ifMy;
    
    //状态数组
    NSMutableArray * _stateArray;
}

@property (nonatomic, assign) id<ClassifyViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame ifMy:(NSString *)IfMy;

 @end
