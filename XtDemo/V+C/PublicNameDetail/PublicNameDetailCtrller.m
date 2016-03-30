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


static NSString *kPublicNameInfoCellIdentifier = @"PublicNameInfoCell" ;
static NSString *kPublicRecentCellIdentifier = @"PublicRecentCell" ;

@interface PublicNameDetailCtrller ()<UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate>

@property (weak, nonatomic) IBOutlet RootTableView *table;

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
    
    NSString *yesterdayStr = [XTTickConvert getStrWithNSDate:[NSDate dateYesterday] AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    NSDate *earlyDay = [NSDate dateWithDaysBeforeNow:7] ;
    NSString *earlyDayStr = [XTTickConvert getStrWithNSDate:earlyDay AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    
    [ServerRequest fetchWxWeekReadNumWithStartTime:earlyDayStr
                                           endTime:yesterdayStr
                                        nickNameID:_selected_wx_publicNameID
                                           success:^(id json) {
                                               
                                               ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                               if ([result.returnCode integerValue] != 1001) return ;
                                               NSDictionary *dicResult = result.returnData ;
                                               NSArray *list = dicResult[@"rows"] ;
                                               for (NSDictionary *tmpDic in list)
                                               {
                                                   Article *article = [Article yy_modelWithJSON:tmpDic] ;
                                                   [self.list_recentArticleInfo addObject:article] ;
                                               }
                                               
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
        PublicNameInfoCell *cell = [_table dequeueReusableCellWithIdentifier:kPublicNameInfoCellIdentifier] ;
        if (!cell) {
            cell = [_table dequeueReusableCellWithIdentifier:kPublicNameInfoCellIdentifier] ;
        }
        cell.nicknameInfo = self.nickInfo ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        return cell ;
    }
    else {
        PublicRecentCell *cell = [_table dequeueReusableCellWithIdentifier:kPublicRecentCellIdentifier] ;
        if (!cell) {
            cell = [_table dequeueReusableCellWithIdentifier:kPublicRecentCellIdentifier] ;
        }
        cell.article = self.list_recentArticleInfo[indexPath.row - 1] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.backgroundColor = indexPath.row % 2 ? [UIColor whiteColor] : [UIColor xt_halfMainColor] ;
        return cell ;
    }
    
    return nil ;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.layer.transform = CATransform3DMakeScale(0.96, 0.96, 1) ;
    cell.transform = CGAffineTransformMakeTranslation(APP_WIDTH / 2. , 0) ;
    [UIView animateWithDuration:.65
                     animations:^{
                         cell.transform = CGAffineTransformIdentity ;
                     }] ;
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
