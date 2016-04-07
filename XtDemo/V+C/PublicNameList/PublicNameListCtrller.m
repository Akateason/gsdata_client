//
//  PublicNameListCtrller.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PublicNameListCtrller.h"
#import "Group.h"
#import "PublicNameCell.h"
#import "Nickname.h"
#import "PublicNameDetailCtrller.h"
//#import "BRFlabbyTableManager.h"

static NSString *kPublicNameCell = @"PublicNameCell" ;

@interface PublicNameListCtrller () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet    RootTableView           *table ;
@property (nonatomic, strong)           NSArray                 *publicNameList ;
//@property (strong, nonatomic)           BRFlabbyTableManager    *flabbyTableManager;

@end

@implementation PublicNameListCtrller

#pragma mark - Prop
- (NSArray *)publicNameList
{
    if (!_publicNameList) {
        _publicNameList = self.group.nicknames ;
    }
    return _publicNameList ;
}

#pragma mark - Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tableConfigure] ;
    self.title = @"查看公众号" ;
    
//    _flabbyTableManager = [[BRFlabbyTableManager alloc] initWithTableView:_table];
//    [_flabbyTableManager setDelegate:self];
}

- (void)tableConfigure
{
    _table.delegate = self ;
    _table.dataSource = self ;
    //_table.xt_Delegate = self ;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [_table registerNib:[UINib nibWithNibName:kPublicNameCell bundle:nil] forCellReuseIdentifier:kPublicNameCell] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - RootTableViewDelegate
- (void)loadNewData
{
    
}
- (void)loadMoreData
{
    
}
*/

//#pragma mark - BRFlabbyTableManagerDelegate methods
//
//- (UIColor *)flabbyTableManager:(BRFlabbyTableManager *)tableManager flabbyColorForIndexPath:(NSIndexPath *)indexPath
//{
//    return [self colorForIndexPath:indexPath];
//}

#pragma mark - Miscellenanious
- (UIColor *)colorForIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row % 2 == 0 ? [UIColor whiteColor] : [UIColor xt_mainColor] ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.publicNameList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicNameCell *cell = [_table dequeueReusableCellWithIdentifier:kPublicNameCell] ;
    if (!cell) {
        cell = [_table dequeueReusableCellWithIdentifier:kPublicNameCell];
    }
    Nickname *nickName = self.publicNameList[indexPath.row] ;
    cell.nickName = nickName ;
    cell.backgroundColor = indexPath.row % 2 ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;

    return cell ;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.layer.transform = CATransform3DMakeScale(0.96, 0.96, 1) ;
    
    [UIView animateWithDuration:.25
                     animations:^{
                         cell.layer.transform = CATransform3DIdentity ;
                     }] ;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Nickname *nickName = self.publicNameList[indexPath.row] ;
    [self performSegueWithIdentifier:@"publicnamelist2detail" sender:nickName] ;
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"publicnamelist2detail"]) {
        PublicNameDetailCtrller *detailCtrller = segue.destinationViewController ;
        detailCtrller.selected_wx_publicNameID = ((Nickname *)sender).nickname_id ;
    }
}

@end
