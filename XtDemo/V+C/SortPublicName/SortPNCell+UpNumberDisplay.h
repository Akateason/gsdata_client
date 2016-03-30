//
//  SortPNCell+UpNumberDisplay.h
//  XtDemo
//
//  Created by teason on 16/3/29.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortPNCell.h"

@interface SortPNCell (UpNumberDisplay)

- (NSString *)getDisplayStringWithUpNumber:(NSInteger)integer ;

- (UIColor *)getColorWithUpNumber:(NSInteger)integer ;

@end
