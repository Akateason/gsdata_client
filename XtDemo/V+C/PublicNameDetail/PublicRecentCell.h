//
//  PublicRecentCell.h
//  XtDemo
//
//  Created by teason on 16/3/30.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

static NSString *kPublicRecentCellIdentifier = @"PublicRecentCell" ;

typedef void(^BlockSeeButtonClick)(NSString *url);
typedef void(^BlockSevenDayButtonClick)(Article *article);

@interface PublicRecentCell : UITableViewCell

@property (nonatomic,strong) Article *article ;
@property (nonatomic,copy) BlockSeeButtonClick BlockSeeButton ;
@property (nonatomic,copy) BlockSevenDayButtonClick BlockSevenDayButton ;

+ (PublicRecentCell *)configureCellWithArticle:(Article *)article
                                         table:(UITableView *)table
                                     indexPath:(NSIndexPath *)indexPath
                                     seeButton:(BlockSeeButtonClick)block_seeButton
                                sevenDayButton:(BlockSevenDayButtonClick)block_sevenDayButton ;

@end
