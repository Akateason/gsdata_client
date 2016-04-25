//
//  GrowUpDetailCtrller+Animations.m
//  XtDemo
//
//  Created by teason on 16/4/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "GrowUpDetailCtrller+Animations.h"

@implementation GrowUpDetailCtrller (Animations)

static float const kTransitionAnimationDuration = 0.65 ;

- (void)closeAnimationWithButton1:(UIButton *)button1
                          button2:(UIButton *)button2
{
    [UIView animateWithDuration:kTransitionAnimationDuration
                     animations:^{
                         
//                         button1.transform = CGAffineTransformIdentity ;
                         button1.center = CGPointMake(APP_WIDTH / 2, APP_HEIGHT / 2) ;
                         button2.alpha = 0 ;
                         
                     }
                     completion:^(BOOL finished) {
                         button1.hidden = YES ;
                         [self dismissViewControllerAnimated:YES completion:nil] ;
                         
                     }] ;
}

//static float const kButtonOriginFlex = 5. ;

- (void)animationInViewDidAppearWithButton:(UIButton *)button
                               btDayChange:(UIButton *)btDayChange
                                leftCorner:(CGPoint)leftCorner
                                     table:(UITableView *)table
                                completion:(void(^)(BOOL finished))completion
{
    
    [UIView animateWithDuration:kTransitionAnimationDuration
                     animations:^{
                         
                         button.center = leftCorner ;
                         button.transform = CGAffineTransformRotate(button.transform, M_PI_4 * 3.) ;
                         
                     } completion:^(BOOL finished) {
                         
                         [UIView transitionWithView:btDayChange
                                           duration:.1
                                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut
                                         animations:^{
                                             
                                             btDayChange.alpha = 1 ;
                                             
                                         } completion:^(BOOL finished) {
                                             
                                             [self fadeinTableView:table completion:^(BOOL finished) {
                                                 
                                                 if (completion) {
                                                     completion(finished) ;
                                                 }

                                             }] ;
                                             
                                         }] ;
                         
                     }] ;
}

- (void)fadeinTableView:(UITableView *)table
             completion:(void(^)(BOOL finished))completion
{
    [UIView transitionWithView:table
                      duration:.3
                       options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlUp
                    animations:^{
                        table.hidden = NO ;
                    } completion:^(BOOL finished) {
                        if (completion) {
                            completion(finished) ;
                        }
                    }] ;
}


@end
