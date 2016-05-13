//
//  ArticleCtrller.m
//  XtDemo
//
//  Created by teason on 16/3/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "ArticleCtrller.h"
#import "UIColor+AllColors.h"
#import "OpenShareHeader.h"


@interface ArticleCtrller ()

@property (nonatomic,strong) UIButton *btShare ;

@end

@implementation ArticleCtrller

static const float kButtonSizeSideLength = 40. ;
static const float kFlex = 20. ;

- (UIButton *)btShare
{
    if (!_btShare)
    {
        _btShare = [[UIButton alloc] init] ;
        _btShare.backgroundColor = [UIColor xt_mainColor] ;
        _btShare.titleLabel.font = [UIFont systemFontOfSize:13.] ;
        [_btShare setTitle:@"分享" forState:0] ;
        [_btShare setTitleColor:[UIColor whiteColor] forState:0] ;
        _btShare.frame = CGRectMake(APP_WIDTH - kButtonSizeSideLength - kFlex,
                                    kButtonSizeSideLength - kFlex,
                                    kButtonSizeSideLength,
                                    kButtonSizeSideLength) ;
        _btShare.layer.cornerRadius = kButtonSizeSideLength / 2. ;
        [_btShare addTarget:self
                     action:@selector(btShareAction)
           forControlEvents:UIControlEventTouchUpInside] ;
        if (![_btShare superview]) {
            [self.view addSubview:_btShare] ;
        }
    }
    return _btShare ;
}

- (void)btShareAction
{
    OSMessage *msg = [[OSMessage alloc]init];
    msg.title = @"此链接来自速报酱内部工具";
    msg.link = self.urlStr;
    msg.image = [UIImage imageNamed:@"logo"] ;
    msg.thumbnail = [UIImage imageNamed:@"logo"] ;
    msg.multimediaType = OSMultimediaTypeNews;

    switch (1) {
        case 1:
            [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
                NSLog(@"微信分享到会话成功：\n%@",message);
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);
            }];
            break;
        case 2:
            [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
                NSLog(@"微信分享到朋友圈成功：\n%@",message);
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
            }];
            break;
        case 3:
            [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
                NSLog(@"微信分享到收藏成功：\n%@",message);
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到收藏失败：\n%@\n%@",error,message);
            }];
            break;
            
        default:
            break;
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    self.title = @"文章" ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    
    [self btShare] ;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews] ;
    
    if (!_btShare) return ;
    _btShare.frame = CGRectMake(APP_WIDTH - kButtonSizeSideLength - kFlex,
                                kButtonSizeSideLength - kFlex,
                                kButtonSizeSideLength,
                                kButtonSizeSideLength) ;
}

@end
