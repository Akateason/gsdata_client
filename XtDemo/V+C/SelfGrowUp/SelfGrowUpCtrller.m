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
#import "XTBubbleTransition.h"
#import "GrowUpDetailCtrller.h"
#import "LoginNavCtrller.h"
#import "LoginHandler.h"
#import "User.h"
#import "NotificationCenterHeader.h"
#import "TopPerMonthController.h"
#import "AdjustDeviceDirection.h"

@interface SelfGrowUpCtrller () <UITextFieldDelegate,UIViewControllerTransitioningDelegate>
{
    MMPulseView *bt1_pulseView ;
    MMPulseView *bt2_pulseView ;
    
    NSArray     *m_moreList ;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbt_articlePerMonth;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbt_login;
@property (nonatomic,strong) NSMutableArray *list_7days ;
@property (nonatomic,strong) NSMutableArray *list_30days ;

@property (nonatomic,strong) SelfChartView  *chartView ;

@property (nonatomic,strong) XTBubbleTransition *transition ;

@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *btYue;
@property (weak, nonatomic) IBOutlet UIButton *btZhou;
@property (weak, nonatomic) IBOutlet UIButton *btMore;

@end

@implementation SelfGrowUpCtrller

#pragma mark - Prop

- (XTBubbleTransition *)transition
{
    if (!_transition) {
        _transition = [[XTBubbleTransition alloc] init] ;
    }
    return _transition ;
}

- (NSMutableArray *)list_7days
{
    if (!_list_7days)
    {
        _list_7days = [@[] mutableCopy] ;

        ResultParsered *result = [ServerRequest syncFetchNickNameOrderList3Days:self.textfield.text num:7] ;
        // ResultParsered *result = [ServerRequest syncFetchNickNameOrderList3DaysWX:@"zhepen" num:7] ;
        if ([result.returnCode integerValue] != 1001) return _list_7days ;
        NSDictionary *dicResult = result.returnData ;
        NSArray *list = dicResult[@"items"] ;
        for (NSDictionary *tmpDic in list) {
            Nickname *nick = [Nickname yy_modelWithJSON:tmpDic] ;
            if ([nick.wx_name isEqualToString:@"ribenliuxrb"]) {
                continue ;
            }
            [_list_7days addObject:nick] ;
        }
    }
    return _list_7days ;
}

- (NSMutableArray *)list_30days
{
    if (!_list_30days)
    {
        _list_30days = [@[] mutableCopy] ;
        
        ResultParsered *result = [ServerRequest syncFetchNickNameOrderList3Days:self.textfield.text num:30] ;
        if ([result.returnCode integerValue] != 1001) return _list_30days ;
        NSDictionary *dicResult = result.returnData ;
        NSArray *list = dicResult[@"items"] ;
        for (NSDictionary *tmpDic in list) {
            Nickname *nick = [Nickname yy_modelWithJSON:tmpDic] ;
            if ([nick.wx_name isEqualToString:@"ribenliuxrb"]) {
                continue ;
            }
            [_list_30days addObject:nick] ;
        }
    }
    return _list_30days ;
}

#pragma mark - Action

- (IBAction)bbtArticlesPerMonth:(id)sender
{
    [self performSegueWithIdentifier:@"index2topPerMonth" sender:nil] ;
}

- (IBAction)bbtLoginOnClick:(id)sender
{
     // 退出登录 . ?
    if ([LoginHandler userHasLogin]) {
        UIAlertController *alertCtrller = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗?!"
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert] ;
        [alertCtrller addAction:[UIAlertAction actionWithTitle:@"确认退出"
                                                         style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [LoginHandler logout] ;
                                                           _bbt_login.title = @"登录" ;
                                                       }]] ;
        [alertCtrller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]] ;
        [self presentViewController:alertCtrller animated:YES completion:^{}] ;
    }
    else {
        [LoginNavCtrller modalToLoginNavCtrllerWithOrignalCtrller:self] ;
    }
}

- (IBAction)btZhouOnclick:(id)sender
{
    m_moreList = self.list_7days ;
    
    [self showChartWithButton:sender data:m_moreList] ;
}

- (IBAction)btYueOnclick:(id)sender
{
    m_moreList = self.list_30days ;
    
    [self showChartWithButton:sender data:m_moreList] ;
}

#pragma mark - Chart 

- (void)showChartWithButton:(UIButton *)button data:(NSArray *)dataList
{
    if (!dataList.count) return ;
 
    [AdjustDeviceDirection adjustDirection:UIInterfaceOrientationLandscapeRight] ;
    
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

#pragma mark - Notification

- (void)afterLoginNotificationSend
{
    [self setupUIs] ;
    self.list_7days = nil ;
    self.list_30days = nil ;
    m_moreList = self.list_7days ;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup] ;
    [self setupUIs] ;
    
    self.title = @"我" ;
    self.textfield.delegate = self ;
    m_moreList = self.list_7days ;
}

- (void)setupUIs
{
    if ([LoginHandler userHasLogin]) _bbt_login.title = ((User *)[LoginHandler getCurrentUserInCache]).userName ;
    _textfield.text = [LoginHandler getNicknameString] ;
}

- (void)setup
{
    self.tabBarController.tabBar.tintColor = [UIColor xt_blackColor] ; //[UIColor xt_mainBlueColor] ;
    _btYue.layer.cornerRadius = _btYue.frame.size.width / 2. ;
    _btZhou.layer.cornerRadius = _btZhou.frame.size.width / 2. ;
    _btMore.layer.cornerRadius = _btMore.frame.size.width / 2. ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    
    [self modalIntoLauncher] ;
    
    [self refreshPulseView] ;
    
    if (![LoginHandler userHasLogin]) {
        [LoginNavCtrller modalToLoginNavCtrllerWithOrignalCtrller:self] ;
    }
}

- (void)viewDidLayoutSubviews
{
    [self refreshPulseView] ;
    
    [self.view bringSubviewToFront:self.btMore] ;
}

- (void)refreshPulseView
{
    if (bt1_pulseView || bt2_pulseView)
    {
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


- (void)didReceiveMemoryWarning
{
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

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.transition.transitionMode = XTBubbleTransitionModePresent;
    self.transition.startPoint = self.btMore.center;
    self.transition.bubbleColor = self.btMore.backgroundColor;
    return self.transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.transition.transitionMode = XTBubbleTransitionModeDismiss ;
    self.transition.startPoint = self.btMore.center;
    self.transition.bubbleColor = self.btMore.backgroundColor;
    return self.transition;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"rank2detail"])
    {
        GrowUpDetailCtrller *controller = segue.destinationViewController ;
        controller.transitioningDelegate = self ;
        controller.modalPresentationStyle = UIModalPresentationCustom ;
        controller.dataList = m_moreList ;
    }
//    else if ([segue.identifier isEqualToString:@"index2topPerMonth"])
//    {
//        
//    }
    
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES] ;
}

@end
