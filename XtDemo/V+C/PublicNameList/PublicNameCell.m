//
//  PublicNameCell.m
//  XtDemo
//
//  Created by teason on 16/3/22.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PublicNameCell.h"
#import "Nickname.h"

@interface PublicNameCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_subName;
@property (weak, nonatomic) IBOutlet UILabel *lb_latestTitle;
@property (weak, nonatomic) IBOutlet UILabel *lb_latestUpdateTime;

@end

@implementation PublicNameCell

- (void)setNickName:(Nickname *)nickName
{
    _lb_name.text = nickName.wx_nickname ;
    _lb_subName.text = nickName.wx_name ;
    _lb_latestTitle.text = [NSString stringWithFormat:@"最近文章：\t%@",nickName.wx_title] ;
    _lb_latestUpdateTime.text = [NSString stringWithFormat:@"更新时间：\t%@",nickName.wx_url_posttime] ;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
