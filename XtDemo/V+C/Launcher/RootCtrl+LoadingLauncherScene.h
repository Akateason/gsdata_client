//
//  RootCtrl+LoadingLauncherScene.h
//  XtDemo
//
//  Created by teason on 16/3/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "RootCtrl.h"

@interface RootCtrl (LoadingLauncherScene)

/**
 *  REWRITE THIS FUNC IN viewWillAppear:
 */
- (void)modalIntoLauncherWithSegueIdentifier:(NSString *)identifier ;


@end
