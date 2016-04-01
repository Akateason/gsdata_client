//
//  SortViewController.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortViewController.h"
#import "SortSeqButton.h"
#import "SortManagement.h"
#import "SortItemCell.h"
#import "XTTickConvert.h"
#import "Article.h"
#import "YYModel.h"
#import "ArticleCtrller.h"
#import "DateSelectedView.h"


static NSString *kSortItemCell = @"SortItemCell" ;
static const NSInteger kRows = 10 ; // 每页记录数(最大10条记录)

@interface SortViewController () <UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate,DateSelectedViewDelegate>
{
    SortManagement *m_sortManagement ;  // manage sort condition and get condition result to sort
    NSInteger       m_page ;            // 页码
}
@property (weak, nonatomic) IBOutlet RootTableView      *table;
@property (weak, nonatomic) IBOutlet UIButton           *btDate;
@property (weak, nonatomic) IBOutlet SortSeqButton      *btPostTime;
@property (weak, nonatomic) IBOutlet SortSeqButton      *btReadCount;

@property (nonatomic,strong)         DateSelectedView   *dateSelView ;

@property (nonatomic,strong)         NSMutableArray     *list ; // Array <article>
@property (nonatomic,strong)         dispatch_queue_t   myQueue ;

@end

@implementation SortViewController
@synthesize list = _list ;



#pragma mark - Prop
- (dispatch_queue_t)myQueue
{
    if (!_myQueue) {
        _myQueue = dispatch_queue_create("mySyncQueue", DISPATCH_QUEUE_CONCURRENT) ;
    }
    return _myQueue ;
}

- (NSMutableArray *)list
{
    if (!_list) {
        _list = [@[] mutableCopy] ;
        return _list ;
    }
    
    __block NSMutableArray *list ;
    dispatch_sync(self.myQueue, ^{
        list = _list ;
    }) ;
    return list ;
}

- (void)setList:(NSMutableArray *)list
{
    dispatch_barrier_async(self.myQueue, ^{
        _list = list ;
    }) ;
}

#pragma mark - DateSelectedViewDelegate
- (void)doConfirmWithDate:(NSDate *)dateSelected way:(NSInteger)waySelected
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         
                         _dateSelView.transform = CGAffineTransformScale(_dateSelView.transform, 0.01, 0.01) ;
                         
                     } completion:^(BOOL finished) {
                         
                         if ([_dateSelView superview] != nil) {
                             [_dateSelView removeFromSuperview] ;
                         }
                         
                         [m_sortManagement updateDate:dateSelected] ;
                         [m_sortManagement updateSortWay:waySelected] ;
                         
                         [self freshDateButtonLabel] ;
                         
                         // go for sort . ps + sort by ' sort way '
                         [self doFetchDatas:YES] ;
                     }] ;
}

#pragma mark - Buttons Action
- (IBAction)btDateClicked:(id)sender
{
    [self fetchNewDataForDateSelView] ;
    
    _dateSelView.transform = CGAffineTransformScale(_dateSelView.transform, 0.2, 0.2) ;
    [self.view.window addSubview:_dateSelView] ;
    _dateSelView.hidden = YES ;

    [UIView transitionWithView:self.view.window
                      duration:0.25
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        
                        _dateSelView.hidden = NO ;
                        _dateSelView.transform = CGAffineTransformIdentity ;
                        
                    } completion:^(BOOL finished) {
                        
                    }] ;
}

- (IBAction)btPostTimeClicked:(SortSeqButton *)sender
{
    [self refreshSortButtonsWithSender:sender] ;
    
    [self doFetchDatas:YES] ;
}

- (IBAction)btReadCountClicked:(SortSeqButton *)sender
{
    [self refreshSortButtonsWithSender:sender] ;
    
    [self doFetchDatas:YES] ;
}

/**
 *  refresh SortButtons
 *
 *  @param sender only 'SortSeqButton'
 */
- (void)refreshSortButtonsWithSender:(SortSeqButton *)sender
{
    m_sortManagement = [m_sortManagement updateSort:sender.sort] ;
    
    [m_sortManagement updateInterfaceWith:_btPostTime] ;
    [m_sortManagement updateInterfaceWith:_btReadCount] ;
}

#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"文章排名" ;
    
    [self configure] ;
    [self tableConfigure] ;
}

