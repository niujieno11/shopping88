//
//  UUID.m
//  YunNanBuy
//
//  Created by 张耀文 on 15/10/15.
//  Copyright © 2015年 张耀文. All rights reserved.
//

#import "UUID.h"

@implementation UUID

+ (NSString *) getUserDefaultsUUID
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * uuidStr = [defaults objectForKey:@"uuid_str"];
    
    return uuidStr == nil ? nil : uuidStr;
}

+ (void) writeUUID
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString * strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));

    [defaults setObject:strUUID forKey:@"uuid_str"];
    
    [defaults synchronize];
    
}

+ (void) standFormoDevRegister
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"1" forKey:@"devRegister"];
    
    [defaults synchronize];
    
}

+ (NSString *) getFormoDevRegister
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * standStr = [defaults objectForKey:@"devRegister"];
    
    return standStr;
}



@end
