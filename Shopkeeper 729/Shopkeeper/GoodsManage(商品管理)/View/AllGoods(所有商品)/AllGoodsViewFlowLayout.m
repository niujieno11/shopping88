//
//  AllGoodsViewFlowLayout.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/10.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "AllGoodsViewFlowLayout.h"

@implementation AllGoodsViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.minimumLineSpacing = 8.0f;
        
        self.minimumInteritemSpacing = 0.0f;
        //
//        self.sectionInset = UIEdgeInsetsMake(0, 6, 0, 6);
        
        
        
    }
    return self;
}
@end
