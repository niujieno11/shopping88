//
//  TWInformationController.h
//  TWCompare
//
//  Created by TianView on 16/6/21.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataModel.h"
@interface TWInformationController : BaseController

{
    
    NSMutableDictionary * pramDic;
    NSString *fullPath;
    
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
@property (nonatomic,strong)UILabel * storeName;
@property (nonatomic,strong)UILabel * stroeIndifer;
@property (nonatomic,strong)UILabel * storeSign;
@property (nonatomic,strong)UILabel * storeCode;

@property (nonatomic,strong)UITextField * storeTextField;//店铺名称
@property (nonatomic,strong)UIButton * indfierButton;//店铺标识
@property (nonatomic,strong)UIButton * signButton;//店铺招牌
@property (nonatomic,strong)UIButton * codeButton; //微信二维码
@property (nonatomic,strong)UIButton * confirmButton; //确认
@property (nonatomic,assign)NSInteger currentBtn;

@property (nonatomic,strong)UIImage * image;//店铺标识图片
@property (nonatomic,strong)UIImage * image1;//店铺招牌图片
@property (nonatomic,strong)UIImage * image2;//微信二维码图片

//选择系统相册用字符串保存
@property (nonatomic,copy)NSString * imageLogo;
@property (nonatomic,copy)NSString * imageBanner;
@property (nonatomic,copy)NSString * imageWeixin_code;

@property (nonatomic,copy)NSString * phoneNumber;
@property (nonatomic,copy)NSString * flag;

@property (nonatomic,strong)UserDataModel * model;

@property (nonatomic,copy)NSString * storetype;
@property (nonatomic,copy)NSString * storyID_;

@property (nonatomic,strong)UIView * viewBack;
@property (nonatomic,strong)UIScrollView * scro;


@end
