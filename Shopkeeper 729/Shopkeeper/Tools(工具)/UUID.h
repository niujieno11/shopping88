//
//  UUID.h
//  YunNanBuy
//
//  Created by 张耀文 on 15/10/15.
//  Copyright © 2015年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UUID : NSObject

+ (void) standFormoDevRegister;

+ (NSString *) getFormoDevRegister;

+(NSString *) getUserDefaultsUUID;

+ (void) writeUUID;

@end
