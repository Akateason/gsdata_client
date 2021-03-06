//
//  PublicNameDetailCtrller.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PublicNameDetailCtrller.h"
#import "XTTickConvert.h"
#import "NSDate+Utilities.h"
#import "PublicNameInfoCell.h"
#import "NicknameInfo.h"
#import "YYModel.h"
#import "Article.h"
#import "PublicRecentCell.h"
#import "ArticleCtrller.h"
#import "ArticleRecentChartView.h"
#import "AdjustDeviceDirection.h"


@interface PublicNameDetailCtrller ()<UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate>

@property (weak, nonatomic) IBOutlet RootTableView *table;

@property (nonatomic,strong) ArticleRecentChartView *rChartView ;
@property (nonatomic,strong) NSMutableArray         *list_recentArticleInfo ;
@property (nonatomic,strong) NicknameInfo           *nickInfo ;

@end

@implementation PublicNameDetailCtrller

- (NSMutableArray *)list_recentArticleInfo
{
    if (!_list_recentArticleInfo) {
        _list_recentArticleInfo = [@[] mutableCopy] ;
    }
    return _list_recentArticleInfo ;
}

#pragma mark - List .

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"公众号" ;
    [self tableConfigure] ;
    
}

- (void)tableConfigure
{
    _table.delegate = self ;
    _table.dataSource = self ;
    _table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
//    [_table registerNib:[UINib nibWithNibName:kPublicNameInfoCellIdentifier bundle:nil] forCellReuseIdentifier:kPublicNameInfoCellIdentifier] ;
//    _table.estimatedRowHeight = 115.0f ;
    _table.rowHeight = UITableViewAutomaticDimension ;
    
}

#pragma mark - fetch from server .

- (void)fetchPublicNameInfo
{
    if (self.nickInfo.nickNameID != 0) return ;
    
    [ServerRequest fetchNickNameInfo:_selected_wx_publicNameID
                             success:^(id json) {
                                 
                                 ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                 if ([result.returnCode integerValue] != 1001) return ;
                                 NSDictionary *dicResult = result.returnData ;
                                 self.nickInfo = [NicknameInfo yy_modelWithJSON:dicResult] ;
                                 
                                 [_table reloadData] ;
                                 
                             } fail:^{
                                 
                             }] ;
}

- (void)fetchSevenDaysArticlesInfo
{
    if (self.list_recentArticleInfo.count) return ;
    
    NSString *yesterdayStr = [XTTickConvert getStrWithNSDate:[NSDate dateYesterday]
                                               AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    int beforeDay = 8 ;
    NSDate *earlyDay = [NSDate dateWithDaysBeforeNow:beforeDay] ; // 搜索时间不能跨月(服务端要求.)
    while ( ![earlyDay isThisMonth] && beforeDay ) {
        beforeDay -- ;
        earlyDay = [NSDate dateWithDaysBeforeNow:beforeDay] ;
    }
    NSString *earlyDayStr = [XTTickConvert getStrWithNSDate:earlyDay
                                              AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    
    [ServerRequest fetchWxWeekReadNumWithStartTime:earlyDayStr
                                           endTime:yesterdayStr
                                        nickNameID:_selected_wx_publicNameID
                                           success:^(id json) {
                                               
                                               ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                               if ([result.returnCode integerValue] != 1001) return ;
                                               NSDictionary *dicResult = result.returnData ;
                                               NSArray *list = dicResult[@"rows"] ;
                                               NSMutableArray *resultList = [@[] mutableCopy] ;
                                               for (NSDictionary *tmpDic in list)
                                               {
                                                   Article *article = [Article yy_modelWithJSON:tmpDic] ;
                                                   [resultList addObject:article] ;
                                               }
                                               
                                               NSArray *reverseList = [[resultList reverseObjectEnumerator] allObjects] ;
                                               
                                               self.list_recentArticleInfo = [reverseList mutableCopy] ;
                                               
                                               [_table reloadData] ;
                                               
                                           } fail:^{
                                               
                                           }] ;
}

#pragma mark - RootTableViewDelegate
- (void)loadNewData
{
    [self fetchPublicNameInfo] ;
    [self fetchSevenDaysArticlesInfo] ;
}

- (void)loadMoreData
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list_recentArticleInfo.count + 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [PublicNameInfoCell configureCell:self.nickInfo withTable:tableView] ;
    }
    else {
        return [PublicRecentCell configureCellWithArticle:self.list_recentArticleInfo[indexPath.row - 1]
                                             table:tableView
                                         indexPath:indexPath
                                         seeButton:^(NSString *url) {
                                             [self performSegueWithIdentifier:@"detail2Article" sender:url] ;
                                         }
                                    sevenDayButton:^(Article *article) {
                                        // custom a chart View .
                                        // transition scale into Screen .
                                        if (_rChartView) {
                                            [_rChartView removeFromSuperview] ;
                                            _rChartView = nil ;
                                        }
                                        _rChartView = [[ArticleRecentChartView alloc] initWithArticle:article] ;
                                        _rChartView.frame = APPFRAME ;
                                        [self.view.window addSubview:_rChartView] ;
                                        _rChartView.hidden = YES ;
                                        _rChartView.transform = CGAffineTransformScale(_rChartView.transform, 0.2, 0.2) ;
                                        
                                        
                                        [UIView transitionWithView:self.view.window
                                                          duration:.25
                                                           options:UIViewAnimationOptionCurveEaseOut
                                                        animations:^{
                                                            _rChartView.hidden = NO ;
                                                            _rChartView.transform = CGAffineTransformIdentity ;
                                                        }
                                                        completion:^(BOOL finished) {
                                                            
                                                        }] ;
                                        
                                        [AdjustDeviceDirection adjustDirection:UIInterfaceOrientationLandscapeRight] ;
                                    }] ;
        
            }
    
    return nil ;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 115. ;
    }
    else {
        return 80. ;
    }
    return 0 ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detail2Article"]) {
        NSString *url = sender ;
        ArticleCtrller *articleCtrller = segue.destinationViewController ;
        articleCtrller.urlStr = url ;
    }
}


@end
