//
//  PerMonthSortManagement.m
//  XtDemo
//
//  Created by TuTu on 16/5/19.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PerMonthSortManagement.h"
#import "NSDate+Utilities.h"
#import "NSDate+Addition.h"

@implementation PerMonthSortManagement

#pragma mark - public

- (NSString *)dateStartWithMonth:(int)month
{
    NSDate *now = [NSDate date] ;
    NSInteger thisYear = [now year] ;
    return [NSString stringWithFormat:@"%ld-%@-%@",(long)thisYear,[self formartStringWithDayMonth:month],[self formartStringWithDayMonth:1]] ;
}

- (NSString *)dateEndWithMonth:(int)month
{
    NSDate *now = [NSDate date] ;
    NSInteger thisYear = [now year] ;
    NSInteger maxDayInMonth = (NSInteger)[NSDate daysInMonth:month year:(int)thisYear] ;
    return [NSString stringWithFormat:@"%ld-%@-%@",(long)thisYear,[self formartStringWithDayMonth:month],[self formartStringWithDayMonth:maxDayInMonth]] ;
}

#pragma mark - private

- (NSString *)formartStringWithDayMonth:(NSInteger)dayMonth
{
    if (dayMonth < 10) {
        return [NSString stringWithFormat:@"0%ld",(long)dayMonth] ;
    }
    return [NSString stringWithFormat:@"%ld",(long)dayMonth] ;
}

@end
