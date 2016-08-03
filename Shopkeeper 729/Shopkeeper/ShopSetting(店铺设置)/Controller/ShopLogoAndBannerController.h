//
//  ShopLogoAndBannerController.h
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopLogoAndBannerController : BaseController<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    __weak IBOutlet UIButton *_saveButton;
   
    __weak IBOutlet UIImageView *_bannerImageView;
    
    __weak IBOutlet UIButton *_logoBtton;
    
    __weak IBOutlet UIView *_buttonBG;
    
    __weak IBOutlet UILabel *_nameLale;
    
    __weak IBOutlet UILabel *_phoneLable;
    
    __weak IBOutlet UILabel *_addressLable;
    
    NSString * _currentType;
    
    NSString * _logoUrlStr;

    NSString * _bannerUrlStr;

    UIImage * _headerImage;
}
@end
