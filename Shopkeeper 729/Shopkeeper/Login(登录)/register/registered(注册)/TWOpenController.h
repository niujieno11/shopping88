//
//  TWOpenController.h
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDataModel.h"

@interface TWOpenController : BaseController
{

    UIImageView * imageview;
    UILabel * conuntLabel;
    UILabel * textLabel;
    UIButton * nextButton;
    UIView * backView;
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
@property (nonatomic,copy)NSString * iphoneNumber;
@property (nonatomic,copy)NSString * stroye_ID;
@property (nonatomic,strong)UserDataModel * userModel;
@end
