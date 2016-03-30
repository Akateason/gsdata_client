//
//  SortCondition.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortCondition.h"

@implementation SortCondition

- (NSString *)title
{
    if (self.beInUsed) {
        return [[self keyName] stringByAppendingString:self.bAscOrDesc ? @"↑" : @"↓"] ;
    }
    return [self keyName] ;
}

- (NSString *)keyName
{
    switch (self.sortKey) {
        case SortKeyPostTime:
            return @"发布时间" ;
            break;
        case SortKeyReadCount:
            return @"阅读量" ;
            break;
        default:
            break;
    }
    return @"" ;
}

- (NSString *)getSortName
{
    switch (self.sortKey) {
        case SortKeyPostTime:
            return @"posttime" ;
            break;
        case SortKeyReadCount:
            return @"readnum" ;
            break;
        default:
            break;
    }
    return @"" ;
}

- (NSString *)getSortWay
{
    return self.bAscOrDesc ? @"asc" : @"desc" ;
}

@end



