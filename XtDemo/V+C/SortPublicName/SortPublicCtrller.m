//
//  SortPublicCtrller.m
//  XtDemo
//
//  Created by teason on 16/3/28.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortPublicCtrller.h"
#import "SortPNCell.h"
#import "NSDate+Utilities.h"
#import "XTTickConvert.h"
#import "Nickname.h"
#import "YYModel.h"
#import "HZQDatePickerView.h"
#import "PublicNameDetailCtrller.h"

typedef enum : NSUInteger {
    dayType = 0 , // DEFAULT
    weekType
} DateSegmentType;

static const NSInteger kRows = 10 ;


@interface SortPublicCtrller () <UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate,HZQDatePickerViewDelegate>
{
    NSDate              *m_dateWillPick ;
    NSDate              *m_last_date ;
    DateSegmentType     m_dateSegmentType ;
    NSString            *m_sortWayKey ;
    
    NSInteger           m_page ;
    HZQDatePickerView   *_pikerView;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIButton           *btDate;
@property (weak, nonatomic) IBOutlet RootTableView      *table;
@property (weak, nonatomic) IBOutlet UIButton           *btSortWay;
@property (weak, nonatomic) IBOutlet UIView             *topBarBackview;

@property (nonatomic,strong)         NSMutableArray     *list ;
@property (nonatomic,strong)         dispatch_queue_t   myQueue ;

@end

@implementation SortPublicCtrller
@synthesize list = _list ;

#pragma mark - Action

- (IBAction)dateSegmentValueChanged:(UISegmentedControl *)sender
{
    m_dateSegmentType = sender.selectedSegmentIndex ;
    
    [self loadNewData] ;
}

- (IBAction)btSortWayOnClick:(UIButton *)sender
{
    UIAlertController *alertCtrller = [UIAlertController alertControllerWithTitle:@"排序方式"
                                                                          message:nil
                                                                   preferredStyle:UIAlertControllerStyleActionSheet] ;
    int index = 0 ;
    for (NSString *key in [[self class] getSortWayValList]) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:key
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           NSLog(@"%@",[[self class] getSortWayStringWithIndex:index]) ;
                                                           m_sortWayKey = [[self class] getSortWayKeyList][index] ;
                                                           [self.btSortWay setTitle:[[self class] getSortWayDictionary][m_sortWayKey] forState:0] ;
                                                           [self loadNewData] ;
                                                       }] ;
        
        [alertCtrller addAction:action] ;
        index ++ ;
    }
    
    [alertCtrller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]] ;
    
    [self presentViewController:alertCtrller animated:YES completion:^{
        
    }] ;
}

- (IBAction)btDateOnClick:(UIButton *)sender
{
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    [_pikerView.datePickerView setMaximumDate:[NSDate dateYesterday]] ;
    _pikerView.datePickerView.date = m_dateWillPick ;
    
    [self.view.window addSubview:_pikerView];
}

#pragma mark - HZQ delegate

- (void)getSelectDate:(NSString *)date type:(DateType)type
{
    m_dateWillPick = [XTTickConvert getNSDateWithDateStr:date
                                           AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    if ([m_last_date isEqualToDate:m_dateWillPick]) return ;

    [_btDate setTitle:date forState:0] ;

    [self loadNewData] ;
}

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
    }
    return _list ;
    
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_table reloadData] ;
        }) ;

    }) ;
}

#pragma mark - Sort Way

+ (NSDictionary *)getSortWayDictionary
{
    return @{@"wci":@"微信传播指数(WCI)" ,
             @"readnum_all":@"总阅读" ,
             @"readnum_max":@"最高阅读" ,
             @"readnum_av":@"平均阅读" ,
             @"likenum_all":@"总点赞数"
             } ;
}

+ (NSArray *)getSortWayKeyList
{
    return @[@"wci" ,
             @"readnum_all" ,
             @"readnum_max" ,
             @"readnum_av"  ,
             @"likenum_all"] ;
}

+ (NSArray *)getSortWayValList
{
    NSMutableArray *list = [@[] mutableCopy] ;
    for (NSString *key in [self getSortWayKeyList]) {
        [list addObject:[self getSortWayDictionary][key]] ;
    }
    return list ;
}

+ (NSString *)getSortWayStringWithIndex:(NSInteger)index
{
    NSString *key = [self getSortWayKeyList][index] ;
    return [self getSortWayDictionary][key] ;
}

#pragma mark - Life

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"公众号排行" ;
    [self configureTable] ;
    [self configure] ;
}

