//
//  TWSubmitController.h
//  TWCompare
//
//  Created by TianView on 16/6/17.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataModel.h"

@interface TWSubmitController : BaseController
{
    
    UIImageView * imageview;
    UILabel * conuntLabel;
    UILabel * textLabel;
    UIButton * nextButton;
    UIView * backView;
    UILabel * lblshen;
    
    
    UIView * backview; //放二维码视图
    UIButton * button;
    UIView * buttnView;
    
    UIButton *  codeBut;//访问二维码
    UILabel * codeLabel;
    
    UIButton * DistriBut; // 访问分销二维码
    UILabel * DistrLabel;
    
    
    NSURL * url;
    NSURL * fenxiaoUrl;
    
}
@property (nonatomic,strong)UIView * viewBack;
@property (nonatomic,copy)NSString * userIphone;
@property (nonatomic,copy)NSString * storye_ID_1;
@property (nonatomic,strong)UserDataModel * userModel;
@end
