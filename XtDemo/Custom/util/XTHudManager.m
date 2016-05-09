//
//  TeaHudManager.m
//  SuBaoJiang
//
//  Created by apple on 15/6/2.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "XTHudManager.h"
#import "DigitInformation.h"
#import "NSObject+MKBlockTimer.h"

@implementation XTHudManager

#pragma mark --
#pragma mark - SHOW HUD
+ (void)showWordHudWithTitle:(NSString *)title
{
    [self showWordHudWithTitle:title delay:1.1f] ;
}

+ (void)showWordHudWithTitle:(NSString *)title
                       delay:(float)delay
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    HUD.detailsLabelText = title ;
    HUD.dimBackground = YES ;
    HUD.mode = MBProgressHUDModeText ;
    HUD.animationType = MBProgressHUDAnimationZoomIn ;
    [HUD hide:YES afterDelay:delay] ;
}

+ (void)showHudWhileExecutingBlock:(dispatch_block_t)block
                       AndComplete:(dispatch_block_t)complete
                     AndWithMinSec:(float)sec
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0) ;
    dispatch_async(queue, ^{
        
        __block unsigned int seconds = [self logTimeTakenToRunBlock:^{
            block();
        } withPrefix:@"result time"] ;
        
        float smallsec = seconds / 1000.0f ;
        if (sec > smallsec) {
            float stayTime = sec - smallsec ;
            dispatch_async(dispatch_get_main_queue(), ^() {
                sleep(stayTime) ;
                complete();
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^() {
                complete();
            });
        }
    });
}

@end
