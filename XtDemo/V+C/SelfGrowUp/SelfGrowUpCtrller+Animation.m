//
//  SelfGrowUpCtrller+Animation.m
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SelfGrowUpCtrller+Animation.h"
#import "MMPulseView.h"

@implementation SelfGrowUpCtrller (Animation)

- (void)pulseViewWithMPV1:(MMPulseView *)bt1_pulseView
                     MPV2:(MMPulseView *)bt2_pulseView
                      bt1:(UIButton *)bt1
                      bt2:(UIButton *)bt2
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
    bt1_pulseView.center = bt1.center ;
    [bt1_pulseView startAnimation];
    [self.view bringSubviewToFront:bt1] ;
    
    bt2_pulseView.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    bt2_pulseView.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                             (__bridge id)[UIColor xt_mainColor].CGColor,
                             (__bridge id)[UIColor whiteColor].CGColor];
    bt2_pulseView.minRadius = 20;
    bt2_pulseView.maxRadius = 50;
    bt2_pulseView.duration = 3;
    bt2_pulseView.count = 1;
    bt2_pulseView.lineWidth = 9.0f;
    bt2_pulseView.center = bt2.center ;
    [bt2_pulseView startAnimation];
    [self.view bringSubviewToFront:bt2] ;
}

@end
