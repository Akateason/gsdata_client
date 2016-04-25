//
//  GrowUpDetailCtrller.m
//  XtDemo
//
//  Created by teason on 16/4/21.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "GrowUpDetailCtrller.h"
#import "GrowUpDetailCell.h"
#import "Nickname.h"
#import "PlistUtils.h"
#import "GrowUpDetailCtrller+Animations.h"

static NSString *kGrowUpDetailCellIdentifier = @"GrowUpDetailCell" ;

@interface GrowUpDetailCtrller () <UITableViewDataSource,UITableViewDelegate>
{
    CGPoint leftCorner ;
}
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *button ;
@property (weak, nonatomic) IBOutlet UIButton *btDayChange;

@property (nonatomic,strong) NSMutableArray *titleList ;
@property (nonatomic,strong) NSDictionary   *nicknameProperties ;
@property (nonatomic,strong) NSArray        *nicknameChineseNameList ;
@property (nonatomic,strong) PlistUtils     *util ;

@end

@implementation GrowUpDetailCtrller

#pragma mark - Prop

- (NSMutableArray *)titleList
{
    if (!_titleList) {
        _titleList = [@[] mutableCopy] ;
        for (Nickname *nick in self.dataList)
        {
            [_titleList addObject:nick.result_day] ;
        }
    }
    return _titleList ;
}

- (PlistUtils *)util
{
    if (!_util) {
        _util = [[PlistUtils alloc] init] ;
    }
    return _util ;
}

- (NSDictionary *)nicknameProperties
{
    if (!_nicknameProperties) {
        _nicknameProperties = [self.util getResultWithNickName:[self.dataList lastObject]] ;
    }
    return _nicknameProperties ;
}

- (NSArray *)nicknameChineseNameList
{
    if (!_nicknameChineseNameList) {
        _nicknameChineseNameList = [self.util getChineseResultSequence] ;
    }
    return _nicknameChineseNameList ;
}

#pragma mark - Action

- (IBAction)btDayChangedOnClicked:(id)sender
{
    UIAlertController *alertCtrller = [UIAlertController alertControllerWithTitle:@"日期"
                                                                          message:nil preferredStyle:UIAlertControllerStyleActionSheet] ;
    
    for (NSString *title in self.titleList)
    {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                           [self.dataList enumerateObjectsUsingBlock:^(Nickname *nick, NSUInteger idx, BOOL * _Nonnull stop) {
                                                               if ([nick.result_day isEqualToString:title])
                                                               {
                                                                   self.nicknameProperties = [self.util getResultWithNickName:nick] ;
                                                                   *stop = YES ;
                                                               }
                                                           }] ;
                                                           
                                                           [UIView transitionWithView:_table
                                                                             duration:.3
                                                                              options:UIViewAnimationOptionTransitionFlipFromRight
                                                                           animations:^{
                                                                               
                                                                           } completion:^(BOOL finished) {
                                                                           
                                                                               self.lb_title.text = title ;
                                                                               [_table reloadData] ;

                                                                           }] ;
                                                           
                                                       }] ;
        [alertCtrller addAction:action] ;
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       NSLog(@"cancel clicked .") ;
                                                   }] ;
    [alertCtrller addAction:cancelAction] ;
    
    [self presentViewController:alertCtrller
                       animated:YES
                     completion:^{
                         
                     }] ;
}

- (IBAction)closeAction:(id)sender
{
    [self closeAnimationWithButton1:self.button
                            button2:self.btDayChange] ;
}

#pragma mark - Life

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.button.layer.cornerRadius = self.button.frame.size.width / 2. ;
    self.btDayChange.layer.cornerRadius = self.btDayChange.frame.size.width / 2. ;
    self.btDayChange.alpha = 0 ;
    self.button.hidden = YES ;
    
    _table.separatorStyle = UITableViewCellSeparatorStyleNone ;
    
    // title display
    _lb_title.text = [self.titleList lastObject] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews] ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    
    leftCorner = self.button.center ;
    self.button.center = CGPointMake(APP_WIDTH / 2, APP_HEIGHT / 2) ;
    self.button.hidden = NO ;
    [self animationInViewDidAppearWithButton:self.button
                                 btDayChange:self.btDayChange
                                  leftCorner:leftCorner
                                       table:_table
                                  completion:^(BOOL finished) {
                                      
                                      if (finished) {
                                          _table.delegate = self ;
                                          _table.dataSource = self ;
                                          [_table reloadData] ;
                                      }
                                      
     }] ;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nicknameProperties.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GrowUpDetailCell *cell = [_table dequeueReusableCellWithIdentifier:kGrowUpDetailCellIdentifier] ;
    if (!cell) {
        cell = [_table dequeueReusableCellWithIdentifier:kGrowUpDetailCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.label.text = self.nicknameChineseNameList[indexPath.row] ;
    cell.lb_val.text = [NSString stringWithFormat:@"%@",self.nicknameProperties[self.nicknameChineseNameList[indexPath.row]]] ;
    
    return cell ;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 151. ;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
