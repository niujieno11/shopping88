//
//  AddBankCardController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/27.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankCardController : BaseController
{
    UITextField * _nameTextField;
    
    UITextField * _shenFengTextField;

    UITextField * _bankNameTextField;

    UITextField * _bankNumTextField;
    
    __weak IBOutlet UIButton *saveBtutton;
    

}
@end
