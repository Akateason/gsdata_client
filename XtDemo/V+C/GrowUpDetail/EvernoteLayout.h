//
//  EvernoteLayout.h
//  XtDemo
//
//  Created by teason on 16/4/26.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat horizonallyPadding = 10. ;
static CGFloat verticallyPadding = 10. ;

#define screenWidth     [[UIScreen mainScreen] bounds].size.width
#define screenHeight    [[UIScreen mainScreen] bounds].size.height

#define cellWidth       screenWidth - 2 * horizonallyPadding

@interface EvernoteLayout : UICollectionViewFlowLayout

@end
