//
//  SelfChartView.m
//  XtDemo
//
//  Created by teason on 16/4/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SelfChartView.h"
#import "Nickname.h"
#import "UUChart.h"
#import "XTSegment.h"

typedef enum : NSUInteger {
    typeAllRead = 0,
    typeAvgRead,
    typeAllLike,
    typeWCI,
    type10W
} VericalValueType ;

@interface SelfChartView () <XTSegmentDelegate,UUChartDataSource>
{
    UIButton            *btBack ;
    UUChart             *chart ;
    NSArray             *m_mainList ;
    XTSegment           *segment ;
    VericalValueType    m_typeValue ;
    UILabel             *lb_brief ;
}

@end

static const CGFloat kSegmentHeight         = 50. ;
static const CGFloat kFlexDistanceLength    = 60. ;
static const CGFloat kLabelHeight           = 30. ;

@implementation SelfChartView

+ (NSArray *)segmentTitles
{
    return  @[@"总阅读",@"平均阅",@"总点赞",@"WCI",@"10W+"] ;
}

- (NSArray *)getHorizontalTitles
{
    NSMutableArray *titleList = [@[] mutableCopy] ;
    for (int i = 1; i <= m_mainList.count; i++)
    {
        [titleList addObject:[NSString stringWithFormat:@"%i",i]] ;
    }
    return titleList ;
}

- (instancetype)initWithList:(NSArray *)list
{
    self = [super init];
    if (self)
    {
        m_mainList = list ;
        
        m_typeValue = typeAllRead ;
        
        self.frame = APPFRAME ;
        
        btBack = [[UIButton alloc] initWithFrame:APPFRAME] ;
        [btBack addTarget:self
                   action:@selector(btBackOnClick)
         forControlEvents:UIControlEventTouchUpInside] ;
        [self addSubview:btBack] ;
        btBack.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.] ;
        
        segment = [[XTSegment alloc] initWithDataList:[[self class] segmentTitles]
                                                imgBg:nil
                                               height:kSegmentHeight
                                          normalColor:[UIColor lightGrayColor]
                                          selectColor:[UIColor xt_mainColor]
                                                 font:[UIFont boldSystemFontOfSize:13.]
                                                width:APP_WIDTH - 2 * kFlexDistanceLength] ;
        segment.delegate = self ;
        segment.backgroundColor = [UIColor whiteColor] ;
        [self addSubview:segment] ;
        
        lb_brief = [[UILabel alloc] init] ;
        lb_brief.textColor = [UIColor xt_mainColor] ;
        lb_brief.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:lb_brief] ;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews] ;
    
    self.frame = APPFRAME ;
    
    btBack.frame = APPFRAME ;
    
    segment.frame = CGRectMake(kFlexDistanceLength,
                               kFlexDistanceLength,
                               APP_WIDTH - 2 * kFlexDistanceLength ,
                               kSegmentHeight) ;

    lb_brief.frame = CGRectMake(kFlexDistanceLength ,
                                kFlexDistanceLength - kLabelHeight ,
                                APP_WIDTH - 2 * kFlexDistanceLength ,
                                kLabelHeight) ;
    
    [self reShowChartView] ;
}

- (void)reShowChartView
{
    if (chart) {
        [chart removeFromSuperview] ;
        chart = nil ;
    }
    CGRect rectChart = CGRectMake(kFlexDistanceLength,
                                  kFlexDistanceLength + kSegmentHeight,
                                  APP_WIDTH - 2 * kFlexDistanceLength,
                                  APP_HEIGHT - kSegmentHeight - 2 * kFlexDistanceLength) ;
    chart = [[UUChart alloc] initWithFrame:rectChart
                                dataSource:self
                                     style:UUChartStyleLine] ;
    [chart showInView:self] ;
    
    //
    [self resetBriefLabel] ;
}

- (void)resetBriefLabel
{
    // reset brief label
    NSString *typeString = [[self class] segmentTitles][m_typeValue] ;
    lb_brief.text = [NSString stringWithFormat:@"%@ - %@ 【%@】",
                     ((Nickname *)[m_mainList firstObject]).result_day,
                     ((Nickname *)[m_mainList lastObject]).result_day,
                     typeString
                     ] ;
}

#pragma mark - @SEL

- (void)btBackOnClick
{
    [UIView animateWithDuration:.25
                     animations:^{
                         
                         self.transform = CGAffineTransformScale(self.transform, 0.01, 0.01) ;
                         
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview] ;
                     }] ;
    
}

#pragma mark - XTSegmentDelegate 

- (void)clickSegmentWith:(int)index
{
    m_typeValue = index ;

    [UIView transitionWithView:chart
                      duration:.65
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                    } completion:^(BOOL finished) {
                        [self reShowChartView] ;
                    }] ;
    
}

#pragma mark - @required

//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getHorizontalTitles] ;
}

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSMutableArray *list = [@[] mutableCopy] ;
    
    for (Nickname *nick in m_mainList)
    {
        switch (m_typeValue)
        {
            case typeAllRead:
            {
                [list addObject:@(nick.readnum_all)] ;
            }
                break;
            case typeAvgRead:
            {
                [list addObject:@(nick.readnum_av)] ;
            }
                break;
            case typeAllLike:
            {
                [list addObject:@(nick.likenum_all)] ;
            }
                break;
            case typeWCI:
            {
                [list addObject:@(nick.wci)] ;
            }
                break;
            case type10W:
            {
                [list addObject:@(nick.url_num_10w)] ;
            }
                break;
            default:
                break;
        }
    }
    
    return @[list];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor xt_mainColor],[UUColor red],[UUColor brown]];
}

//显示数值范围
- (CGRange)chartRange:(UUChart *)_chart
{
    NSArray *list = [[self chartConfigAxisYValue:_chart] firstObject] ;
    list = [list sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 doubleValue] > [obj2 doubleValue]) {
            return NSOrderedDescending;
        }
        if ([obj1 doubleValue] < [obj2 doubleValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }] ;
    NSInteger deta = ( [[list lastObject] integerValue] - [[list firstObject] integerValue] ) / 5. ;
    return CGRangeMake([[list lastObject] integerValue] + deta , [[list firstObject] integerValue]);
}

#pragma mark - 折线图专享功能
////标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)_chart
{
    NSArray *list = [[self chartConfigAxisYValue:chart] firstObject] ;
    list = [list sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 doubleValue] > [obj2 doubleValue]) {
            return NSOrderedDescending;
        }
        if ([obj1 doubleValue] < [obj2 doubleValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }] ;
    
    double sum = 0. ;
    for (NSNumber *num in list) {
        sum += [num doubleValue] ;
    }
    double avg = sum / list.count ;
    
    return CGRangeMake(avg , [[list firstObject] integerValue]);
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES ;
}

//判断显示最大最小值
- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return YES ;
}

@end
