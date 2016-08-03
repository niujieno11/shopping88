//
//  TWCerModels.h
//  TWCompare
//   认证资料模型
//  Created by TianView on 16/7/4.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// tableview,imagePositive,button1,button2,button3,userNamed,imageOpposite,imageCard;

@interface TWCerModels : NSObject
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * cardID;
@property (nonatomic,strong)UIImage * imagePositive; //身份证正面
@property (nonatomic,strong)UIImage * imageOpposite; //身份证反面
@property (nonatomic,strong)UIImage * imageCard; //手持身份证


@end
