//
//  ShopLogoAndBannerController.m
//  Shopkeeper
//
//  Created by 张耀文 on 16/5/25.
//  Copyright © 2016年 张耀文. All rights reserved.
//

#import "ShopLogoAndBannerController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"


@interface ShopLogoAndBannerController ()


@end

@implementation ShopLogoAndBannerController

-(void)createNavbar
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _currentType = nil;
    
    self.title = @"店铺招牌设置";
    
    [_saveButton.layer setCornerRadius:5];
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSString * str = userDic[@"banner"];
    str = [str stringByReplacingOccurrencesOfString:kEnvironmentImage withString:@""];
    [_bannerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , str]] placeholderImage:nil options:SDWebImageRetryFailed];

    NSString * str2 = userDic[@"logo"];
    str2 = [str stringByReplacingOccurrencesOfString:kEnvironmentImage withString:@""];
    [_logoBtton sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kEnvironmentImage , str2]] forState:UIControlStateNormal placeholderImage:nil];
    [_logoBtton.layer setCornerRadius:33];
    [_logoBtton setClipsToBounds:YES];
    
    [_buttonBG.layer setCornerRadius:35];
    
    [_bannerImageView setUserInteractionEnabled:YES];
    [_bannerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logoButtonAction:)]];
    
    [_nameLale setText:userDic[@"stores_name"]];
    
    [_phoneLable setText:[NSString stringWithFormat:@"电话：%@",userDic[@"mobile"]]];
    [_addressLable setText:[NSString stringWithFormat:@"地址：%@",userDic[@"address"]]];

}

- (IBAction)logoButtonAction:(id)sender {
    
    if ([sender isKindOfClass:[UIButton class]]) {
         _currentType = @"logo";
    }else {
         _currentType = @"banner";
    }
   
    
    UIActionSheet *pickImageActionSheet =[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选取", nil];
    [pickImageActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [imagePicker setAllowsEditing:YES];//设置允许编辑
    if (buttonIndex == 0) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if(buttonIndex == 1){
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
#pragma mark - UIImagePicker 代理方法照片选择完成执行的代理方法，照片信息保存在info中
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //返回的图片
    //    NSLog(@"info == %@",info);
    
    _headerImage = info[@"UIImagePickerControllerEditedImage"];
    
    //    NSLog(@"_headerImage == %@",_headerImage);
    
    

    
    
    NSData *imageData = UIImageJPEGRepresentation(_headerImage, 0.3);
    
    [self uploadVoiceWithData:imageData];
    
    // 关闭选择照片控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#define mark 上传
- (void)uploadVoiceWithData:(NSData *)data{
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.labelText = @"上传中...";
    
//    NSLog(@"base64EncodedString == %@",dic);
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"file"];
    
    
    [LCProgressHUD showLoading:@"上传中"];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kUploadPic Parameters:dic style:kConnectPostType success:^(id dic) {
        NSLog(@"kUploadPicdic = %@ ========",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            
            if (dic[@"data"]) {
                
                NSString * str = dic[@"data"];
                str = [str stringByReplacingOccurrencesOfString:kEnvironmentImage withString:@""];
                
                if ([_currentType isEqualToString:@"logo"]) {
                    
                    _logoUrlStr = str;
                }else {
                    _bannerUrlStr = str;
                }
                [self createAlertView:@"上传成功"];
            }
            
            if ([_currentType isEqualToString:@"logo"]) {
                
                [_logoBtton setBackgroundImage:_headerImage forState:UIControlStateNormal];
                
            }else {
                [_bannerImageView setImage:_headerImage];
            }
            
        }else {
            [self createAlertView:@"上传失败"];
        }

        
        
        
        [LCProgressHUD hide];
        
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
        [LCProgressHUD hide];
    }];

}

- (IBAction)saveButtonAction:(id)sender {
    
    NSDictionary * userDic = [UserInfo shareUserInfoSingleton].userInfoDic;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (userDic[@"stores_id"]) {
        [dic setObject:userDic[@"stores_id"] forKey:@"store_id"];
    }
    
    if (_logoUrlStr.length > 0) {
        
        [dic setObject:_logoUrlStr forKey:@"logo"];
    }else {
        [dic setObject:userDic[@"logo"] forKey:@"logo"];

    }
    if (_bannerUrlStr.length > 0) {
        
        [dic setObject:_bannerUrlStr forKey:@"banner"];
    }else {
        
        [dic setObject:userDic[@"banner"] forKey:@"banner"];

    }
    
    [LCProgressHUD showLoading:@"保存中..."];
    
    [NetWorkRequest netWorkRequestWithEnvironmentStr:kEnvironmentStr1 BaseURLStr:kSaveBannerLogoUpdate Parameters:dic style:kConnectPostType success:^(id dic) {
        
        NSLog(@"kSaveBannerLogoUpdate == %@",dic);
        
        if ([[dic objectForKey:@"errcode"] integerValue] == 0) {
            [self createAlertView:@"保存成功"];
            
            NSMutableDictionary *newUserDic = [userDic mutableCopy];
            
            if (_logoUrlStr.length > 0) {
                
                [newUserDic setObject:_logoUrlStr forKey:@"logo"];
            }
            if (_bannerUrlStr.length > 0) {
                
                [newUserDic setObject:_bannerUrlStr forKey:@"banner"];
            }
            
            [UserInfo shareUserInfoSingleton].userInfoDic = newUserDic;

        }

        
        [LCProgressHUD hide];
    } failure:^(NSError *error) {
        NSLog(@"NSError = %@",error);
       [LCProgressHUD hide];
        
    }];

    
}

@end
