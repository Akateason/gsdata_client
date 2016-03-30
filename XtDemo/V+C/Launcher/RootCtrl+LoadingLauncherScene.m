//
//  RootCtrl+LoadingLauncherScene.m
//  XtDemo
//
//  Created by teason on 16/3/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "RootCtrl+LoadingLauncherScene.h"

@implementation RootCtrl (LoadingLauncherScene)

/**
 *  REWRITE THIS FUNC IN viewWillAppear:
 */
- (void)modalIntoLauncherWithSegueIdentifier:(NSString *)identifier
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        [self performSegueWithIdentifier:identifier sender:nil] ; // jump to prepare for segue .
    }) ;
}

@end
