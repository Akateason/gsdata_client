//
//  PublicNameCell.h
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Nickname ;

static NSString *kPublicNameCell = @"PublicNameCell" ;

@interface PublicNameCell : UITableViewCell

@property (nonatomic,strong) Nickname *nickName ;

+ (PublicNameCell *)configureCellWithNickname:(Nickname *)nickname
                                        table:(UITableView *)table
                                    indexPath:(NSIndexPath *)indexPath ;

@end
