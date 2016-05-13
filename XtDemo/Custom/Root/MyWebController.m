//
//  MyWebController.m
//  JGB
//
//  Created by JGBMACMINI01 on 14-9-10.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "MyWebController.h"
#import "WordsHeader.h"
#import "CommonFunc.h"
#import "DigitInformation.h"
#import "XTTickConvert.h"

@interface MyWebController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView ;

@end

@implementation MyWebController

#pragma mark -

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr ;
    
    [self startLoadingWebview] ;
}

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds] ;
        _webView.autoresizesSubviews = YES ;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
        
        _webView.delegate = self ;
        if (![_webView superview]) {
            [self.view addSubview:_webView] ;
        }
    }
    
    return _webView ;
}

- (void)startLoadingWebview
{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]] ;
    [self.webView loadRequest:request];
}

#pragma mark - 

- (void)forward
{
    [self.webView goForward];
}

- (void)back
{
    [self.webView goBack];
}

- (void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES] ;
}

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self webView] ;
    
    UIBarButtonItem *lItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(back)] ;
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(forward)] ;
    
    self.navigationItem.rightBarButtonItems = @[rItem,lItem] ;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark - web view delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//判断用户点击类型
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /*
    NSURL *tempUrl = request.URL ;
    NSString *absoluteStr = [tempUrl absoluteString] ;
    NSLog(@"url str : %@", absoluteStr) ;

    if ([absoluteStr isEqualToString:@"http://m.jgb.cn/"])
    {
        //去登录, app登录成功后, 登录h5
        if (G_TOKEN == nil || [G_TOKEN isEqualToString:@""])
        {
            [NavRegisterController goToLoginFirstWithCurrentController:self AppLoginFinished:YES] ;
        }
        
        return NO ;
    }
    
    switch (navigationType)
    {
            //点击连接
        case UIWebViewNavigationTypeLinkClicked:
        {
            NSLog(@"clicked");
            
            if (!tempUrl) return YES ;
            
            NSString *sepStr = @"?sku=" ;
            
            if ([[absoluteStr componentsSeparatedByString:sepStr] count] <= 1) {
                return YES ;
            }
            
            NSString *goodsCode = [[absoluteStr componentsSeparatedByString:sepStr] lastObject];
            
            [self goIntoGoodsDetail:goodsCode] ;

            return NO ;
        }
            break ;
            //提交表单
        case UIWebViewNavigationTypeFormSubmitted:
        {
            NSLog(@"submitted");
        }
            break ;
        default:
            break;
    }
    
    return YES;
*/
    return YES ;
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
