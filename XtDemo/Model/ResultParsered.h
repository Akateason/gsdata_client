//
//  ResultParsered.h
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultParsered : NSObject

@property (nonatomic,copy)      NSString        *returnCode ;
@property (nonatomic,copy)      NSString        *returnMsg  ;
@property (nonatomic)           NSInteger       feeCount    ;
@property (nonatomic,copy)      id              returnData  ;

- (instancetype)initWithDic:(NSDictionary *)dict            ;

@end
