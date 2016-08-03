//
//  AutoSizeScale.m
//  HonGuMircoShop
//
//  Created by 张耀文 on 15/9/18.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import "AutoSizeScale.h"

@implementation AutoSizeScale


+(CGFloat)autoSizeScaleX
{
    if(Main_Screen_Height > 480){
        
        return Main_Screen_Width/320;
        
    }else{
        
        return 1.0;
    }
 
}

+(CGFloat)autoSizeScaleY
{
    if(Main_Screen_Height > 480){
        
        return Main_Screen_Height/568;
        
    }else{
        
        return 1.0;
        
    }
    
}

@end
