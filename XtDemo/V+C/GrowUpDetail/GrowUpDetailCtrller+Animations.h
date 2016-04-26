//
//  GrowUpDetailCtrller+Animations.h
//  XtDemo
//
//  Created by teason on 16/4/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "GrowUpDetailCtrller.h"

@interface GrowUpDetailCtrller (Animations)

- (void)closeAnimationWithButton1:(UIButton *)button1
                          button2:(UIButton *)button2 ;

- (void)animationInViewDidAppearWithButton:(UIButton *)button
                               btDayChange:(UIButton *)btDayChange
                                leftCorner:(CGPoint)leftCorner
                                     table:(UIView *)table
                                completion:(void(^)(BOOL finished))completion ;


@end
