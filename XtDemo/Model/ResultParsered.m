//
//  ResultParsered.m
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "ResultParsered.h"
#import "CommonFunc.h"

@implementation ResultParsered

- (instancetype)initWithDic:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _returnCode     = dict[@"returnCode"] ;
        _returnMsg      = dict[@"returnMsg"] ;
        _feeCount       = [dict[@"feeCount"] integerValue] ;
        _returnData     = dict[@"returnData"] ;
    }
    
    return self;
}

@end
