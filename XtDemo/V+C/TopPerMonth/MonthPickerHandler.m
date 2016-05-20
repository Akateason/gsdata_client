//
//  MonthPickerHandler.m
//  XtDemo
//
//  Created by TuTu on 16/5/20.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "MonthPickerHandler.h"
#import "NSDate+Utilities.h"


@interface MonthPickerHandler () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    int     selectedMonth ;
}
@property (nonatomic,strong) NSArray *monthList ;

@end

@implementation MonthPickerHandler

#pragma mark - Public

- (void)handlePicker:(UIPickerView *)picker
{
    picker.delegate = self ;
    picker.dataSource = self ;

    selectedMonth = (int)[[NSDate date] month] ;
    
    [picker selectRow:selectedMonth
          inComponent:0
             animated:YES] ;
}

- (int)getCurrentSelectedMonth
{
    return selectedMonth ;
}

#pragma mark - Prop

- (NSArray *)monthList
{
    if (!_monthList)
    {
        _monthList = @[] ;
        NSMutableArray *tmpList = [@[] mutableCopy] ;
        for (int i = 0; i <= 12; i++)
        {
            NSString *str = (!i) ? @"全部" : [NSString stringWithFormat:@"%d月",i] ;
            [tmpList addObject:str] ;
        }
        _monthList = tmpList ;
    }
    
    return _monthList ;
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate;

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1 ;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.monthList count] ;
}

- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.monthList objectAtIndex:row] ;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ( (int)row > (int)[[NSDate date] month] ) {
        [pickerView selectRow:((int)[[NSDate date] month])
                  inComponent:0
                     animated:YES] ;
        return ;
    }

    selectedMonth = (int)row;
    NSLog(@"current month  %d",selectedMonth) ;
}


@end
