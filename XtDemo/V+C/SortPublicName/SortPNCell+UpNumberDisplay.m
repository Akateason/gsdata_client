//
//  SortPNCell+UpNumberDisplay.m
//  XtDemo
//
//  Created by teason on 16/3/29.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortPNCell+UpNumberDisplay.h"

@implementation SortPNCell (UpNumberDisplay)

- (NSString *)getDisplayStringWithUpNumber:(NSInteger)integer
{
    NSString *str = [NSString stringWithFormat:@"%ld",(long)integer] ;
    if (integer > 0)
    {
        return [@"+" stringByAppendingString:str] ;
    }
    else
    {
        return str ;
    }
}

- (UIColor *)getColorWithUpNumber:(NSInteger)integer
{
    if (integer > 0) {
        return [UIColor xt_redColor] ;
    }
    else if (integer == 0) {
        return [UIColor darkGrayColor] ;
    }
    else if (integer < 0) {
        return [UIColor xt_mainBlueColor] ;
    }
    
    return nil ;
}

@end
