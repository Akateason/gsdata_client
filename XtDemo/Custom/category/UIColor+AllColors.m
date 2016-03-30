//
//  UIColor+AllColors.m
//  XtDemo
//
//  Created by teason on 16/3/21.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "UIColor+AllColors.h"
#import "XTJson.h"

@implementation UIColor (AllColors)

#pragma mark -- Private --

+ (UIColor *)getColorWithRed:(float)fRed
                       green:(float)fGreen
                        Blue:(float)fBlue
{
    return [self getColorWithRed:fRed
                           green:fGreen
                            Blue:fBlue
                           alpha:1.0] ;
}

+ (UIColor *)getColorWithRed:(float)fRed
                       green:(float)fGreen
                        Blue:(float)fBlue
                       alpha:(float)alpha
{
    return [UIColor colorWithRed:((float) fRed / 255.0f)
                           green:((float) fGreen / 255.0f)
                            blue:((float) fBlue / 255.0f)
                           alpha:alpha] ;
}

+ (NSDictionary *)getPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"xtAllColorsList" ofType:@"plist"] ;
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] ;
    return data ;
}

+ (UIColor *)xt_colorWithKey:(NSString *)key
{
    NSString *jsonStr = [[self getPlist] objectForKey:key] ;
    NSArray *colorValList = [XTJson getJsonObj:jsonStr] ;
    if (colorValList.count == 3) {
        return [self getColorWithRed:[colorValList[0] floatValue]
                               green:[colorValList[1] floatValue]
                                Blue:[colorValList[2] floatValue]] ;
    } else if (colorValList.count == 4) {
        return [self getColorWithRed:[colorValList[0] floatValue]
                               green:[colorValList[1] floatValue]
                                Blue:[colorValList[2] floatValue]
                               alpha:[colorValList[3] floatValue]] ;
    }
    return nil ;
}

#pragma mark -- PUBLIC --
+ (UIColor *)xt_mainColor
{
    return [self xt_colorWithKey:@"main"] ;
}

+ (UIColor *)xt_blackColor
{
    return [self xt_colorWithKey:@"black"] ;
}

+ (UIColor *)xt_redColor
{
    return [self xt_colorWithKey:@"red"] ;
}

+ (UIColor *)xt_halfMainColor
{
    return [self xt_colorWithKey:@"main_half"] ;
}

+ (UIColor *)xt_mainBlueColor
{
    return [self xt_colorWithKey:@"main_blue"] ;
}

+ (UIColor *)xt_halfMainBlueColor
{
    return [self xt_colorWithKey:@"main_blue_half"] ;
}

+ (UIColor *)xt_lightGreenColor
{
    return [self xt_colorWithKey:@"light_green"] ;
}

+ (UIColor *)xt_lightBlueColor
{
    return [self xt_colorWithKey:@"light_blue"] ;
}

+ (UIColor *)xt_lightRedColor
{
    return [self xt_colorWithKey:@"light_red"] ;
}


@end
