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

static NSString *const kPublicNameCell  = @"PublicNameCell" ;
static NSString *const kSortItemCell    = @"SortItemCell" ;

typedef enum : NSUInteger
{
    typePublicName ,
    typeArticle
} WXSearchType;

@interface SearchViewController () <UITextFieldDelegate>
{
    WXSearchType m_searchType ;
}
@property (weak, nonatomic) IBOutlet RootTableView *table;
@property (weak, nonatomic) IBOutlet UIButton *btSearch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (nonatomic,strong) NSMutableArray *list ;

@end

@implementation SearchViewController

- (NSMutableArray *)list
{
    if (_list) {
        _list = [@[] mutableCopy] ;
    }
    return _list ;
}

- (IBAction)btSearchOnClick:(id)sender
{
    NSString *keyword = _textfield.text ;
    
    if (m_searchType == typePublicName) {
        [ServerRequest searchNicknameWithKeyword:keyword
                                         success:^(id json) {

                                             [self.list removeAllObjects] ;
                                             
                                             ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                             if ([result.returnCode integerValue] != 1001) return ;
                                             NSDictionary *dicResult = result.returnData ;
                                             NSArray *tmpList = dicResult[@"items"] ;
                                             for (NSDictionary *tempDic in tmpList) {
                                                 Nickname *nick = [Nickname yy_modelWithJSON:tempDic] ;
                                                 [self.list addObject:nick] ;
                                             }
                                             
                                             [_table reloadData] ;
                                             
                                         } fail:^{
                                             
                                         }] ;
    }
    else if (m_searchType == typeArticle) {
        [ServerRequest searchArticlesWithKeyword:keyword
                                         success:^(id json) {
                                             
                                             
                                         } fail:^{
                                             
                                         }] ;
    }
    
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender
{
    m_searchType = sender.selectedSegmentIndex ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self configure] ;
}

- (void)configure
{
    self.view.backgroundColor = [UIColor xt_mainColor] ;
    _segment.tintColor = [UIColor whiteColor] ;
    _btSearch.backgroundColor = [UIColor xt_mainBlueColor] ;
    _btSearch.layer.cornerRadius = 5. ;
    
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
        return cell ;
    }
    else if (m_searchType == typeArticle)
    {
        SortItemCell *cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell] ;
        if (!cell) {
            cell = [_table dequeueReusableCellWithIdentifier:kSortItemCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        
        return cell ;
    }
    return nil ;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (m_searchType == typePublicName) {
        
    }
    else if (m_searchType == typeArticle) {
        
    }
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
