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


// <span>日本</span>
- (NSString *)title
{
    if ([_title containsString:@"<span>"]) {
        _title = [_title stringByReplacingOccurrencesOfString:@"<span>" withString:@""] ;
        _title = [_title stringByReplacingOccurrencesOfString:@"</span>" withString:@""] ;
    }
    
    return _title ;
}

@end
