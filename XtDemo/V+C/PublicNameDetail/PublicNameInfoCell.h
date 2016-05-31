//
//  PublicNameInfoCell.h
//  XtDemo
//
//  Created by teason on 16/3/30.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NicknameInfo.h"

static NSString *kPublicNameInfoCellIdentifier = @"PublicNameInfoCell" ;

@interface PublicNameInfoCell : UITableViewCell

@property (nonatomic,strong) NicknameInfo *nicknameInfo ;

+ (PublicNameInfoCell *)configureCell:(NicknameInfo *)info
                            withTable:(UITableView *)table ;

@end
