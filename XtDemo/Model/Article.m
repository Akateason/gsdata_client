//
//  Article.m
//  XtDemo
//
//  Created by teason on 16/3/23.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "Article.h"

@implementation Article

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"wx_nickname" : @[@"wx_nickname",@"name"] ,
             @"get_time" : @[@"get_time",@"add_time"]
             } ;
}

@end
