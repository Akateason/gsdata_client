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
#import "RootCtrl+LoadingLauncherScene.h"
#import "MMPulseView.h"


@interface SelfGrowUpCtrller () <UITextFieldDelegate>
{
    MMPulseView *bt1_pulseView ;
    MMPulseView *bt2_pulseView ;
}
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
    
    self.title = @"我" ;
    self.textfield.delegate = self ;
    self.tabBarController.tabBar.tintColor = [UIColor darkGrayColor] ;

    _btYue.layer.cornerRadius = _btYue.frame.size.width / 2. ;
    _btZhou.layer.cornerRadius = _btZhou.frame.size.width / 2. ;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
    [self modalIntoLauncher] ;
    
    [self pulseView] ;
}


- (void)viewDidLayoutSubviews
{
    [self pulseView] ;
}


- (void)pulseView
{
//    
    if (bt1_pulseView || bt2_pulseView) {
        [bt1_pulseView stopAnimation] ;
        [bt1_pulseView removeFromSuperview] ;
        bt1_pulseView = nil ;
        
        [bt2_pulseView stopAnimation] ;
        [bt2_pulseView removeFromSuperview] ;
        bt2_pulseView = nil ;
    }
    
    if (!bt1_pulseView || !bt2_pulseView)
    {
        bt1_pulseView = [MMPulseView new] ;
        bt1_pulseView.frame = CGRectMake(0,0,200,200);
        [self.view addSubview:bt1_pulseView];
        
        bt2_pulseView = [MMPulseView new] ;
        bt2_pulseView.frame = CGRectMake(0,0,200,200);
        [self.view addSubview:bt2_pulseView];
    }
    
    bt1_pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bt1_pulseView.colors = @[(__bridge id)[UIColor xt_lightGreenColor].CGColor,
                             (__bridge id)[UIColor xt_mainColor].CGColor,
                             (__bridge id)[UIColor xt_lightGreenColor].CGColor];
    bt1_pulseView.minRadius = 20;
    bt1_pulseView.maxRadius = 50;
    bt1_pulseView.duration = 5;
    bt1_pulseView.count = 6;
    bt1_pulseView.lineWidth = 1.0f;
    bt1_pulseView.center = self.btZhou.center ;
    [bt1_pulseView startAnimation];
    [self.view bringSubviewToFront:self.btZhou] ;
//
    bt2_pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bt2_pulseView.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                             (__bridge id)[UIColor xt_mainColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor];
    bt2_pulseView.minRadius = 20;
    bt2_pulseView.maxRadius = 50;
    bt2_pulseView.duration = 3;
    bt2_pulseView.count = 1;
    bt2_pulseView.lineWidth = 9.0f;
    bt2_pulseView.center = self.btYue.center ;
    [bt2_pulseView startAnimation];
    [self.view bringSubviewToFront:self.btYue] ;
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
