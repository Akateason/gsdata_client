//
//  SortItemCell.h
//  XtDemo
//
//  Created by teason on 16/3/23.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Article ;

static NSString *kSortItemCell = @"SortItemCell" ;

@interface SortItemCell : UITableViewCell

@property (nonatomic,strong) Article *article ;

- (void)cellOnTableView:(UITableView *)tableView
        didScrollOnView:(UIView *)view ;

+ (SortItemCell *)configureCellWithArticle:(Article *)article
                                 indexPath:(NSIndexPath *)indexPath
                                     table:(UITableView *)table ;
@end
