//
//  SortCondition.h
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    搜索类型
 */
typedef enum : NSUInteger {
    SortKeyPostTime = 1,        //发布时间
    SortKeyReadCount            //阅读量
} SortKey ;


@interface SortCondition : NSObject

// 升降序 true - asc , false - desc , default is False (DESC)
@property (nonatomic)        BOOL       bAscOrDesc ;
// 搜索类型 enum SortKey
@property (nonatomic)        SortKey    sortKey ;
// 正在使用中 default is False .
@property (nonatomic)        BOOL       beInUsed ;

- (NSString *)title ;

- (NSString *)getSortName ;

- (NSString *)getSortWay ;

@end
