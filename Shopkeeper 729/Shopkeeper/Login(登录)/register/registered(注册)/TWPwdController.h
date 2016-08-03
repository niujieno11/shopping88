//
//  TWPwdController.h
//  TWCompare
//
//  Created by TianView on 16/6/15.
//  Copyright © 2016年 TianView. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWPwdController : UIViewController
{

    UITextField * pwdField1;
    UITextField * pwdField2;
    UIButton * determineButton; //确定

}
@property (nonatomic,copy)NSString * phoneNumber;
@property (nonatomic,copy)NSString * codeID;
@property (nonatomic,copy)NSString * story_id_3;

@end
