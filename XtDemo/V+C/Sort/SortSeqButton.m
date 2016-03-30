//
//  SortSeqButton.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortSeqButton.h"

@implementation SortSeqButton

- (void)setSort:(SortCondition *)sort
{
    _sort = sort ;
    
    [self setTitle:[sort title] forState:UIControlStateNormal] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
