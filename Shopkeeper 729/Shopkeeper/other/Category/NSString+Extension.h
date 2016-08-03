//
//  NSString+Extension.h
//  BuoBeiBao
//
//  Created by 张耀文 on 15/6/9.
//  Copyright (c) 2015年 张耀文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSString *)getCurrentDeviceModel:(UIViewController *)controller;

//32位加密
- (NSString *)md5;

- (NSString *)getMd5_16Bit_String:(NSString *)srcString;
+ (NSString *)deviceIPAdress;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *返回值是该字符串所占的大小(width, height)
 *font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 *maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

- (NSDictionary *)distanceTimeeWithBeforeTime:(double)beTime;

//友好时间
+(NSString *)friendlyTimeByLong:(NSTimeInterval)datetime;

//判断是否有emoji
+ (BOOL)stringContainsEmoji:(NSString *)string;

@end

@interface UILabel (StringSize)
-(CGSize)getSizeWithLimitSize:(CGSize)size String:(NSString*)string Font:(UIFont*)font lineNum:(NSInteger)num updataFrame:(BOOL)update;

@end

