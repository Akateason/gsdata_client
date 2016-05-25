//
//  AdjustDeviceDirection.m
//  XtDemo
//
//  Created by TuTu on 16/5/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "AdjustDeviceDirection.h"

@implementation AdjustDeviceDirection

+ (void)adjustDirection:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:") ;
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]] ;
        [invocation setSelector:selector] ;
        [invocation setTarget:[UIDevice currentDevice]] ;
        int val = orientation ;
        [invocation setArgument:&val atIndex:2] ;
        [invocation invoke] ;
    }
}

@end
