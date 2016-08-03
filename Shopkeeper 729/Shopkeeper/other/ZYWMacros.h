//
//  ZYWMacros.h
//  学聚
//
//  Created by 天问科技 on 14-12-5.
//  Copyright (c) 2014年 Zhangwenybx. All rights reserved.
//

#ifndef ___ZYWMacros_h
#define ___ZYWMacros_h

 

//QQ
#define KQQApp_id @"1104936077"

//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/* ****************************************************************************************************************** */
#pragma mark - Frame (宏 x, y, width, height)

// App Frame
#define mainScreenBounds [[UIScreen mainScreen] bounds]

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// SelfView Height&Width
#define KSelf_Width           self.frame.size.width
#define KSelf_Height          self.frame.size.height

// SelfView Height&Width
#define KSelf_View_Width           self.view.frame.size.width
#define KSelf_View_Height          self.view.frame.size.height
#define KCell_Half_Height          self.contentView.frame.size.height/2

// SelfCell Height&Width
#define KSelf_Cell_Width           self.contentView.frame.size.width
#define KSelf_Cell_Height          self.contentView.frame.size.height

// 系统控件默认高度
#define kStatusBarHeight        (20.f)
#define kNavBarHeight           (44.f)
#define kTabBarHeight        (49.f)

#define kNavBarStatusBarHeight   (64.f)
#define kNavBar_StatusBarHeight_TabBarHeight  (113.f)




#define kCellDefaultHeight      (44.f)



/* ****************************************************************************************************************** */
#pragma mark - Funtion Method (宏 方法)

// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 全局颜色
#define KGlobalCOLOR_A            [UIColor colorWithRed:35/255.0f green:35/255.0f blue:35/255.0f alpha:1]
#define KGlobalCOLOR_B            [UIColor colorWithRed:90/255.0f green:90/255.0f blue:90/255.0f alpha:1]
#define KGlobalCOLOR_C            [UIColor colorWithRed:119/255.0f green:119/255.0f blue:119/255.0f alpha:1]
#define KGlobalCOLOR_D            [UIColor colorWithRed:149/255.0f green:149/255.0f blue:149/255.0f alpha:1]
#define KGlobalCOLOR_E            [UIColor colorWithRed:168/255.0f green:168/255.0f blue:168/255.0f alpha:1]
#define KGlobal_SPE_LINE_COLOR    [UIColor colorWithRed:228/255.0f green:228/255.0f blue:228/255.0f alpha:1]
#define KGlobal_SPE_Tiao_COLOR    [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1]
#define KGlobal_SPE_TiaoBian_COLOR    [UIColor colorWithRed:222/255.0f green:222/255.0f blue:222/255.0f alpha:1]

// 主题色
#define KMainColor            [UIColor colorWithRed:227/255.0f green:0/255.0f blue:127/255.0f alpha:1]
// 背景灰
#define KGlobalBackgroundGray            [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:0.8]
// 底页文字灰
#define KDetailTextGray            [UIColor colorWithRed:139/255.0 green:139/255.0 blue:139/255.0 alpha:0.8]
// 全局红
#define KGlobalRed            [UIColor colorWithRed:224/255.0 green:80/255.0 blue:40/255.0 alpha:1]



// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])


// 是否Retina屏
#define isRetina                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

#define is_iPhone4  ( ([[UIScreen mainScreen] currentMode].size.height) / ([[UIScreen mainScreen] currentMode].size.width) == 1.5)|| ( ([[UIScreen mainScreen] currentMode].size.height) / ([[UIScreen mainScreen] currentMode].size.width) <= 1.34) ?YES:NO

// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 当前系统版本
#define CurrentSystemVersion        ([[[UIDevice currentDevice] systemVersion] floatValue])

#define StatusbarSize ((CurrentSystemVersion >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

//** textAlignment ***********************************************************************************

#if !defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
# define LINE_BREAK_WORD_WRAP UILineBreakModeWordWrap
# define TextAlignmentLeft UITextAlignmentLeft
# define TextAlignmentCenter UITextAlignmentCenter
# define TextAlignmentRight UITextAlignmentRight

#else
# define LINE_BREAK_WORD_WRAP NSLineBreakByWordWrapping
# define TextAlignmentLeft NSTextAlignmentLeft
# define TextAlignmentCenter NSTextAlignmentCenter
# define TextAlignmentRight NSTextAlignmentRight

#endif


#endif
