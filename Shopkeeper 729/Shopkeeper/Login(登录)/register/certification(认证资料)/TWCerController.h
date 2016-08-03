//
//  TWCerController.h
//  TWCompare
//
//  Created by TianView on 16/6/16.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWUserModel;
@interface TWCerController : BaseController
{

    UIView * headerView;
    UIView * footerView;
    UILabel * userName;
    UITextField * textName;
    UILabel * textField;
    UILabel * promptText;
    UILabel * changeColorLabel;
    UILabel * tijiaoLabel;
    UILabel * shouciLabel;
    UILabel * xinxiLabel;
    UILabel * cardID;
    UITextField * textID;
    
    NSInteger currentSelectbt;
    
    NSMutableDictionary * paraDic;
    
    
    UILabel * label;
    UIView *  navView;
    
    UIImageView * im;
    UIImageView * im1;
    UIImageView * im2;
    
    
    UILabel * zhanghao;
    UILabel * zhiliao;
    UILabel * renzheng;
    UILabel * pay;
    
    NSArray * imageArray;
}
@property (nonatomic,copy)NSString * phpone;
@property (nonatomic,copy)NSString * flagorg;

@property (nonatomic,copy)NSString * storetype_id;
@property (nonatomic,copy)NSString * storeyID_00;

@property (nonatomic,strong)UIView * viewBack;
@property (nonatomic,strong)UIScrollView * scro;
@property (nonatomic,copy)NSString * renzhen;

@end
