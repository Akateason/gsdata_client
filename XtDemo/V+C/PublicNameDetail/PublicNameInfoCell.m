//
//  PublicNameInfoCell.m
//  XtDemo
//
//  Created by teason on 16/3/30.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "PublicNameInfoCell.h"

@interface PublicNameInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *lb_Name;
@property (weak, nonatomic) IBOutlet UILabel *lb_engName;
@property (weak, nonatomic) IBOutlet UILabel *lb_introduction;
@property (weak, nonatomic) IBOutlet UILabel *lb_vipNote;

@end

@implementation PublicNameInfoCell

+ (PublicNameInfoCell *)configureCell:(NicknameInfo *)info
                            withTable:(UITableView *)table
{
    PublicNameInfoCell *cell = [table dequeueReusableCellWithIdentifier:kPublicNameInfoCellIdentifier] ;
    if (!cell) {
        cell = [table dequeueReusableCellWithIdentifier:kPublicNameInfoCellIdentifier] ;
    }
    cell.nicknameInfo = info ;
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;

}

- (void)setNicknameInfo:(NicknameInfo *)nicknameInfo
{
    _nicknameInfo = nicknameInfo ;
    
    _lb_Name.text = nicknameInfo.wx_nickname ;
    _lb_engName.text = nicknameInfo.wx_name ;
    _lb_introduction.text = nicknameInfo.wx_note ;
    _lb_vipNote.text = nicknameInfo.wx_vip_note ;
}

- (void)awakeFromNib
{
    // Initialization code
    self.backgroundColor = [UIColor xt_halfMainColor] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
