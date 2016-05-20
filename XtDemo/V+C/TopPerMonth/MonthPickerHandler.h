//
//  MonthPickerHandler.h
//  XtDemo
//
//  Created by TuTu on 16/5/20.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthPickerHandler : NSObject

- (void)handlePicker:(UIPickerView *)picker ;
- (int)getCurrentSelectedMonth ;

@end
