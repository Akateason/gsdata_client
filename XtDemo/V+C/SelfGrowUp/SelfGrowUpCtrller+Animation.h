//
//  SelfGrowUpCtrller+Animation.h
//  XtDemo
//
//  Created by teason on 16/5/6.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SelfGrowUpCtrller.h"
@class MMPulseView ;

@interface SelfGrowUpCtrller (Animation)

- (void)pulseViewWithMPV1:(MMPulseView *)bt1_pulseView
                     MPV2:(MMPulseView *)bt2_pulseView
                      bt1:(UIButton *)bt1
                      bt2:(UIButton *)bt2 ;

@end
