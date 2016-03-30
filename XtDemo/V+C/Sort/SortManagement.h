//
//  SortManagement.h
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SortCondition.h"
#import "SortSeqButton.h"

typedef enum : NSUInteger {
    sortWayNewest,
    sortWayDay,
    sortWayWeek
} SortWay ;


@interface SortManagement : NSObject

- (instancetype)initWithConditionList:(NSArray *)conditionList ;

/**
 *  update latest Sort .
 *  make other sort 'beInUsed' to False .
 *  @param sort
 */
- (SortManagement *)updateSort:(SortCondition *)sort ;

/**
 *  fetch Completely Sort Result
 *
 *  @return SORT RESULT .
 */
- (SortCondition *)fetchCompletelySortResult ;

/**
 *  update date
 */
- (void)updateDate:(NSDate *)date ;

/**
 *  fetch Date
 *
 *  @return _dateSelected
 */
- (NSDate *)fetchDate ;

/**
 *  fetch SortWay
 *
 *  @return
 */
- (SortWay)fetchSortWay ;

/**
 *  update Sort Way
 *
 *  @param way
 */
- (void)updateSortWay:(SortWay)way ;

/**
 *  get SortWay String
 *
 *  @param way sortway
 *
 *  @return 最新, 日, 周 .
 */
- (NSString *)getSortWayString:(SortWay)way ;

/**
 *  update Interface
 *
 *  @param button
 */
- (void)updateInterfaceWith:(SortSeqButton *)button ;

@end
