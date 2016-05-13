//
//  AppDelegateInitial.m
//  GroupBuying
//
//  Created by TuTu on 15/12/24.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "AppDelegateInitial.h"
#import "KeyChainHeader.h"
#import "DigitInformation.h"
#import "OpenShareHeader.h"

//NSString *const UM_APPKEY       = @"565681dc67e58e4d0e00014d" ;
NSString *const WX_APPKEY       = @"wx85ebb55ba448b4b7" ;
NSString *const WX_APPSECRET    = @"11cd5581856c97ec0e5f909d72c1120a" ;

//NSString *const WB_APPKEY       = @"1634965927" ;
//NSString *const WB_APPSECRET    = @"360a37c962a65ee96b8b5189708c986e" ;
//NSString *const WB_REDIRECTURL  = @"http://sns.whalecloud.com/sina2/callback" ;

//NSString *const APPSTORE_APPID  = @"999705868" ;

@interface AppDelegateInitial ()

@property (nonatomic,strong) NSDictionary *launchOptions ;
@property (nonatomic,strong) UIApplication *application ;
@property (nonatomic,strong) UIWindow *window ;

@end

@implementation AppDelegateInitial

- (instancetype)initWithApplication:(UIApplication *)application
                            options:(NSDictionary *)launchOptions
                             window:(UIWindow *)window
{
    self = [super init];
    if (self)
    {
        self.application = application ;
        self.launchOptions = launchOptions ;
        self.window = window ;
    }
    return self;
}

- (void)setup
{
    // Setting My Style //
    [self setMyStyleWithWindow:self.window] ;
    
    // open share //
    [self openShareSetup] ;
}

- (void)openShareSetup
{
    [OpenShare connectWeiboWithAppKey:WB_APPKEY];
    [OpenShare connectWeixinWithAppId:WX_APPKEY];

}

- (void)setMyStyleWithWindow:(UIWindow *)window
{
    //1 status bar .
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent] ;
    [[UIApplication sharedApplication] keyWindow].tintColor = [UIColor xt_mainColor] ;
    
    //2 nav style .
    [[UINavigationBar appearance] setBarTintColor:[UIColor xt_mainColor]] ;
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}] ;
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]] ;
    [[UINavigationBar appearance] setBackgroundColor:[UIColor xt_mainColor]] ;
}

@end
