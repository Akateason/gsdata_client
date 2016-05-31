//
//  TopPerMonthController.m
//  XtDemo
//
//  Created by TuTu on 16/5/19.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "TopPerMonthController.h"
#import "SortItemCell.h"
#import "ArticleCtrller.h"
#import "Article.h"
#import "LoginHandler.h"
#import "YYModel.h"
#import "SortSeqButton.h"
#import "PerMonthSortManagement.h"
#import "NSDate+Utilities.h"
#import "MonthPickerHandler.h"


@interface TopPerMonthController () <UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate>
{
    PerMonthSortManagement  *m_sortManagement ;  // manage sort condition and get condition result to sort
    int                     m_page ;
    MonthPickerHandler      *m_pickerHandler ;
}
@property (weak, nonatomic) IBOutlet RootTableView  *table ;
@property (weak, nonatomic) IBOutlet UIButton       *btMonth;
@property (weak, nonatomic) IBOutlet SortSeqButton  *btReadCount;
@property (weak, nonatomic) IBOutlet SortSeqButton  *btPostTime;

@property (nonatomic,strong) NSMutableArray         *articleList ;
@property (nonatomic,strong) dispatch_queue_t       myQueue ;
@property (nonatomic,strong) UIPickerView           *picker ;

@end

@implementation TopPerMonthController

@synthesize articleList = _articleList ;

#pragma mark - prop

- (dispatch_queue_t)myQueue
{
    if (!_myQueue) {
        _myQueue = dispatch_queue_create("mySyncQueue", DISPATCH_QUEUE_CONCURRENT) ;
    }
    return _myQueue ;
}

- (NSMutableArray *)articleList
{
    if (!_articleList) {
        _articleList = [@[] mutableCopy] ;
        return _articleList ;
    }
    
    __block NSMutableArray *list ;
    dispatch_sync(self.myQueue, ^{
        list = _articleList ;
    }) ;
    return list ;
}

- (void)setArticleList:(NSMutableArray *)articleList
{
    dispatch_barrier_async(self.myQueue, ^{
        _articleList = articleList ;
    }) ;
}

- (UIPickerView *)picker
{
    if (!_picker) {
        _picker = [[UIPickerView alloc] init] ;
        CGRect pickerRect = CGRectZero ;
        pickerRect.size = CGSizeMake(self.view.bounds.size.width, 216) ;
        pickerRect.origin.y = self.view.bounds.size.height - 216 ;
        _picker.frame = pickerRect ;
        _picker.backgroundColor = [UIColor whiteColor] ;
    }
    return _picker ;
}

#pragma mark - Button Actions

- (IBAction)btMonthOnClick:(id)sender
{
    if (![self.picker superview]) {
        [self.view addSubview:self.picker] ;
    }
    else {
        [self.picker removeFromSuperview] ;
    }
}

- (IBAction)btReadCountOnClick:(id)sender
{
    [self refreshSortButtonsWithSender:sender] ;
    
    [self doFetchDatas:YES] ;
}

- (IBAction)btPostTimeOnClick:(id)sender
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
    m_sortManagement = (PerMonthSortManagement *)[m_sortManagement updateSort:sender.sort] ;
    
    [m_sortManagement updateInterfaceWith:_btPostTime] ;
    [m_sortManagement updateInterfaceWith:_btReadCount] ;
}

#pragma mark - life

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"头条" ;
    
    [self setupSortCondition] ;
    [self setupTable] ;
    
    m_pickerHandler = [[MonthPickerHandler alloc] init] ;
    [m_pickerHandler handlePicker:self.picker] ;
    [self freshMonthButton] ;
}

- (void)freshMonthButton
{
    NSString *str = ![m_pickerHandler getCurrentSelectedMonth] ? @"全部" : [NSString stringWithFormat:@"%d月",[m_pickerHandler getCurrentSelectedMonth]] ;
    [_btMonth setTitle:str forState:0] ;
}


- (void)setupTable
{
    _table.delegate = self ;
    _table.dataSource = self ;
    _table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [_table registerNib:[UINib nibWithNibName:kSortItemCell bundle:nil] forCellReuseIdentifier:kSortItemCell] ;
}

- (void)setupSortCondition
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
    m_sortManagement = [[PerMonthSortManagement alloc] initWithConditionList:@[sPostTime,sReadCount]] ;
    
    // 3. initial page
    m_page = 0 ;
    
    // 4. colors in condition bar .
    _btMonth.backgroundColor = [UIColor xt_mainBlueColor] ;
    _btPostTime.backgroundColor = [UIColor xt_mainBlueColor] ;
    _btReadCount.backgroundColor = [UIColor xt_mainBlueColor] ;
    
    [_btMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [_btPostTime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    [_btReadCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
    
    // 5.
    //    _dateSelView.date = [m_sortManagement fetchDate] ;
    //    _dateSelView.way = [m_sortManagement fetchSortWay] ;
    
    // 6. button date .
    //    [self freshDateButtonLabel] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)doFetchDatas:(BOOL)bNewData
{
    if (bNewData) {
        m_page = 0 ;
    }
    
    SortCondition *sortResult = [m_sortManagement fetchCompletelySortResult] ;
    NSString *dateStart = [m_sortManagement dateStartWithMonth:[m_pickerHandler getCurrentSelectedMonth]] ;
    NSString *dateEnd   = [m_sortManagement dateEndWithMonth:[m_pickerHandler getCurrentSelectedMonth]] ;
    NSLog(@"%@ , %@",dateStart,dateEnd) ;
    
    [ServerRequest fetchContentListWithWxName:[LoginHandler getWXnameString]
                                        start:m_page * 10
                                    dateStart:dateStart
                                      dateEnd:dateEnd
                                     sortName:[sortResult getSortName]
                                         sort:[sortResult getSortWay]
                                        isTop:true
                                       QuanBu:(![m_pickerHandler getCurrentSelectedMonth])
                                      success:^(id json) {
                                          
                                          ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                          if ([result.returnCode integerValue] != 1001) return ;
                                          NSDictionary *dicResult = result.returnData ;
                                          NSArray *tmpList = dicResult[@"items"] ;
                                          
                                          NSMutableArray *appendList = [@[] mutableCopy] ;
                                          for (NSDictionary *tmpDic in tmpList) {
                                              Article *article = [Article yy_modelWithJSON:tmpDic] ;
                                              [appendList addObject:article] ;
                                          }
                                          
                                          if (bNewData) {
                                              self.articleList = appendList ;
                                          }
                                          else {
                                              NSArray *originList = self.articleList ;
                                              NSMutableArray *resultList = [[originList arrayByAddingObjectsFromArray:appendList] mutableCopy];
                                              self.articleList = resultList ;
                                          }
                                          
                                          [_table reloadData] ;
                                          
                                          m_page ++ ;
                                          
                                      } fail:^{
                                          
                                      }] ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articleList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortItemCell *cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell] ;
    if (!cell) {
        cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.article = self.articleList[indexPath.row] ;
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
    if ([self.picker superview])
    {
        [self.picker removeFromSuperview] ;
        [self doFetchDatas:YES] ;
        [self freshMonthButton] ;
        return ;
    }
    
    Article *article = self.articleList[indexPath.row] ;
    [self performSegueWithIdentifier:@"artPerMon2article" sender:article] ;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [_table visibleCells];
    
    for (SortItemCell *cell in visibleCells) {
        [cell cellOnTableView:_table didScrollOnView:self.view];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"artPerMon2article"]) {
        ArticleCtrller *articleCtrller = segue.destinationViewController ;
        articleCtrller.urlStr = ((Article *)sender).url ;
    }
}

@end
