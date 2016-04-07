//
//  SelfGrowUpCtrller.m
//  XtDemo
//
//  Created by teason on 16/4/5.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SelfGrowUpCtrller.h"
#import "Nickname.h"
#import "YYModel.h"
#import "SelfChartView.h"

@interface SelfGrowUpCtrller () <UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *list_7days ;
@property (nonatomic,strong) NSMutableArray *list_30days ;

@property (nonatomic,strong) SelfChartView  *chartView ;

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *btYue;
@property (weak, nonatomic) IBOutlet UIButton *btZhou;

@end

@implementation SelfGrowUpCtrller

#pragma mark - Prop

- (NSMutableArray *)list_7days
{
    if (!_list_7days) {
        _list_7days = [@[] mutableCopy] ;
    }
    return _list_7days ;
}

- (NSMutableArray *)list_30days
{
    if (!_list_30days) {
        _list_30days = [@[] mutableCopy] ;
    }
    return _list_30days ;
}

#pragma mark - Action

- (IBAction)btZhouOnclick:(id)sender
{
    if (!self.list_7days.count)
    {
        [ServerRequest fetchNickNameOrderList3Days:self.textfield.text
                                               num:7
                                           success:^(id json) {
                                               
                                               ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                               if ([result.returnCode integerValue] != 1001) return ;
                                               NSDictionary *dicResult = result.returnData ;
                                               NSArray *list = dicResult[@"items"] ;
                                               for (NSDictionary *tmpDic in list) {
                                                   Nickname *nick = [Nickname yy_modelWithJSON:tmpDic] ;
                                                   [self.list_7days addObject:nick] ;
                                               }
                                               
                                               [self showChartWithButton:sender data:self.list_7days] ;
                                               
                                           } fail:^{
                                               
                                           }] ;
    } else {
        [self showChartWithButton:sender data:self.list_7days] ;
    }
    
}

- (IBAction)btYueOnclick:(id)sender
{
    if (!self.list_30days.count)
    {
        [ServerRequest fetchNickNameOrderList3Days:self.textfield.text
                                               num:30
                                           success:^(id json) {
                                               
                                               ResultParsered *result = [[ResultParsered alloc] initWithDic:json] ;
                                               if ([result.returnCode integerValue] != 1001) return ;
                                               NSDictionary *dicResult = result.returnData ;
                                               NSArray *list = dicResult[@"items"] ;
                                               for (NSDictionary *tmpDic in list) {
                                                   Nickname *nick = [Nickname yy_modelWithJSON:tmpDic] ;
                                                   [self.list_30days addObject:nick] ;
                                               }
                                               
                                               [self showChartWithButton:sender data:self.list_30days] ;
                                               
                                           } fail:^{
                                               
                                           }] ;
    }
    else
    {
        [self showChartWithButton:sender data:self.list_30days] ;
    }
}

#pragma mark - Chart 

- (void)showChartWithButton:(UIButton *)button data:(NSArray *)dataList
{
    if (_chartView)
    {
        [_chartView removeFromSuperview] ;
        _chartView = nil ;
    }
    
    _chartView = [[SelfChartView alloc] initWithList:dataList] ;
    _chartView.hidden = YES ;
    _chartView.transform = CGAffineTransformScale(_chartView.transform, 0.2, 0.2) ;

    [self.view.window addSubview:_chartView] ;

    [UIView transitionWithView:_chartView
                      duration:.25
                       options:UIViewAnimationOptionCurveEaseOut
                    animations:^{
                        
                        _chartView.hidden = NO ;
                        _chartView.transform = CGAffineTransformIdentity ;

                    } completion:^(BOOL finished) {
                        
                    }] ;

}

#pragma mark - Life

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"同比增长" ;
    self.textfield.delegate = self ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - touches Ended

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ( ![self.textfield isExclusiveTouch] )
    {
        [self.textfield resignFirstResponder] ;
    }
}

#pragma mark - UITextFieldDelegate

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.list_7days     = [@[] mutableCopy] ;
    self.list_30days    = [@[] mutableCopy] ;
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