- (void)configureTable
{
    _table.delegate = self ;
    _table.dataSource = self ;
    _table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [_table registerNib:[UINib nibWithNibName:kSortPNCellIdentifier bundle:nil] forCellReuseIdentifier:kSortPNCellIdentifier] ;
}

- (void)configure
{
    // DATA
    m_dateWillPick = [NSDate dateYesterday] ;
    m_page = 1 ;
    m_dateSegmentType = dayType ;
    m_sortWayKey = @"wci" ;
    
    // UI
    self.topBarBackview.backgroundColor = [UIColor xt_mainBlueColor] ;
    
    self.segment.tintColor = [UIColor whiteColor] ;
    
    self.btDate.layer.borderColor = [UIColor whiteColor].CGColor ;
    self.btDate.layer.borderWidth = 1. ;
    self.btDate.layer.cornerRadius = 5. ;
    [self.btDate setTitleColor:[UIColor whiteColor] forState:0] ;
    [self.btDate setTitle:[XTTickConvert getStrWithNSDate:m_dateWillPick
                                            AndWithFormat:TIME_STR_FORMAT_YY_MM_DD]
                 forState:0] ;
    
    self.btSortWay.layer.borderColor = [UIColor whiteColor].CGColor ;
    self.btSortWay.layer.borderWidth = 1. ;
    self.btSortWay.layer.cornerRadius = 5. ;
    [self.btSortWay setTitleColor:[UIColor whiteColor] forState:0] ;
    [self.btSortWay setTitle:[[self class] getSortWayDictionary][m_sortWayKey] forState:0] ;
}

#pragma mark - RootTableViewDelegate

- (void)loadNewData
{
    //[self.list removeAllObjects] ;
//    if (self.list.count) self.list = [@[] mutableCopy] ;
    
    m_last_date = m_dateWillPick ;
    
    switch (m_dateSegmentType) {
        case dayType:
        {
            NSString *dateString = [XTTickConvert getStrWithNSDate:m_dateWillPick
                                                     AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
            
            [ServerRequest sortInDayWithDayString:dateString
                                          groupID:_selectedGoupID
                                             sort:m_sortWayKey
                                           orrder:@"desc"
                                             page:m_page
                                             rows:kRows
                                          success:^(id json) {
                                              
                                              [self dealWithJson:json] ;
                                              
                                          } fail:^{
                                              
                                          }] ;
        }
            break;
        case weekType:
        {
            NSDate *dateSaturday = m_dateWillPick ;
            while (![dateSaturday isSaturday])
            {
                dateSaturday = [dateSaturday dateBySubtractingDays:1] ;
            }
            NSString *dateString = [XTTickConvert getStrWithNSDate:dateSaturday
                                                     AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
            
            [ServerRequest sortInWeekWithDayString:dateString
                                           groupID:_selectedGoupID
                                              sort:m_sortWayKey
                                            orrder:@"desc"
                                              page:m_page
                                              rows:kRows
                                           success:^(id json) {
                                               
                                               [self dealWithJson:json] ;
                                               
                                           } fail:^{
                                               
                                           }] ;
        }
            break;
        default:
            break;
    }
    
}

- (void)loadMoreData
{
    
}

- (void)dealWithJson:(id)json
{
    ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
    if ([result.returnCode integerValue] != 1001) return ;
    NSDictionary *dicResult = result.returnData ;
    NSArray *list = dicResult[@"rows"] ;
    NSMutableArray *resultList = [@[] mutableCopy] ;
    for (NSDictionary *tmpDic in list)
    {
        Nickname *nickN = [Nickname yy_modelWithJSON:tmpDic] ;
        [resultList addObject:nickN] ;
    }
    self.list = resultList ;
    
    if (!resultList.count)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"欧了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }] ;
        
        UIAlertController *alertCtrler = [UIAlertController alertControllerWithTitle:dicResult[@"errmsg"] message:nil preferredStyle:UIAlertControllerStyleAlert] ;
        [alertCtrler addAction:action] ;
        [self presentViewController:alertCtrler animated:YES completion:^{
            
        }] ;
    }
    
    [_table reloadData] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SortPNCell configureCellWithNick:self.list[indexPath.row]
                                 queueNumber:(NSInteger)(indexPath.row + 1)
                                       table:tableView] ;

}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150. ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Nickname *nick = self.list[indexPath.row] ;
    [self performSegueWithIdentifier:@"sortPublic2Detail" sender:nick] ;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"sortPublic2Detail"])
    {
        PublicNameDetailCtrller *detailCtrller = segue.destinationViewController ;
        detailCtrller.selected_wx_publicNameID = ((Nickname *)sender).nickname_id ;
    }
}

@end