- (void)configure
{
    // new sort Condition list .
    // 1. initial 2 bts
    SortCondition *sReadCount = [[SortCondition alloc] init] ;
    sReadCount.beInUsed = YES ;
    sReadCount.sortKey = SortKeyReadCount ;
    _btReadCount.sort = sReadCount ;
    
    SortCondition *sPostTime = [[SortCondition alloc] init] ;
    sPostTime.sortKey = SortKeyPostTime ;
    _btPostTime.sort = sPostTime ;
    
    // 2. initial manager with bts list .
    m_sortManagement = [[SortManagement alloc] initWithConditionList:@[sPostTime,sReadCount]] ;

    // 3. initial page
    m_page = 1 ;
    
    // 4. colors in condition bar .
    _btDate.backgroundColor = [UIColor xt_mainBlueColor] ;
    _btPostTime.backgroundColor = [UIColor xt_mainBlueColor] ;
    _btReadCount.backgroundColor = [UIColor xt_mainBlueColor] ;
    
    [_btDate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [_btPostTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [_btReadCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    
    // 5. initial date Select View
    _dateSelView = [[[NSBundle mainBundle] loadNibNamed:@"DateSeletedView" owner:self options:nil] lastObject] ;
    _dateSelView.frame = APPFRAME ;
    _dateSelView.delegate = self ;
    [self fetchNewDataForDateSelView] ;
    
    // 6. button date .
    [self freshDateButtonLabel] ;
}

- (void)fetchNewDataForDateSelView
{
    _dateSelView.date = [m_sortManagement fetchDate] ;
    _dateSelView.way = [m_sortManagement fetchSortWay] ;
}

- (void)freshDateButtonLabel
{
    NSString *timeStr = [XTTickConvert getStrWithNSDate:[m_sortManagement fetchDate] AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
//    NSString *sortWayStr = [m_sortManagement getSortWayString:[m_sortManagement fetchSortWay]] ;
//    [_btDate setTitle:[NSString stringWithFormat:@"%@\n[%@]",timeStr,sortWayStr] forState:0] ;
//    _btDate.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [_btDate setTitle:timeStr forState:0] ;
}

- (void)tableConfigure
{
    _table.delegate = self ;
    _table.dataSource = self ;
    _table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [_table registerNib:[UINib nibWithNibName:kSortItemCell bundle:nil] forCellReuseIdentifier:kSortItemCell] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doFetchDatas:(BOOL)bNewData
{
    if (bNewData)
    {
        m_page = 1 ;
        if (self.list.count) [self.list removeAllObjects] ;
    }
    
    SortCondition *sortResult = [m_sortManagement fetchCompletelySortResult] ;
    
    NSString *dateString = [XTTickConvert getStrWithNSDate:[m_sortManagement fetchDate]
                                             AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    
    [ServerRequest sortInGroupWithDayString:dateString
                                    groupID:_selected_groupID
                                   sortName:[sortResult getSortName]
                                       sort:[sortResult getSortWay]
                                       page:m_page
                                       rows:kRows
                                    success:^(id json) {
                                        
                                        ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                        if ([result.returnCode integerValue] != 1001) return ;
                                        NSDictionary *dicResult = result.returnData ;
                                        NSArray *tmpList = dicResult[@"rows"] ;
                                        for (NSDictionary *tmpDic in tmpList) {
                                            Article *article = [Article yy_modelWithJSON:tmpDic] ;
                                            [self.list addObject:article] ;
                                        }
                                        
                                        [_table reloadData] ;
                                        
                                        m_page ++ ;
                                        
                                    }
                                       fail:^{
                                           
                                       }] ;
    
    
}

#pragma mark - RootTableViewDelegate
- (void)loadNewData
{
    [self doFetchDatas:YES] ;
}

- (void)loadMoreData
{
    [self doFetchDatas:NO] ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortItemCell *cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell] ;
    if (!cell) {
        cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.article = self.list[indexPath.row] ;
    cell.backgroundColor = indexPath.row % 2 ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;
    
    return cell ;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 132. ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = self.list[indexPath.row] ;
    [self performSegueWithIdentifier:@"sort2article" sender:article] ;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"sort2article"]) {
        ArticleCtrller *articleCtrller = segue.destinationViewController ;
        articleCtrller.urlStr = ((Article *)sender).url ;
    }
}

@end
