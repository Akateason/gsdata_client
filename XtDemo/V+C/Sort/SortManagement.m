//
//  SortManagement.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortManagement.h"
#import "NSDate+Utilities.h"

@interface SortManagement ()
{
    // 必要条件 (发布时间, 阅读量) 控制选中状态唯一 NSArray <SortCondition>
    NSMutableArray  *_necessaryList ;
    // 选择的日期
    NSDate          *_dateSelected ;
    // 最终结果
    SortCondition   *_completedSortResult ;
    // 日期的排序方式
    SortWay         _sortWay ;
}
@end

@implementation SortManagement

#pragma mark - PUBLIC FUNC
/**
 *  INITIAL
 *
 *  @param conditionList
 *
 *  @return
 */
- (instancetype)initWithConditionList:(NSArray *)conditionList
{
    self = [super init];
    if (self) {
        _necessaryList = [conditionList mutableCopy] ;
        _dateSelected = [NSDate dateYesterday] ;
        _completedSortResult = [[SortCondition alloc] init] ;
        _completedSortResult.sortKey = SortKeyReadCount ;
        _completedSortResult.beInUsed = YES ;
        _sortWay = sortWayNewest ;
    }
    return self;
}

/**
 *  PUBLIC FUNC
 *
 *  @return SORT RESULT .
 */
- (SortCondition *)fetchCompletelySortResult
{
    return _completedSortResult ;
}

/**
 *  fetchDate
 *
 *  @return _dateSelected
 */
- (NSDate *)fetchDate
{
    return _dateSelected ;
}

/**
 *  update date
 */
- (void)updateDate:(NSDate *)date
{
    _dateSelected = date ;
}

- (SortWay)fetchSortWay
{
    return _sortWay ;
}

- (void)updateSortWay:(SortWay)way
{
    _sortWay = way ;
}

- (NSString *)getSortWayString:(SortWay)way
{
    NSString *str = @"" ;
    switch (way) {
        case sortWayNewest:
        {
            str = @"最新" ;
        }
            break;
        case sortWayDay:
        {
            str = @"日" ;
        }
            break;
        case sortWayWeek:
        {
            str = @"周" ;
        }
            break;
        default:
            break;
    }
    return str ;
}

/**
 *  update latest Sort .
 *  make other sort 'beInUsed' to False .
 *  @param sort
 */
- (SortManagement *)updateSort:(SortCondition *)sort
{
    BOOL beInUseBefore = false;
    
    for (int i = 0 ; i < _necessaryList.count ; i++)
    {
        beInUseBefore = ((SortCondition *)_necessaryList[i]).beInUsed ;
        
        ((SortCondition *)_necessaryList[i]).beInUsed = (((SortCondition *)_necessaryList[i]).sortKey == sort.sortKey) ;
        
        if (beInUseBefore && ((SortCondition *)_necessaryList[i]).beInUsed) {
            ((SortCondition *)_necessaryList[i]).bAscOrDesc = !((SortCondition *)_necessaryList[i]).bAscOrDesc ;
        }
        
        if (((SortCondition *)_necessaryList[i]).beInUsed == YES)
        {
            _completedSortResult = (SortCondition *)_necessaryList[i] ;
        }
    }
//    NSLog(@"update COMPLETE : %@",_necessaryList) ;
    return self ;
}

/**
 *  updateInterfaceWith
 *
 *  @param button
 */
- (void)updateInterfaceWith:(SortSeqButton *)button
{    
    [_necessaryList enumerateObjectsUsingBlock:^(SortCondition *sort, NSUInteger idx, BOOL * _Nonnull stop) {
        if (sort.sortKey == button.sort.sortKey) {
            button.sort = sort ;
            *stop = YES ;
        }
    }] ;
}

@end
