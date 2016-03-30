//
//  DateSelectedView.h
//  XtDemo
//
//  Created by teason on 16/3/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateSelectedViewDelegate <NSObject>

- (void)doConfirmWithDate:(NSDate *)dateSelected way:(NSInteger)waySelected ;

@end

@interface DateSelectedView : UIView

@property (nonatomic,weak)      id <DateSelectedViewDelegate> delegate ;
@property (nonatomic,strong)    NSDate      *date ;
@property (nonatomic)           NSInteger   way ;

@end
