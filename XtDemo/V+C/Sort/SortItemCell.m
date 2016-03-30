//
//  SortItemCell.m
//  XtDemo
//
//  Created by teason on 16/3/23.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "SortItemCell.h"
#import "Article.h"

@interface SortItemCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_updateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbYue;
@property (weak, nonatomic) IBOutlet UILabel *lb_readcount;
@property (weak, nonatomic) IBOutlet UILabel *lb_wxName;
@property (weak, nonatomic) IBOutlet UILabel *lb_engName;
@property (weak, nonatomic) IBOutlet UILabel *lb_author;
@property (weak, nonatomic) IBOutlet UILabel *lbZan;
@property (weak, nonatomic) IBOutlet UILabel *lb_likeCount;

@end

@implementation SortItemCell

- (void)awakeFromNib {
    // Initialization code
    
    _lbYue.layer.cornerRadius = _lbYue.frame.size.width / 2. ;
    _lbYue.layer.masksToBounds = YES ;
    _lbZan.layer.cornerRadius = _lbZan.frame.size.width / 2. ;
    _lbZan.layer.masksToBounds = YES ;
    
    _lbYue.backgroundColor = [UIColor xt_lightBlueColor] ;
    _lbZan.backgroundColor = [UIColor xt_lightGreenColor] ;
}

- (void)setArticle:(Article *)article
{
    _article = article ;
    
    // set UIs
    _lb_title.text = article.title ;
    _lb_updateTime.text = article.posttime ;
    _lb_wxName.text = article.wx_nickname ;
    _lb_engName.text = article.wx_name ;
    _lb_author.text = article.author ;
    _lb_readcount.text = [NSString stringWithFormat:@"%@",@(article.readnum)] ;
    _lb_likeCount.text = [NSString stringWithFormat:@"%@",@(article.likenum)] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
