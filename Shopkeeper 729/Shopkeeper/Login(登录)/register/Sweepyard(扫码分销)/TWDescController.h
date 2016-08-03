//
//  TWDescController.h
//  TWCompare
//
//  Created by TianView on 16/6/28.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWUserModel;
@interface TWDescController : BaseController

@property (nonatomic,strong)TWUserModel * model;

@property (nonatomic, copy) NSString *myUrl;
@property (nonatomic,copy) NSString * story_id;
@property (nonatomic, copy) NSString * rid;
@property (nonatomic,copy)NSString * storetype;

@end
