//
//  ArticleRecentChartView.m
//  XtDemo
//
//  Created by teason on 16/3/31.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "ArticleRecentChartView.h"
#import "UUChart.h"
#import "Article.h"

@interface ArticleRecentChartView () <UUChartDataSource>
{
    UUChart     *chartViewRead ;
    UUChart     *chartViewLike ;
    UILabel     *lb_1 ;
    UILabel     *lb_2 ;
    UIButton    *btBack ;
    Article     *m_article ;
}

@end

@implementation ArticleRecentChartView


static const CGFloat kLabelHeight = 20. ;
#define chartWidth      APP_WIDTH * .75
#define chartHeight     APP_HEIGHT * .75 / 2. - kLabelHeight
#define orgX            (APP_WIDTH - chartWidth) / 2. 
#define orgY            (APP_HEIGHT - APP_HEIGHT * .75) / 2.


- (instancetype)initWithArticle:(Article *)article
{
    self = [super init];
    if (self)
    {
        m_article = article ;

        self.frame = APPFRAME ;
        
        btBack = [[UIButton alloc] initWithFrame:APPFRAME] ;
        [btBack addTarget:self action:@selector(btBackOnClick) forControlEvents:UIControlEventTouchUpInside] ;
        [self addSubview:btBack] ;
        btBack.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1.] ;

        lb_1 = [[UILabel alloc] initWithFrame:CGRectMake(orgX, orgY, chartWidth, kLabelHeight)] ;
        lb_1.text = @"阅读(距离7天)" ;
        lb_1.textColor = [UIColor whiteColor] ;
        lb_1.font = [UIFont systemFontOfSize:13.] ;
        lb_1.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:lb_1] ;
        
        lb_2 = [[UILabel alloc] initWithFrame:CGRectMake(orgX, APP_HEIGHT / 2., chartWidth, kLabelHeight)] ;
        lb_2.text = @"点赞(距离7天)" ;
        lb_2.textColor = [UIColor whiteColor] ;
        lb_2.font = [UIFont systemFontOfSize:13.] ;
        lb_2.textAlignment = NSTextAlignmentCenter ;
        [self addSubview:lb_2] ;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews] ;
    
    
    self.frame = APPFRAME ;
    btBack.frame = APPFRAME ;
    lb_1.frame = CGRectMake(orgX, orgY, chartWidth, kLabelHeight) ;
    lb_2.frame = CGRectMake(orgX, APP_HEIGHT / 2., chartWidth, kLabelHeight) ;
    
    if (chartViewRead || chartViewLike) {
        [chartViewRead removeFromSuperview] ;
        chartViewRead = nil ;
        [chartViewLike removeFromSuperview] ;
        chartViewLike = nil ;
    }
    
    CGRect rectRead = CGRectMake(orgX, orgY + kLabelHeight, chartWidth, chartHeight) ;
    chartViewRead = [[UUChart alloc] initWithFrame:rectRead
                                        dataSource:self
                                             style:UUChartStyleLine] ;
    [chartViewRead showInView:self];
    
    CGRect rectLike = CGRectMake(orgX, APP_HEIGHT / 2. + kLabelHeight, chartWidth, chartHeight) ;
    chartViewLike = [[UUChart alloc] initWithFrame:rectLike
                                        dataSource:self
                                             style:UUChartStyleLine] ;
    [chartViewLike showInView:self];


}

- (void)btBackOnClick
{
    [UIView animateWithDuration:.25
                     animations:^{
                         
                         self.transform = CGAffineTransformScale(self.transform, 0.01, 0.01) ;
                         
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview] ;
                     }] ;
    
    
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array] ;
    for (int i = 1; i <= num; i++) {
        NSString *str = [NSString stringWithFormat:@"day%d",i] ;
        [xTitles addObject:str] ;
    }
    return xTitles ;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:7] ;
}

//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSArray *list = @[] ;
    if (chart == chartViewRead) {
        list = @[@(m_article.read_num_1),@(m_article.read_num_2),@(m_article.read_num_3),@(m_article.read_num_4),@(m_article.read_num_5),@(m_article.read_num_6),@(m_article.read_num_7)] ;
    }
    else if (chart == chartViewLike)
    {
        list = @[@(m_article.like_num_1),@(m_article.like_num_2),@(m_article.like_num_3),@(m_article.like_num_4),@(m_article.like_num_5),@(m_article.like_num_6),@(m_article.like_num_7)] ;
    }
    
    return @[list];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor green],[UUColor red],[UUColor brown]];
}

//显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{
    NSArray *list = [[self chartConfigAxisYValue:chart] firstObject] ;
    list = [list sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 floatValue] > [obj2 floatValue]) {
            return NSOrderedDescending;
        }
        if ([obj1 floatValue] < [obj2 floatValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }] ;
    
    return CGRangeMake([[list lastObject] integerValue], [[list firstObject] integerValue]);
}

#pragma mark - 折线图专享功能
//标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    return CGRangeMake(25, 75) ;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
