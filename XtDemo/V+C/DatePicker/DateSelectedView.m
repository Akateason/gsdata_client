//
//  DateSelectedView.m
//  XtDemo
//
//  Created by teason on 16/3/25.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "DateSelectedView.h"
#import "HZQDatePickerView.h"
#import "NSDate+Utilities.h"
#import "XTTickConvert.h"

@interface DateSelectedView () <HZQDatePickerViewDelegate>
{
    HZQDatePickerView *_pikerView;
}
@property (weak, nonatomic) IBOutlet UIButton *bt_endTime;
@property (weak, nonatomic) IBOutlet UILabel *lb_endtime;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_way;
@property (weak, nonatomic) IBOutlet UILabel *lb_way;
@property (weak, nonatomic) IBOutlet UIButton *btConfirm;

@end

@implementation DateSelectedView

- (void)awakeFromNib
{
    _bt_endTime.layer.borderColor = [UIColor xt_lightGreenColor].CGColor ;
    _bt_endTime.layer.borderWidth = 1. ;
    _bt_endTime.layer.cornerRadius = 5. ;
    
    _segment_way.hidden = YES ;
}

- (void)setDate:(NSDate *)date
{
    _date = date ;

    [_bt_endTime setTitle:[XTTickConvert getStrWithNSDate:date
                                            AndWithFormat:TIME_STR_FORMAT_YY_MM_DD]
                 forState:0] ;
    
}

- (IBAction)endTimeClick:(id)sender {
    [self setupDateView:DateTypeOfEnd];
}

- (IBAction)segmengValueChanged:(id)sender {
    UISegmentedControl *segment = sender ;
    self.way = segment.selectedSegmentIndex ;
}

- (IBAction)confirmClick:(id)sender {
    [self.delegate doConfirmWithDate:self.date
                                 way:self.way] ;
}

- (void)setupDateView:(DateType)type
{
    _pikerView = [HZQDatePickerView instanceDatePickerView];
    _pikerView.frame = CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    
    [_pikerView.datePickerView setMaximumDate:[NSDate dateYesterday]] ;
    [self addSubview:_pikerView];
}

- (void)getSelectDate:(NSString *)date type:(DateType)type
{
    self.date = [XTTickConvert getNSDateWithDateStr:date
                                      AndWithFormat:TIME_STR_FORMAT_YY_MM_DD] ;
    [_bt_endTime setTitle:date forState:0] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
