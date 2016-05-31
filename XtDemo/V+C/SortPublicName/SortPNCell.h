//
//  SortPNCell.h
//  XtDemo
//
//  Created by teason on 16/3/28.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *kSortPNCellIdentifier = @"SortPNCell" ;

@class Nickname ;

@interface SortPNCell : UITableViewCell

@property (nonatomic,strong) Nickname   *nick ;
@property (nonatomic)        NSInteger  queueNumber ;

+ (SortPNCell *)configureCellWithNick:(Nickname *)nick
                          queueNumber:(NSInteger)queueNumber
                                table:(UITableView *)table ;

@end
