//
//  TWServiceController.h
//  TWCompare
//
//  Created by TianView on 16/6/27.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWServiceController : UIViewController
{
    UIView * headerView;
    
    UIView * footerView;
    
    UIButton * weixinBut;//微信支付button
    
    
    UIButton * alipayBut;//支付宝button
    
    
    UILabel * zhanghao;
    UILabel * zhiliao;
    UILabel * renzheng;
    UILabel * pay;
    
    UIView *  navView;
    UIImageView * im;
    UIImageView * im1;
    UIImageView * im2;
}
@property (nonatomic,copy)NSString * useriphone;
@property (nonatomic,copy)NSString * storetype;
@property (nonatomic,copy)NSString * storyIDL;
@end
