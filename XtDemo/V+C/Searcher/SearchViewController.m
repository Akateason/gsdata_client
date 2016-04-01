//
//  SearchViewController.m
//  XtDemo
//
//  Created by teason on 16/3/31.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SearchViewController.h"
#import "PublicNameCell.h"
#import "SortItemCell.h"
#import "YYModel.h"
#import "Nickname.h"
#import "Article.h"
#import "ArticleCtrller.h"
#import "PublicNameDetailCtrller.h"

static NSString *const kPublicNameCell  = @"PublicNameCell" ;
static NSString *const kSortItemCell    = @"SortItemCell" ;

static const NSInteger kNum             = 10 ;

typedef enum : NSUInteger
{
    typePublicName ,
    typeArticle
} WXSearchType;

@interface SearchViewController () <UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate>
{
    WXSearchType m_searchType ;
    NSInteger    m_page ; // default is 0 ;
}
@property (weak, nonatomic) IBOutlet RootTableView *table;
@property (weak, nonatomic) IBOutlet UIButton *btSearch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (nonatomic,strong) NSMutableArray *list ;
@property (nonatomic,strong) dispatch_queue_t myQueue ;

@end

@implementation SearchViewController
@synthesize list = _list ;

#pragma mark --
#pragma mark - prop

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
    }) ;
}

#pragma mark --

- (void)fetchNewData
{
    [_textfield resignFirstResponder] ;
    
    NSString *keyword = _textfield.text ;
    
    if (m_searchType == typePublicName)
    {
        [ServerRequest searchNicknameWithKeyword:keyword
                                           start:m_page * kNum
                                         success:^(id json) {
                                             
                                             m_page++ ;
                                             
                                             ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                             if ([result.returnCode integerValue] != 1001) return ;
                                             NSDictionary *dicResult = result.returnData ;
                                             NSArray *tmpList = dicResult[@"items"] ;
                                             NSMutableArray *resultList = (!self.list.count) ? [NSMutableArray array] : [NSMutableArray arrayWithArray:self.list];
                                             for (NSDictionary *tempDic in tmpList) {
                                                 Nickname *nick = [Nickname yy_modelWithJSON:tempDic] ;
                                                 [resultList addObject:nick] ;
                                             }
                                             
                                             self.list = resultList ;
                                             [_table reloadData] ;
                                             
                                         } fail:^{
                                             
                                         }] ;
    }
    else if (m_searchType == typeArticle)
    {
        [ServerRequest searchArticlesWithKeyword:keyword
                                           start:m_page * kNum
                                         success:^(id json) {
                                             
                                             m_page++ ;
                                             
                                             ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                             if ([result.returnCode integerValue] != 1001) return ;
                                             NSDictionary *dicResult = result.returnData ;
                                             NSArray *tmpList = dicResult[@"items"] ;
                                             NSMutableArray *resultList = (!self.list.count) ? [NSMutableArray array] : [NSMutableArray arrayWithArray:self.list];
                                             for (NSDictionary *tempDic in tmpList) {
                                                 Article *article = [Article yy_modelWithJSON:tempDic] ;
                                                 [resultList addObject:article] ;
                                             }
                                             
                                             self.list = resultList ;
                                             [_table reloadData] ;
                                             
                                         } fail:^{
                                             
                                         }] ;
    }

}

#pragma mark --
#pragma mark - Action

- (IBAction)btSearchOnClick:(id)sender
{
    m_page = 0 ;
    [self.list removeAllObjects] ;
    
    [self fetchNewData] ;
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender
{
    m_searchType = sender.selectedSegmentIndex ;

    m_page = 0 ;
    [self.list removeAllObjects] ;

    [self fetchNewData] ;
}

#pragma mark --
#pragma mark - life

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _textfield.text = @"日本" ;
    
    [self configure] ;
    [self tableConfigure] ;
}

- (void)configure
{
    self.view.backgroundColor = [UIColor xt_mainColor] ;
    _segment.tintColor = [UIColor whiteColor] ;
    _btSearch.backgroundColor = [UIColor xt_mainBlueColor] ;
    _btSearch.layer.cornerRadius = 5. ;
}

- (void)tableConfigure
{
    _table.delegate = self ;
    _table.dataSource = self ;
    _table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [_table registerNib:[UINib nibWithNibName:kPublicNameCell bundle:nil] forCellReuseIdentifier:kPublicNameCell] ;
    [_table registerNib:[UINib nibWithNibName:kSortItemCell bundle:nil] forCellReuseIdentifier:kSortItemCell] ;
    _table.rowHeight = UITableViewAutomaticDimension ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    self.navigationController.navigationBarHidden = YES ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
    self.navigationController.navigationBarHidden = NO ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RootTableViewDelegate
- (void)loadNewData
{
    
}

- (void)loadMoreData
{
    [self fetchNewData] ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_searchType == typePublicName)
    {
        PublicNameCell *cell = [_table dequeueReusableCellWithIdentifier:kPublicNameCell] ;
        if (!cell) {
            cell = [_table dequeueReusableCellWithIdentifier:kPublicNameCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.nickName = self.list[indexPath.row] ;
        cell.backgroundColor = indexPath.row % 2 ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;
        return cell ;
    }
    else if (m_searchType == typeArticle)
    {
        SortItemCell *cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell] ;
        if (!cell) {
            cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        cell.backgroundColor = indexPath.row % 2 ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;
        cell.article = self.list[indexPath.row] ;
        return cell ;
    }
    return nil ;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_searchType == typePublicName) {
        [self performSegueWithIdentifier:@"search2publicnameDetail" sender:self.list[indexPath.row]] ;
    }
    else if (m_searchType == typeArticle) {
        [self performSegueWithIdentifier:@"search2article" sender:self.list[indexPath.row]] ;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_searchType == typePublicName) {
        return 120. ;
    }
    else if (m_searchType == typeArticle) {
        return 132. ;
    }
    return 0 ;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"search2article"]) {
        ArticleCtrller *aCtrller = segue.destinationViewController ;
        aCtrller.urlStr = ((Article *)sender).url ;
    }
    else if ([segue.identifier isEqualToString:@"search2publicnameDetail"]) {
        PublicNameDetailCtrller *detailCtrller = segue.destinationViewController ;
        detailCtrller.selected_wx_publicNameID = ((Nickname *)sender).nickname_id ;
    }
    
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES] ;
}

@end
