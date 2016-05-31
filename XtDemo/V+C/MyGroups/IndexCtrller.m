//
//  IndexCtrller.m
//  XtDemo
//
//  Created by teason on 16/3/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "IndexCtrller.h"
#import "XTJson.h"
#import "Group.h"
#import "YYModel.h"
#import "GroupCell.h"
#import "PublicNameListCtrller.h"
#import "SortViewController.h"
#import "SortPublicCtrller.h"
#import "NotificationCenterHeader.h"
#import "LoginHandler.h"


@interface IndexCtrller () <UITableViewDataSource,UITableViewDelegate,RootTableViewDelegate,GroupCellDelegate>

@property (weak, nonatomic) IBOutlet RootTableView *table;
@property (strong, nonatomic) NSMutableArray *groupList ; // groupList

@end

@implementation IndexCtrller

#pragma mark - Prop
- (NSMutableArray *)groupList
{
    if (!_groupList) {
        _groupList = [@[] mutableCopy] ;
    }
    return _groupList ;
}

#pragma mark - Notification
- (void)afterLoginNotificationSend
{
    [self loadNewData] ;
}


#pragma mark - Life
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(afterLoginNotificationSend)
                                                     name:NOTIFICATION_LOGINOUT
                                                   object:nil] ;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NOTIFICATION_LOGINOUT
                                                  object:nil] ;
}

- (void)viewDidLoad
{    
    [super viewDidLoad] ;
        
    self.title = @"组" ;
    
    _table.delegate = self ;
    _table.dataSource = self ;
    _table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [_table registerNib:[UINib nibWithNibName:kGroupCell bundle:nil] forCellReuseIdentifier:kGroupCell] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
//    [self modalIntoLauncherWithSegueIdentifier:@"index2launcher"] ;
}

#pragma mark - GroupCellDelegate
// 公众号排序
- (void)toSeeMore:(Group *)group
{
    [self performSegueWithIdentifier:@"root2sortPublicName" sender:group] ;
}

// 文章排序
- (void)toSorting:(Group *)group
{
    [self performSegueWithIdentifier:@"index2sort" sender:group] ;
}

#pragma mark - RootTableViewDelegate
- (void)loadNewData
{
    if (self.groupList.count) [self.groupList removeAllObjects] ;
    
    [ServerRequest fetchAllNickNameSuccess:^(id json) {
        
        ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
        if ([result.returnCode integerValue] != 1001) return ;
        NSDictionary *dicResult = result.returnData ;
        NSArray *list = dicResult[@"list"] ;
        for (NSDictionary *tmpDic in list) {
            Group *group = [Group yy_modelWithJSON:tmpDic] ;
            switch ([LoginHandler getCurrentUsersKindOfJob]) {
                case subaojiang:
                {
                    if (![group.groupname isEqualToString:@"日本"]) continue ;
                }
                    break;
                case xiaoxuzi:
                {
                    if (![group.groupname isEqualToString:@"美妆"]) continue ;
                }
                default:
                    break;
            }
            
            [self.groupList addObject:group] ;
        }
        
        [_table reloadData] ;

    } fail:^{
        
    }] ;
    
}

- (void)loadMoreData
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [GroupCell configureCellWithGroup:self.groupList[indexPath.row]
                             delegateHandler:self
                                       table:tableView] ;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 151. ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Group *group = self.groupList[indexPath.row] ;
    [self performSegueWithIdentifier:@"group2publicNameList" sender:group] ;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"group2publicNameList"]) {
        PublicNameListCtrller *pnlCtrller = segue.destinationViewController ;
        pnlCtrller.group = sender ;
    }
    else if ([segue.identifier isEqualToString:@"index2sort"]) {
        SortViewController *sortCtrller = segue.destinationViewController ;
        sortCtrller.selected_groupID = ((Group *)sender).groupid ;
    }
    else if ([segue.identifier isEqualToString:@"root2sortPublicName"]) {
        SortPublicCtrller *sortPublicCtrller = segue.destinationViewController ;
        sortPublicCtrller.selectedGoupID = ((Group *)sender).groupid ;
    }
    
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES] ;
}

@end
