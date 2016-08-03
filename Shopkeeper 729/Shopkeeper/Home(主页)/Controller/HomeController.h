//
//  HomeController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/3.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "BaseController.h"
#import "HomeThreeDaysInfoModel.h"
#import "MyRankController.h"


@interface HomeController : BaseController
{
    //头像登陆按钮
    UIButton * _portraitButton;
    
    UIButton * _currentSelectButton;
    
    UIImageView * _imageview;
    UIImageView * _visitMostImageview;

    
    //当前排名
    UIButton * _currentAuctionBt;
    
    UILabel * _myBalanceLable;
    
    UILabel * _availableBalanceLable;
    
    HomeThreeDaysInfoModel * _threedModel;
    
    UILabel * _visitLable;
    
    UILabel * _newAddLable;

    UILabel * _addMemberLable;

    UIScrollView * _baseScrollView;
    
    NSDictionary * _visitAndOrdersDic;
}
@end
