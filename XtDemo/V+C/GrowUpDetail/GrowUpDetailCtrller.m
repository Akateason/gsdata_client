//
//  GrowUpDetailCtrller.m
//  XtDemo
//
//  Created by teason on 16/4/21.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "GrowUpDetailCtrller.h"
#import "Nickname.h"
#import "PlistUtils.h"
#import "GrowUpDetailCtrller+Animations.h"
#import "EvernoteLayout.h"
#import "PropCollectionCell.h"


static NSString *kPropCollectionCell = @"PropCollectionCell" ;

@interface GrowUpDetailCtrller () <UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGPoint             leftCorner ;
}
@property (weak, nonatomic) IBOutlet UILabel            *lb_title;
@property (weak, nonatomic) IBOutlet UIButton           *button ;
@property (weak, nonatomic) IBOutlet UIButton           *btDayChange;
@property (weak, nonatomic) IBOutlet UICollectionView   *collection;

@property (nonatomic,strong) NSMutableArray             *titleList ;
@property (nonatomic,strong) NSDictionary               *nicknameProperties ;
@property (nonatomic,strong) NSArray                    *nicknameChineseNameList ;
@property (nonatomic,strong) PlistUtils                 *util ;

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
                                                           
                                                           [UIView transitionWithView:_collection
                                                                             duration:.3
                                                                              options:UIViewAnimationOptionTransitionFlipFromRight
                                                                           animations:^{
                                                                               
                                                                           } completion:^(BOOL finished) {
                                                                           
                                                                               self.lb_title.text = title ;
                                                                               [_collection reloadData] ;
                                                                               
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
    
    // title display
    _lb_title.text = [self.titleList lastObject] ;
    
    // collection view .
    _collection.alwaysBounceVertical = false ;
    _collection.delegate = self ;
    _collection.dataSource = self ;
    _collection.contentInset = UIEdgeInsetsMake(0, 0, verticallyPadding, 0) ;
    //    _collection.collectionViewLayout = [[EvernoteLayout alloc] init] ; // already set in Storyboard .
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
                                       table:_collection
                                  completion:^(BOOL finished) {
                                      
                                      if (finished) {
                                          //[_collection reloadData] ;
                                      }
                                      
     }] ;

}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.nicknameChineseNameList.count ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1 ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PropCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPropCollectionCell forIndexPath:indexPath] ;
    cell.backgroundColor = indexPath.section % 2 ? [UIColor xt_halfMainBlueColor] : [UIColor xt_halfMainColor] ;

    cell.lbKey.text = self.nicknameChineseNameList[indexPath.section] ;
    cell.lbVal.text = [NSString stringWithFormat:@"%@",self.nicknameProperties[self.nicknameChineseNameList[indexPath.section]]] ;
    cell.lbKey.textColor = [UIColor whiteColor] ;
    cell.lbVal.textColor = [UIColor darkGrayColor] ;
    
    return cell ;
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
