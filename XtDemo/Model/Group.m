//
//  Group.m
//  XtDemo
//
//  Created by teason on 16/3/21.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "Group.h"
#import "Nickname.h"

@implementation Group

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"count" : @[@"count",@"num"]} ;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"nicknames" : [Nickname class]} ;
}

@end
