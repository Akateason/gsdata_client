//
//  Nickname.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "Nickname.h"

@implementation Nickname

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
                @"nickname_id" : @[@"id",@"nickname_id"]
             };
}

@end
