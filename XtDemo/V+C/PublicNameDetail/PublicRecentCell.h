//
//  PublicRecentCell.h
//  XtDemo
//
//  Created by teason on 16/3/30.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

typedef void(^BlockSeeButtonClick)(NSString *url);
typedef void(^BlockSevenDayButtonClick)(Article *article);

@interface PublicRecentCell : UITableViewCell

@property (nonatomic,strong) Article *article ;
@property (nonatomic,copy) BlockSeeButtonClick BlockSeeButton ;
@property (nonatomic,copy) BlockSevenDayButtonClick BlockSevenDayButton ;

@end
