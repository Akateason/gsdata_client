//
//  PublicRecentCell.m
//  XtDemo
//
//  Created by teason on 16/3/30.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PublicRecentCell.h"

@interface PublicRecentCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb_headline;
@property (weak, nonatomic) IBOutlet UILabel *lb_title;
@property (weak, nonatomic) IBOutlet UILabel *lb_updateTiem;
@property (weak, nonatomic) IBOutlet UIButton *bt_see;
@property (weak, nonatomic) IBOutlet UIButton *bt_seven;

@end

@implementation PublicRecentCell

- (void)setArticle:(Article *)article
{
    _article = article ;
    
    _lb_title.text = article.title ;
    _lb_updateTiem.text = article.get_time ;
    _lb_headline.hidden = article.top != 1 ;
}

- (IBAction)btSeeOnClick:(id)sender
{
    self.BlockSeeButton(self.article.url) ;
}

- (IBAction)btSevenOnClick:(id)sender
{
    self.BlockSevenDayButton(self.article) ;
}

- (void)awakeFromNib
{
    // Initialization code
    _bt_see.layer.cornerRadius = _bt_see.frame.size.width / 2. ;
    _bt_seven.layer.cornerRadius = _bt_seven.frame.size.width / 2. ;
    
    _bt_see.backgroundColor = [UIColor xt_lightGreenColor] ;
    _bt_seven.backgroundColor = [UIColor xt_lightBlueColor] ;
    
    _lb_headline.layer.cornerRadius = _lb_headline.frame.size.width / 2. ;
    _lb_headline.layer.masksToBounds = YES ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
