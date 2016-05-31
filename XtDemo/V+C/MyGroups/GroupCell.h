//
//  GroupCell.h
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kGroupCell = @"GroupCell" ;

@class Group ;

@protocol GroupCellDelegate <NSObject>

- (void)toSeeMore:(Group *)group ;
- (void)toSorting:(Group *)group ;

@end

@interface GroupCell : UITableViewCell

@property (nonatomic, strong) Group                     *group ;
@property (nonatomic, weak)   id <GroupCellDelegate>    delegate ;

+ (GroupCell *)configureCellWithGroup:(Group *)group
                      delegateHandler:(id)handler
                                table:(UITableView *)table ;

@end
